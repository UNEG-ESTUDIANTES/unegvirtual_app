import 'package:classroom_app/features/course/domain/entities/new_course.dart';
import 'package:classroom_app/features/course/domain/usecases/post_course.dart';
import 'package:classroom_app/features/user/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:provider/provider.dart';

import '../../../../core/pages/main_page.dart';
import '../../../../core/providers/auth_provider.dart';
import '../providers/create_course_provider.dart';
import '../widgets/forms/create_course_form_state.dart';
import '../widgets/forms/name_input.dart';

class CreateCoursePage extends StatefulWidget {
  /// The page route name.
  static const routeName = 'new-course';

  const CreateCoursePage({Key? key}) : super(key: key);

  @override
  State<CreateCoursePage> createState() => _CreateCoursePageState();
}

class _CreateCoursePageState extends State<CreateCoursePage> {
  final _key = GlobalKey<FormState>();
  late CreateCourseFormState _state;
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final createCourseProvider = context.watch<CreateCourseProvider>();

    void _onNameChanged() {
      setState(() {
        _state = _state.copyWith(name: NameInput.dirty(_nameController.text));
      });
    }

    void _resetForm() {
      _key.currentState!.reset();
      _nameController.clear();
      _descriptionController.clear();

      setState(() => _state = CreateCourseFormState());
    }

    void _navigateToMainPage() {
      Navigator.pushNamedAndRemoveUntil(
        context,
        MainPage.routeName,
        (route) => false,
      );
    }

    final authProviderState = context.read<AuthProvider>().state;

    Future<void> _onSubmit() async {
      if (!_key.currentState!.validate()) return;

      setState(() {
        _state = _state.copyWith(status: FormzSubmissionStatus.inProgress);
      });

      final userProviderState = context.read<UserProvider>().user!.id;

      NewCourse newCourse = NewCourse(
          name: _nameController.value.toString(),
          description: _descriptionController.value.toString(),
          teacherId: userProviderState);

      final authProviderState = context.read<AuthProvider>().accessToken!;

      PostCourseParams postCourse = PostCourseParams(
          accessToken: authProviderState, newCourse: newCourse);

      createCourseProvider.postCourse(postCourse);

      // Navigates to main page.
      if (_state.status.isSuccess) {
        _resetForm();
        _navigateToMainPage();
      }
    }

    @override
    void initState() {
      super.initState();

      _state = CreateCourseFormState();

      _nameController = TextEditingController(
        text: _state.name.value,
      )..addListener(_onNameChanged);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Curso'),
      ),
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor rellena el campo';
                      }
                      return null;
                    },
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
                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () {
                            if (_key.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Procesando...')),
                              );
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 24.0,
                              vertical: 12.0,
                            ),
                            child: Text(
                              'Guardar',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
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
