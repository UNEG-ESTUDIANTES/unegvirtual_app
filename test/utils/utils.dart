import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<http.Client>()])
import 'utils.mocks.dart';

/// Mocks a GET request with a [response] and [statusCode].
void mockGetResponse({
  required MockClient client,
  required String response,
  int statusCode = 200,
}) {
  when(
    client.get(any, headers: anyNamed('headers')),
  ).thenAnswer(
    (_) async => http.Response(response, statusCode),
  );
}

/// Mocks a POST request with a [response] and [statusCode].
void mockPostResponse({
  required MockClient client,
  required String response,
  int statusCode = 200,
}) {
  when(
    client.post(any, headers: anyNamed('headers'), body: anyNamed('body')),
  ).thenAnswer(
    (_) async => http.Response(response, statusCode),
  );
}

/// Mocks a GET request that throws an [Exception].
void mockGetException({
  required MockClient client,
  required Exception exception,
}) {
  when(client.get(any, headers: anyNamed('headers'))).thenThrow(exception);
}

/// Mocks a POST request that throws an [Exception].
void mockPostException({
  required MockClient client,
  required Exception exception,
}) {
  when(
    client.post(any, headers: anyNamed('headers'), body: anyNamed('body')),
  ).thenThrow(exception);
}
