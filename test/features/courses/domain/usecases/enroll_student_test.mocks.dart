// Mocks generated by Mockito 5.4.0 from annotations
// in classroom_app/test/features/courses/domain/usecases/enroll_student_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:classroom_app/core/entities/access_token.dart' as _i9;
import 'package:classroom_app/core/entities/course.dart' as _i7;
import 'package:classroom_app/core/entities/courses.dart' as _i6;
import 'package:classroom_app/core/error/failures.dart' as _i5;
import 'package:classroom_app/features/course/domain/entities/inscription.dart'
    as _i10;
import 'package:classroom_app/features/course/domain/entities/multi_enroll.dart'
    as _i11;
import 'package:classroom_app/features/course/domain/entities/new_course.dart'
    as _i8;
import 'package:classroom_app/features/course/domain/repositories/courses_repository.dart'
    as _i3;
import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [CoursesRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockCoursesRepository extends _i1.Mock implements _i3.CoursesRepository {
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Courses>> getCourses() =>
      (super.noSuchMethod(
        Invocation.method(
          #getCourses,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.Courses>>.value(
            _FakeEither_0<_i5.Failure, _i6.Courses>(
          this,
          Invocation.method(
            #getCourses,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, _i6.Courses>>.value(
                _FakeEither_0<_i5.Failure, _i6.Courses>(
          this,
          Invocation.method(
            #getCourses,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.Courses>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i7.Course>> postCourse({
    required _i8.NewCourse? newCourse,
    required _i9.AccessToken? accessToken,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #postCourse,
          [],
          {
            #newCourse: newCourse,
            #accessToken: accessToken,
          },
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i7.Course>>.value(
            _FakeEither_0<_i5.Failure, _i7.Course>(
          this,
          Invocation.method(
            #postCourse,
            [],
            {
              #newCourse: newCourse,
              #accessToken: accessToken,
            },
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, _i7.Course>>.value(
                _FakeEither_0<_i5.Failure, _i7.Course>(
          this,
          Invocation.method(
            #postCourse,
            [],
            {
              #newCourse: newCourse,
              #accessToken: accessToken,
            },
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i7.Course>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i10.Inscription>> enrollStudent({
    required _i10.Inscription? inscription,
    required _i9.AccessToken? accessToken,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #enrollStudent,
          [],
          {
            #inscription: inscription,
            #accessToken: accessToken,
          },
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, _i10.Inscription>>.value(
                _FakeEither_0<_i5.Failure, _i10.Inscription>(
          this,
          Invocation.method(
            #enrollStudent,
            [],
            {
              #inscription: inscription,
              #accessToken: accessToken,
            },
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, _i10.Inscription>>.value(
                _FakeEither_0<_i5.Failure, _i10.Inscription>(
          this,
          Invocation.method(
            #enrollStudent,
            [],
            {
              #inscription: inscription,
              #accessToken: accessToken,
            },
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i10.Inscription>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, void>> multiStudentsEnroll({
    required _i11.MultiEnroll? multiEnroll,
    required _i9.AccessToken? accessToken,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #multiStudentsEnroll,
          [],
          {
            #multiEnroll: multiEnroll,
            #accessToken: accessToken,
          },
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, void>>.value(
            _FakeEither_0<_i5.Failure, void>(
          this,
          Invocation.method(
            #multiStudentsEnroll,
            [],
            {
              #multiEnroll: multiEnroll,
              #accessToken: accessToken,
            },
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, void>>.value(
                _FakeEither_0<_i5.Failure, void>(
          this,
          Invocation.method(
            #multiStudentsEnroll,
            [],
            {
              #multiEnroll: multiEnroll,
              #accessToken: accessToken,
            },
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, void>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Courses>> enroledCourses(
          _i9.AccessToken? accessToken) =>
      (super.noSuchMethod(
        Invocation.method(
          #enroledCourses,
          [accessToken],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.Courses>>.value(
            _FakeEither_0<_i5.Failure, _i6.Courses>(
          this,
          Invocation.method(
            #enroledCourses,
            [accessToken],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, _i6.Courses>>.value(
                _FakeEither_0<_i5.Failure, _i6.Courses>(
          this,
          Invocation.method(
            #enroledCourses,
            [accessToken],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.Courses>>);
}
