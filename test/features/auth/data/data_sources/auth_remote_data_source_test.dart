// import 'dart:convert';

// import 'package:flutter_test/flutter_test.dart';
// import 'package:http/http.dart' as http;
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';

// import 'package:classroom_app/core/env/env.dart';
// import 'package:classroom_app/core/error/exceptions.dart';
// import 'package:classroom_app/core/models/access_token_model.dart';
// import 'package:classroom_app/features/auth/data/data_sources/auth_remote_data_source.dart';
// import 'package:classroom_app/features/auth/data/models/user_credentials_model.dart';

// import '../../../../fixtures/fixture_reader.dart';

// @GenerateNiceMocks([MockSpec<http.Client>()])
// import 'auth_remote_data_source_test.mocks.dart';

// void main() {
//   late MockClient client;
//   late AuthRemoteDataSourceImpl dataSourceImpl;

//   setUp(() {
//     client = MockClient();
//     dataSourceImpl = AuthRemoteDataSourceImpl(client: client);
//   });

//   const tAccessTokenModel = AccessTokenModel('test');

//   const tUserCredentialsModel = UserCredentialsModel(
//     email: 'test',
//     password: 'test',
//   );

//   group('login', () {
//     void setUpMockHttpClientSuccess200() {
//       when(
//         client.post(
//           any,
//           headers: anyNamed('headers'),
//           body: anyNamed('body'),
//         ),
//       ).thenAnswer(
//         (_) async => http.Response(
//           fixture('access_token.json'),
//           200,
//         ),
//       );
//     }

//     void setUpMockHttpClientError401() {
//       when(
//         client.post(
//           any,
//           headers: anyNamed('headers'),
//           body: anyNamed('body'),
//         ),
//       ).thenAnswer(
//         (_) async => http.Response(
//           'Invalid Credentials',
//           401,
//         ),
//       );
//     }

//     void setUpMockHttpClientGeneralError() {
//       when(
//         client.post(
//           any,
//           headers: anyNamed('headers'),
//           body: anyNamed('body'),
//         ),
//       ).thenAnswer(
//         (_) async => http.Response(
//           'Unknown Error',
//           500,
//         ),
//       );
//     }

//     void setUpMockHttpClientError404() {
//       when(
//         client.post(
//           any,
//           headers: anyNamed('headers'),
//           body: anyNamed('body'),
//         ),
//       ).thenAnswer(
//         (_) async => http.Response(
//           'User not found',
//           404,
//         ),
//       );
//     }

//     test(
//       '''should perform a POST request with the user 
//       credentials and with the application/json header''',
//       () async {
//         // arrange
//         setUpMockHttpClientSuccess200();

//         // act
//         dataSourceImpl.login(tUserCredentialsModel);

//         // assert
//         verify(
//           client.post(
//             Uri.parse('${Env.appUrl}/v1/login'),
//             headers: {
//               'Content-Type': 'application/json',
//             },
//             body: json.encode(tUserCredentialsModel.toJson()),
//           ),
//         );
//       },
//     );

//     test(
//       'should return AccessTokenModel when status code is 200 (success)',
//       () async {
//         // arrange
//         setUpMockHttpClientSuccess200();

//         // act
//         final result = await dataSourceImpl.login(tUserCredentialsModel);

//         // assert
//         expect(result, tAccessTokenModel);
//       },
//     );

//     test(
//       'should throw a UserCredentialsMismatchException when status code is 401',
//       () async {
//         // arrange
//         setUpMockHttpClientError401();

//         // act
//         final call = dataSourceImpl.login;

//         // assert
//         expect(
//           () => call(tUserCredentialsModel),
//           throwsA(const TypeMatcher<UserCredentialsMismatchException>()),
//         );
//       },
//     );

//     test(
//       'should throw a UserNotFoundException when status code is 404',
//       () async {
//         // arrange
//         setUpMockHttpClientError404();

//         // act
//         final call = dataSourceImpl.login;

//         // assert
//         expect(
//           () => call(tUserCredentialsModel),
//           throwsA(const TypeMatcher<UserNotFoundException>()),
//         );
//       },
//     );

//     test(
//       'should throw a ServerException when status code is other than 200 and 401',
//       () async {
//         // arrange
//         setUpMockHttpClientGeneralError();

//         // act
//         final call = dataSourceImpl.login;

//         // assert
//         expect(
//           () => call(tUserCredentialsModel),
//           throwsA(const TypeMatcher<ServerException>()),
//         );
//       },
//     );

//     test(
//       'should throw a ServerException when the call throws a ClientException',
//       () async {
//         // arrange
//         when(
//           client.post(
//             any,
//             headers: anyNamed('headers'),
//             body: anyNamed('body'),
//           ),
//         ).thenThrow(http.ClientException(''));

//         // act
//         final call = dataSourceImpl.login;

//         // assert
//         expect(
//           () => call(tUserCredentialsModel),
//           throwsA(const TypeMatcher<ServerException>()),
//         );
//       },
//     );
//   });
// }
