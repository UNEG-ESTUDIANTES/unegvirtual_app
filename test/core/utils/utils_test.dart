import 'package:flutter_test/flutter_test.dart';

import 'package:classroom_app/core/error/failures.dart';
import 'package:classroom_app/core/utils/utils.dart';

class UnkwownFailure extends Failure {
  @override
  List<Object> get props => [];
}

void main() {
  group('getErrorMessage', () {
    test(
      'should display the user credentials mismatch message',
      () async {
        // arrange
        final failure = UserCredentialsMismatchFailure();

        // act
        final result = Utils.getErrorMessage(failure);

        // assert
        expect(result, userCredentialsMismatchMessage);
      },
    );

    test(
      'should display the not found message',
      () async {
        // arrange
        final failure = NotFoundFailure();

        // act
        final result = Utils.getErrorMessage(failure);

        // assert
        expect(result, notFoundMessage);
      },
    );

    test(
      'should display the server failure message',
      () async {
        // arrange
        final failure = ServerFailure();

        // act
        final result = Utils.getErrorMessage(failure);

        // assert
        expect(result, serverFailureMessage);
      },
    );

    test(
      'should display the cache failure message',
      () async {
        // arrange
        final failure = CacheFailure();

        // act
        final result = Utils.getErrorMessage(failure);

        // assert
        expect(result, cacheFailureMessage);
      },
    );

    test(
      'should display the user not found failure message',
      () async {
        // arrange
        final failure = UserNotFoundFailure();

        // act
        final result = Utils.getErrorMessage(failure);

        // assert
        expect(result, userNotFoundFailureMessage);
      },
    );

    test(
      'should display the unknown failure message',
      () async {
        // arrange

        final failure = UnkwownFailure();

        // act
        final result = Utils.getErrorMessage(failure);

        // assert
        expect(result, unknownFailureMessage);
      },
    );
  });
}
