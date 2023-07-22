import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:classroom_app/core/entities/access_token.dart';

import '../../../../core/entities/courses.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/use_cases/use_case.dart';
import '../repositories/home_repository.dart';

class HomeEnroledCourses implements UseCase<Courses, AccessToken> {
  final HomeRepository repository;

  HomeEnroledCourses(this.repository);

  @override
  Future<Either<Failure, Courses>> call(AccessToken accessToken) async {
    return repository.enroledCourses(accessToken);
  }
}

class HomeEnroledCoursesParams extends Equatable {
  final AccessToken accessToken;

  const HomeEnroledCoursesParams({
    required this.accessToken,
  });

  @override
  List<Object> get props => throw UnimplementedError();
}
