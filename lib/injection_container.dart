import 'dart:io';

import 'package:classroom_app/features/course/data/datasources/courses_remote_datasource.dart';
import 'package:classroom_app/features/course/data/repositories/courses_repository_impl.dart';
import 'package:classroom_app/features/course/domain/repositories/courses_repository.dart';
import 'package:classroom_app/features/course/domain/usecases/enroled_courses.dart';
import 'package:classroom_app/features/course/domain/usecases/enroll_student.dart';
import 'package:classroom_app/features/course/domain/usecases/get_courses.dart';
import 'package:classroom_app/features/course/domain/usecases/post_course.dart';
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
import 'package:classroom_app/features/landing/presentation/providers/landing_provider.dart';
import 'package:classroom_app/features/user/data/data_sources/user_local_data_source.dart';
import 'package:classroom_app/features/user/data/data_sources/user_remote_data_source.dart';
import 'package:classroom_app/features/user/data/repositories/user_repository_impl.dart';
import 'package:classroom_app/features/user/domain/repositories/user_repository.dart';
import 'package:classroom_app/features/user/domain/use_cases/get_current_user.dart';
import 'package:classroom_app/features/user/presentation/providers/user_provider.dart';
import 'package:classroom_app/features/course/presentation/providers/create_course_provider.dart';

import 'features/course/domain/usecases/multi_students_enroll.dart';

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
  sl.registerLazySingleton(() => LandingProvider(getCourses: sl()));

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

  //* Features - User.
  // Providers.
  sl.registerLazySingleton(() => UserProvider(getCurrentUserUseCase: sl()));

  // Use Cases.
  sl.registerLazySingleton(() => GetCurrentUser(sl()));

  // Repository.
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      localDataSource: sl(),
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources.
  sl.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSourceImpl(database: sl()),
  );

  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(client: sl()),
  );

  //* Features - Courses.
  // Providers.
  sl.registerLazySingleton(() => CreateCourseProvider(postCourse: sl()));

  // Use Cases.
  sl.registerLazySingleton(() => CoursesGetCourses(sl()));
  sl.registerLazySingleton(() => PostCourse(sl()));
  sl.registerLazySingleton(() => EnrollStudent(sl()));
  sl.registerLazySingleton(() => MultiStudentsEnroll(sl()));
  sl.registerLazySingleton(() => EnroledCourses(sl()));

  // Repository.
  sl.registerLazySingleton<CoursesRepository>(
    () => CoursesRepositoryImpl(
      network: sl(),
      remote: sl(),
    ),
  );

  sl.registerLazySingleton<CoursesRemoteDataSource>(
    () => CoursesRemoteDataSourceImpl(client: sl()),
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
