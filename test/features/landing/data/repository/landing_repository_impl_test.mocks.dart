// Mocks generated by Mockito 5.4.0 from annotations
// in classroom_app/test/features/landing/data/repository/landing_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:classroom_app/core/network/network_info.dart' as _i6;
import 'package:classroom_app/features/landing/data/datasources/landing_remote_datasource_impl.dart'
    as _i4;
import 'package:classroom_app/features/landing/data/models/course_model.dart'
    as _i3;
import 'package:http/http.dart' as _i2;
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

class _FakeClient_0 extends _i1.SmartFake implements _i2.Client {
  _FakeClient_0(
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

/// A class which mocks [LandingRemoteDataSourceImpl].
///
/// See the documentation for Mockito's code generation for more information.
class MockLandingRemoteDataSourceImpl extends _i1.Mock
    implements _i4.LandingRemoteDataSourceImpl {
  @override
  _i2.Client get client => (super.noSuchMethod(
        Invocation.getter(#client),
        returnValue: _FakeClient_0(
          this,
          Invocation.getter(#client),
        ),
        returnValueForMissingStub: _FakeClient_0(
          this,
          Invocation.getter(#client),
        ),
      ) as _i2.Client);
  @override
  _i5.Future<_i3.CourseModel> getCourses() => (super.noSuchMethod(
        Invocation.method(
          #getCourses,
          [],
        ),
        returnValue: _i5.Future<_i3.CourseModel>.value(_FakeCourseModel_1(
          this,
          Invocation.method(
            #getCourses,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.CourseModel>.value(_FakeCourseModel_1(
          this,
          Invocation.method(
            #getCourses,
            [],
          ),
        )),
      ) as _i5.Future<_i3.CourseModel>);
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i6.NetworkInfo {
  @override
  _i5.Future<bool> get isConnected => (super.noSuchMethod(
        Invocation.getter(#isConnected),
        returnValue: _i5.Future<bool>.value(false),
        returnValueForMissingStub: _i5.Future<bool>.value(false),
      ) as _i5.Future<bool>);
}
