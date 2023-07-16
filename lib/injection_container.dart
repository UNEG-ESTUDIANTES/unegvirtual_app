import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:classroom_app/core/databases/db_provider.dart';
import 'package:classroom_app/core/network/network_info.dart';
import 'package:classroom_app/core/providers/auth_provider.dart';
import 'package:classroom_app/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:classroom_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:classroom_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:classroom_app/features/auth/domain/repository/auth_repository.dart';
import 'package:classroom_app/features/auth/domain/use_cases/get_access_token.dart';
import 'package:classroom_app/features/auth/domain/use_cases/login.dart';
import 'package:classroom_app/features/landing/data/datasources/landing_remote_datasource_impl.dart';
import 'package:classroom_app/features/landing/data/repositories/landing_repository_impl.dart';
import 'package:classroom_app/features/landing/domain/repositories/landing_repository.dart';
import 'package:classroom_app/features/landing/domain/usecases/get_courses.dart';
import 'package:classroom_app/features/landing/presentation/notifiers/landing_notifier.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //* Features - Auth.
  // Use Cases.
  sl.registerLazySingleton(() => GetAccessToken(sl()));
  sl.registerLazySingleton(() => Login(sl()));

  // Repository.
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      localDataSource: sl(),
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources.
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(database: sl()),
  );

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(client: sl()),
  );

  //* Features - Landing.
  // Providers.
  sl.registerLazySingleton(() => LandingNotifier(getCourses: sl()));

  // Use Cases.
  sl.registerLazySingleton(() => GetCourses(sl()));

  // Repository.
  sl.registerLazySingleton<LandingRepository>(
    () => LandingRepositoryImpl(
      remote: sl(),
      network: sl(),
    ),
  );

  // Data sources.
  sl.registerLazySingleton<LandingRemoteDataSource>(
    () => LandingRemoteDataSourceImpl(client: sl()),
  );

  //* Core
  // Providers.
  sl.registerFactory(
    () => AuthProvider(
      getAccessTokenUseCase: sl(),
      loginUseCase: sl(),
    ),
  );

  // Databases.
  if (Platform.isLinux || Platform.isWindows) {
    // Initialize FFI
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  // Path where is going to be stored the DB
  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  final path = join(documentsDirectory.path, 'classroom.db');

  sl.registerLazySingleton(() => DBProvider(path: path));
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //* External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
