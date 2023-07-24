import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'package:classroom_app/core/entities/access_token.dart';
import 'package:classroom_app/core/entities/user.dart';
import 'package:classroom_app/core/models/access_token_model.dart';
import 'package:classroom_app/core/models/user_model.dart';
import 'package:classroom_app/core/network/network_info.dart';
import 'package:classroom_app/features/user/data/data_sources/user_remote_data_source.dart';
import 'package:classroom_app/features/user/data/repositories/user_repository_impl.dart';

@GenerateNiceMocks([
  MockSpec<UserRemoteDataSource>(),
  MockSpec<NetworkInfo>(),
])
import '';

// void main() {
//   late MockUserRemoteDataSource mockUserRemoteDataSource;
//   late MockNetworkInfo mockNetworkInfo;
//   late UserRepositoryImpl repository;

//   setUp(() {
//     mockUserRemoteDataSource = MockUserRemoteDataSource();
//     mockNetworkInfo = MockNetworkInfo();

//     repository = UserRepositoryImpl(
//       remoteDataSource: mockUserRemoteDataSource,
//       networkInfo: mockNetworkInfo,
//     );
//   });

//   const tUserModel = UserModel(
//     id: 'test',
//     firstName: 'test',
//     lastName: 'test',
//     identityCard: 'test',
//     email: 'test',
//   );

//   const User tUser = tUserModel;
//   const tAccessTokenModel = AccessTokenModel('test');
//   const AccessToken tAccessToken = tAccessTokenModel;
// }
