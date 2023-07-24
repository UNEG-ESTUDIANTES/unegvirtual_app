import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';

import 'package:classroom_app/core/entities/access_token.dart';
import 'package:classroom_app/core/models/user_model.dart';
import 'package:classroom_app/features/user/data/data_sources/user_remote_data_source.dart';

@GenerateNiceMocks([MockSpec<http.Client>()])
import 'user_remote_data_source_test.mocks.dart';

void main() {
  late MockClient client;
  late UserRemoteDataSourceImpl dataSourceImpl;

  setUp(() {
    client = MockClient();
    dataSourceImpl = UserRemoteDataSourceImpl(client: client);
  });

  const tAccessToken = AccessToken('test');

  const tUserModel = UserModel(
    id: 'test',
    firstName: 'test',
    lastName: 'test',
    identityCard: 'test',
    email: 'test',
  );
}
