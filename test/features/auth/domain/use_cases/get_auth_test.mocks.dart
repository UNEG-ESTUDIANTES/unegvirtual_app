// Mocks generated by Mockito 5.4.0 from annotations
// in classroom_app/test/features/auth/domain/use_cases/get_auth_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:unegvirtual_app/core/entities/auth.dart' as _i6;
import 'package:unegvirtual_app/core/error/failures.dart' as _i5;
import 'package:unegvirtual_app/features/auth/domain/entities/user_credentials.dart'
    as _i7;
import 'package:unegvirtual_app/features/auth/domain/repository/auth_repository.dart'
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

/// A class which mocks [AuthRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthRepository extends _i1.Mock implements _i3.AuthRepository {
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Auth>> login(
          _i7.UserCredentials? userCredentials) =>
      (super.noSuchMethod(
        Invocation.method(
          #login,
          [userCredentials],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.Auth>>.value(
            _FakeEither_0<_i5.Failure, _i6.Auth>(
          this,
          Invocation.method(
            #login,
            [userCredentials],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, _i6.Auth>>.value(
                _FakeEither_0<_i5.Failure, _i6.Auth>(
          this,
          Invocation.method(
            #login,
            [userCredentials],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.Auth>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Auth>> getAuth() =>
      (super.noSuchMethod(
        Invocation.method(
          #getAuth,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.Auth>>.value(
            _FakeEither_0<_i5.Failure, _i6.Auth>(
          this,
          Invocation.method(
            #getAuth,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, _i6.Auth>>.value(
                _FakeEither_0<_i5.Failure, _i6.Auth>(
          this,
          Invocation.method(
            #getAuth,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.Auth>>);
}
