import 'package:flutter/material.dart';

import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:unegvirtual_app/core/providers/page_state.dart';
import 'package:unegvirtual_app/core/services/notifications_service.dart';
import 'package:unegvirtual_app/features/course/domain/entities/new_course.dart';
import 'package:unegvirtual_app/features/course/domain/usecases/post_course.dart';
import 'package:unegvirtual_app/features/course/presentation/widgets/forms/description_input.dart';

import '../../../../core/providers/auth_provider.dart';
import '../providers/course_provider.dart';
import '../widgets/forms/create_course_form_state.dart';
import '../widgets/forms/name_input.dart';

class CreateCoursePage extends StatefulWidget {
  /// The page route name.
  static const routeName = 'new';

  const CreateCoursePage({Key? key}) : super(key: key);

  @override
  State<CreateCoursePage> createState() => _CreateCoursePageState();
}

class _CreateCoursePageState extends State<CreateCoursePage> {
  final _key = GlobalKey<FormState>();
  late CreateCourseFormState _state;
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;

  void _onNameChanged() {
    setState(() {
      _state = _state.copyWith(name: NameInput.dirty(_nameController.text));
    });
  }

  void _onDescriptionChanged() {
    setState(() {
      _state = _state.copyWith(
        description: DescriptionInput.dirty(_nameController.text),
      );
    });
  }

  void _resetForm() {
    _key.currentState!.reset();
    _nameController.clear();
    _descriptionController.clear();

    setState(() => _state = CreateCourseFormState());
  }

  Future<void> _onSubmit() async {
    if (!_key.currentState!.validate()) return;

    final auth = context.read<AuthProvider>().auth;

    if (auth == null) {
      NotificationsService.showSnackBar(
        'Debe estar autenticado para realizar la acción',
      );

      return;
    }

    setState(() {
      _state = _state.copyWith(status: FormzSubmissionStatus.inProgress);
    });

    final newCourse = NewCourse(
      name: _state.name.value,
      description: _state.description.value,
      teacherId: auth.user.id,
    );

    final postCourse = PostCourseParams(
      accessToken: auth.accessToken,
      newCourse: newCourse,
    );

    // Try to create the course.
    await context.read<CourseProvider>().postCourse(postCourse);

    if (!mounted) return;

    final courseProviderState = context.read<CourseProvider>().state;

    String snackBarMessage;

    // Change state and snackbar according to state.
    if (courseProviderState is Error) {
      _state = _state.copyWith(status: FormzSubmissionStatus.failure);
      snackBarMessage = courseProviderState.message;
    } else {
      _state = _state.copyWith(status: FormzSubmissionStatus.success);
      snackBarMessage = 'Curso creado con éxito';
    }

    setState(() {});

    FocusScope.of(context)
      ..nextFocus()
      ..unfocus();

    // Display the snackbar.
    NotificationsService.showSnackBar(snackBarMessage);

    // Navigates to main page.
    if (_state.status.isSuccess) {
      _resetForm();
      context.pop();
    }
  }

  @override
  void initState() {
    super.initState();

    _state = CreateCourseFormState();

    _nameController = TextEditingController(
      text: _state.name.value,
    )..addListener(_onNameChanged);

    _descriptionController = TextEditingController(
      text: _state.description.value,
    )..addListener(_onDescriptionChanged);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _key,
          child: Center(
            child: SizedBox(
              width: 450,
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Creación de Cursos',
                    style: textTheme.headlineSmall,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Crea un nuevo curso que enseñarás',
                    style: textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: 'ej: Matemáticas I',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      label: const Text('Nombre del curso'),
                    ),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    validator: (_) => _state.name.error?.text(),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    validator: (_) => _state.description.error?.text(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hintText: 'ej: Ciclo básico para cálculo',
                      label: const Text('Descripción'),
                    ),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  if (_state.status.isInProgress)
                    const CircularProgressIndicator()
                  else
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: _onSubmit,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.0,
                            vertical: 12.0,
                          ),
                          child: Text(
                            'Crear Curso',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
