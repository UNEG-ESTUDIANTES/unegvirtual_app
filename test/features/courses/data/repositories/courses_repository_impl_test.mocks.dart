// Mocks generated by Mockito 5.4.0 from annotations
// in classroom_app/test/features/courses/data/repositories/courses_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:classroom_app/core/models/course_model.dart' as _i3;
import 'package:classroom_app/core/models/courses_model.dart' as _i2;
import 'package:classroom_app/core/network/network_info.dart' as _i10;
import 'package:classroom_app/features/course/data/datasources/courses_remote_datasource.dart'
    as _i5;
import 'package:classroom_app/features/course/data/models/inscription_model.dart'
    as _i4;
import 'package:classroom_app/features/course/domain/entities/inscription.dart'
    as _i8;
import 'package:classroom_app/features/course/domain/entities/multi_enroll.dart'
    as _i9;
import 'package:classroom_app/features/course/domain/entities/new_course.dart'
    as _i7;
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

class _FakeCoursesModel_0 extends _i1.SmartFake implements _i2.CoursesModel {
  _FakeCoursesModel_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeCourseModel_1 extends _i1.SmartFake implements _i3.CourseModel {
  _FakeCourseModel_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeInscriptionModel_2 extends _i1.SmartFake
    implements _i4.InscriptionModel {
  _FakeInscriptionModel_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [CoursesRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockCoursesRemoteDataSource extends _i1.Mock
    implements _i5.CoursesRemoteDataSource {
  @override
  _i6.Future<_i2.CoursesModel> getCourses() => (super.noSuchMethod(
        Invocation.method(
          #getCourses,
          [],
        ),
        returnValue: _i6.Future<_i2.CoursesModel>.value(_FakeCoursesModel_0(
          this,
          Invocation.method(
            #getCourses,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i6.Future<_i2.CoursesModel>.value(_FakeCoursesModel_0(
          this,
          Invocation.method(
            #getCourses,
            [],
          ),
        )),
      ) as _i6.Future<_i2.CoursesModel>);
  @override
  _i6.Future<_i3.CourseModel> postCourse(_i7.NewCourse? newCourse) =>
      (super.noSuchMethod(
        Invocation.method(
          #postCourse,
          [newCourse],
        ),
        returnValue: _i6.Future<_i3.CourseModel>.value(_FakeCourseModel_1(
          this,
          Invocation.method(
            #postCourse,
            [newCourse],
          ),
        )),
        returnValueForMissingStub:
            _i6.Future<_i3.CourseModel>.value(_FakeCourseModel_1(
          this,
          Invocation.method(
            #postCourse,
            [newCourse],
          ),
        )),
      ) as _i6.Future<_i3.CourseModel>);
  @override
  _i6.Future<_i4.InscriptionModel> enrollStudent(
          _i8.Inscription? inscription) =>
      (super.noSuchMethod(
        Invocation.method(
          #enrollStudent,
          [inscription],
        ),
        returnValue:
            _i6.Future<_i4.InscriptionModel>.value(_FakeInscriptionModel_2(
          this,
          Invocation.method(
            #enrollStudent,
            [inscription],
          ),
        )),
        returnValueForMissingStub:
            _i6.Future<_i4.InscriptionModel>.value(_FakeInscriptionModel_2(
          this,
          Invocation.method(
            #enrollStudent,
            [inscription],
          ),
        )),
      ) as _i6.Future<_i4.InscriptionModel>);
  @override
  _i6.Future<_i2.CoursesModel> enroledCourses(String? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #enroledCourses,
          [id],
        ),
        returnValue: _i6.Future<_i2.CoursesModel>.value(_FakeCoursesModel_0(
          this,
          Invocation.method(
            #enroledCourses,
            [id],
          ),
        )),
        returnValueForMissingStub:
            _i6.Future<_i2.CoursesModel>.value(_FakeCoursesModel_0(
          this,
          Invocation.method(
            #enroledCourses,
            [id],
          ),
        )),
      ) as _i6.Future<_i2.CoursesModel>);
  @override
  _i6.Future<void> multiStudentEnroll(_i9.MultiEnroll? multiEnroll) =>
      (super.noSuchMethod(
        Invocation.method(
          #multiStudentEnroll,
          [multiEnroll],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i10.NetworkInfo {
  @override
  _i6.Future<bool> get isConnected => (super.noSuchMethod(
        Invocation.getter(#isConnected),
        returnValue: _i6.Future<bool>.value(false),
        returnValueForMissingStub: _i6.Future<bool>.value(false),
      ) as _i6.Future<bool>);
}
