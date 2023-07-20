import 'package:classroom_app/features/course/presentation/widgets/forms/name_input.dart';
import 'package:formz/formz.dart';

class CreateCourseFormState with FormzMixin {
  final NameInput name;
  final String description;
  final FormzSubmissionStatus status;

  CreateCourseFormState({
    NameInput? name,
    this.description = '',
    this.status = FormzSubmissionStatus.initial,
  }) : name = name ?? NameInput.pure();

  CreateCourseFormState copyWith({
    NameInput? name,
    String? description,
    FormzSubmissionStatus? status,
  }) {
    return CreateCourseFormState(
        name: this.name,
        status: status ?? this.status,
        description: description ?? this.description);
  }

  @override
  List<FormzInput> get inputs => [name];
}
