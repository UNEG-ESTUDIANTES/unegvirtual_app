// Mocks generated by Mockito 5.4.0 from annotations
// in classroom_app/test/features/user/data/repositories/user_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:unegvirtual_app/core/entities/access_token.dart' as _i4;
import 'package:unegvirtual_app/core/network/network_info.dart' as _i6;
import 'package:unegvirtual_app/features/user/data/data_sources/user_remote_data_source.dart'
    as _i2;
import 'package:unegvirtual_app/features/user/data/models/unsaved_user_model.dart'
    as _i5;
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

/// A class which mocks [UserRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserRemoteDataSource extends _i1.Mock
    implements _i2.UserRemoteDataSource {
  @override
  _i3.Future<void> createUser({
    required _i4.AccessToken? accessToken,
    required _i5.UnsavedUserModel? unsavedUser,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #createUser,
          [],
          {
            #accessToken: accessToken,
            #unsavedUser: unsavedUser,
          },
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i6.NetworkInfo {
  @override
  _i3.Future<bool> get isConnected => (super.noSuchMethod(
        Invocation.getter(#isConnected),
        returnValue: _i3.Future<bool>.value(false),
        returnValueForMissingStub: _i3.Future<bool>.value(false),
      ) as _i3.Future<bool>);
}
