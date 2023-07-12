// Mocks generated by Mockito 5.4.0 from annotations
// in classroom_app/test/features/auth/data/repositories/auth_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:classroom_app/core/models/access_token_model.dart' as _i2;
import 'package:classroom_app/core/network/network_info.dart' as _i7;
import 'package:classroom_app/features/auth/data/data_sources/auth_local_data_source.dart'
    as _i3;
import 'package:classroom_app/features/auth/data/data_sources/auth_remote_data_source.dart'
    as _i5;
import 'package:classroom_app/features/auth/domain/entities/user_credentials.dart'
    as _i6;
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

class _FakeAccessTokenModel_0 extends _i1.SmartFake
    implements _i2.AccessTokenModel {
  _FakeAccessTokenModel_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [AuthLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthLocalDataSource extends _i1.Mock
    implements _i3.AuthLocalDataSource {
  @override
  _i4.Future<_i2.AccessTokenModel> getAccessToken() => (super.noSuchMethod(
        Invocation.method(
          #getAccessToken,
          [],
        ),
        returnValue:
            _i4.Future<_i2.AccessTokenModel>.value(_FakeAccessTokenModel_0(
          this,
          Invocation.method(
            #getAccessToken,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.AccessTokenModel>.value(_FakeAccessTokenModel_0(
          this,
          Invocation.method(
            #getAccessToken,
            [],
          ),
        )),
      ) as _i4.Future<_i2.AccessTokenModel>);
  @override
  _i4.Future<void> cacheAccessToken(_i2.AccessTokenModel? accessToken) =>
      (super.noSuchMethod(
        Invocation.method(
          #cacheAccessToken,
          [accessToken],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}

/// A class which mocks [AuthRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthRemoteDataSource extends _i1.Mock
    implements _i5.AuthRemoteDataSource {
  @override
  _i4.Future<_i2.AccessTokenModel> login(
          _i6.UserCredentials? userCredentials) =>
      (super.noSuchMethod(
        Invocation.method(
          #login,
          [userCredentials],
        ),
        returnValue:
            _i4.Future<_i2.AccessTokenModel>.value(_FakeAccessTokenModel_0(
          this,
          Invocation.method(
            #login,
            [userCredentials],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.AccessTokenModel>.value(_FakeAccessTokenModel_0(
          this,
          Invocation.method(
            #login,
            [userCredentials],
          ),
        )),
      ) as _i4.Future<_i2.AccessTokenModel>);
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i7.NetworkInfo {
  @override
  _i4.Future<bool> get isConnected => (super.noSuchMethod(
        Invocation.getter(#isConnected),
        returnValue: _i4.Future<bool>.value(false),
        returnValueForMissingStub: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
}