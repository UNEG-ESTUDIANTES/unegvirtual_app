// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';

// import 'package:classroom_app/core/databases/db_provider.dart';
// import 'package:classroom_app/core/error/exceptions.dart';
// import 'package:classroom_app/core/models/access_token_model.dart';
// import 'package:classroom_app/features/auth/data/data_sources/auth_local_data_source.dart';

// @GenerateNiceMocks([MockSpec<DBProvider>()])
// import 'auth_local_data_source_test.mocks.dart';

// void main() {
//   late MockDBProvider mockDBProvider;
//   late AuthLocalDataSourceImpl dataSourceImpl;

//   setUp(() {
//     mockDBProvider = MockDBProvider();
//     dataSourceImpl = AuthLocalDataSourceImpl(database: mockDBProvider);
//   });

//   const tId = 1;
//   const tAccessTokenModel = AccessTokenModel('test');

//   group('cacheAccessToken', () {
//     test(
//       'should store the access token in the database',
//       () async {
//         // arrange
//         when(mockDBProvider.addToken(tAccessTokenModel))
//             .thenAnswer((_) async => tId);

//         // act
//         await dataSourceImpl.cacheAccessToken(tAccessTokenModel);

//         // assert
//         verify(mockDBProvider.addToken(tAccessTokenModel));
//       },
//     );

//     test(
//       'should remove the last token stored before adding new token',
//       () async {
//         // arrange
//         when(mockDBProvider.removeToken()).thenAnswer((_) async => tId);

//         when(mockDBProvider.addToken(tAccessTokenModel))
//             .thenAnswer((_) async => tId);

//         // act
//         await dataSourceImpl.cacheAccessToken(tAccessTokenModel);

//         // assert
//         verifyInOrder([
//           mockDBProvider.removeToken(),
//           mockDBProvider.addToken(
//             tAccessTokenModel,
//           )
//         ]);

//         verifyNoMoreInteractions(mockDBProvider);
//       },
//     );
//   });

//   group('getAccessToken', () {
//     test(
//       'should get the access token from the database',
//       () async {
//         // arrange
//         when(mockDBProvider.getToken())
//             .thenAnswer((_) async => tAccessTokenModel);

//         // act
//         final result = await dataSourceImpl.getAccessToken();

//         // assert
//         verify(mockDBProvider.getToken());
//         expect(result, tAccessTokenModel);
//       },
//     );

//     test(
//       'should throw NotFoundException if access token is not found',
//       () async {
//         // arrange
//         when(mockDBProvider.getToken()).thenAnswer((_) async => null);

//         // act
//         final call = dataSourceImpl.getAccessToken;

//         // assert
//         expect(() => call(), throwsA(const TypeMatcher<NotFoundException>()));
//       },
//     );
//   });
// }
