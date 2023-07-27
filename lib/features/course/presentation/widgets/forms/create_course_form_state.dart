import 'package:formz/formz.dart';

import 'package:unegvirtual_app/features/course/presentation/widgets/forms/description_input.dart';
import 'package:unegvirtual_app/features/course/presentation/widgets/forms/name_input.dart';

class CreateCourseFormState with FormzMixin {
  final NameInput name;
  final DescriptionInput description;
  final FormzSubmissionStatus status;

  CreateCourseFormState({
    NameInput? name,
    this.description = const DescriptionInput.pure(),
    this.status = FormzSubmissionStatus.initial,
  }) : name = name ?? NameInput.pure();

  CreateCourseFormState copyWith({
    NameInput? name,
    DescriptionInput? description,
    FormzSubmissionStatus? status,
  }) {
    return CreateCourseFormState(
      name: name ?? this.name,
      status: status ?? this.status,
      description: description ?? this.description,
    );
  }

  @override
  List<FormzInput> get inputs => [name, description];
}
