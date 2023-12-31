// Mocks generated by Mockito 5.4.0 from annotations
// in unegvirtual_app/test/features/user/domain/use_cases/create_user_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:unegvirtual_app/core/entities/access_token.dart' as _i6;
import 'package:unegvirtual_app/core/error/failures.dart' as _i5;
import 'package:unegvirtual_app/features/user/domain/entities/unsaved_user.dart'
    as _i7;
import 'package:unegvirtual_app/features/user/domain/repositories/user_repository.dart'
    as _i3;

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

/// A class which mocks [UserRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserRepository extends _i1.Mock implements _i3.UserRepository {
  @override
  _i4.Future<_i2.Either<_i5.Failure, void>> createUser({
    required _i6.AccessToken? accessToken,
    required _i7.UnsavedUser? unsavedUser,
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
        returnValue: _i4.Future<_i2.Either<_i5.Failure, void>>.value(
            _FakeEither_0<_i5.Failure, void>(
          this,
          Invocation.method(
            #createUser,
            [],
            {
              #accessToken: accessToken,
              #unsavedUser: unsavedUser,
            },
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, void>>.value(
                _FakeEither_0<_i5.Failure, void>(
          this,
          Invocation.method(
            #createUser,
            [],
            {
              #accessToken: accessToken,
              #unsavedUser: unsavedUser,
            },
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, void>>);
}
