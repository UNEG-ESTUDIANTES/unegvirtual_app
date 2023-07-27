import 'package:flutter_test/flutter_test.dart';

import 'package:unegvirtual_app/core/error/exceptions.dart';
import 'package:unegvirtual_app/core/error/failures.dart';
import 'package:unegvirtual_app/core/utils/utils.dart';

class UnkwownFailure extends Failure {
  @override
  List<Object> get props => [];
}

class ExceptionFailure {
  final Exception exception;
  final Failure failure;

  ExceptionFailure({
    required this.exception,
    required this.failure,
  });
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
      'should display the not authorized failure message',
      () async {
        // arrange
        final failure = NotAuthorizedFailure();

        // act
        final result = Utils.getErrorMessage(failure);

        // assert
        expect(result, notAuthorizedFailureMessage);
      },
    );

    test(
      'should display the not enrolled failure message',
      () async {
        // arrange
        final failure = NotEnrolledFailure();

        // act
        final result = Utils.getErrorMessage(failure);

        // assert
        expect(result, notEnrolledFailureMessage);
      },
    );

    test(
      'should display the email taken message',
      () async {
        // arrange
        final failure = EmailTakenFailure();

        // act
        final result = Utils.getErrorMessage(failure);

        // assert
        expect(result, emailTakenFailureMessage);
      },
    );

    test(
      'should display the no internet connection failure message',
      () async {
        // arrange
        final failure = NoInternetConnectionFailure();

        // act
        final result = Utils.getErrorMessage(failure);

        // assert
        expect(result, noInternetConnectionFailureMessage);
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

  final exceptionsWithFailure = <ExceptionFailure>[
    ExceptionFailure(
      exception: ServerException(),
      failure: ServerFailure(),
    ),
    ExceptionFailure(
      exception: CacheException(),
      failure: CacheFailure(),
    ),
    ExceptionFailure(
      exception: UserNotFoundException(),
      failure: UserNotFoundFailure(),
    ),
    ExceptionFailure(
      exception: NotFoundException(),
      failure: NotFoundFailure(),
    ),
    ExceptionFailure(
      exception: NoInternetConnectionException(),
      failure: NoInternetConnectionFailure(),
    ),
    ExceptionFailure(
      exception: UserCredentialsMismatchException(),
      failure: UserCredentialsMismatchFailure(),
    ),
    ExceptionFailure(
      exception: NotAuthorizedException(),
      failure: NotAuthorizedFailure(),
    ),
    ExceptionFailure(
      exception: NotEnrolledException(),
      failure: NotEnrolledFailure(),
    ),
    ExceptionFailure(
      exception: EmailTakenException(),
      failure: EmailTakenFailure(),
    ),
  ];

  group('getFailure', () {
    test(
      'should return the correct failure',
      () async {
        // assert
        for (final exceptionWithFailure in exceptionsWithFailure) {
          expect(
            Utils.getFailure(exceptionWithFailure.exception),
            exceptionWithFailure.failure,
          );
        }
      },
    );
  });
}
