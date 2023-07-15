import 'package:classroom_app/features/landing/data/datasources/landing_remote_datasource_impl.dart';
import 'package:classroom_app/features/landing/data/repositories/landing_repository_impl.dart';
import 'package:classroom_app/features/landing/domain/repositories/landing_repository.dart';
import 'package:classroom_app/features/landing/presentation/notifiers/landing_notifier.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:http/http.dart' as http;

import 'core/network/network_info.dart';
import 'features/landing/domain/usecases/get_courses.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  //Register Search Feature complements
  sl.registerLazySingleton(() => GetCourses(sl()));
  sl.registerLazySingleton<LandingRepository>(
      () => LandingRepositoryImpl(remote: sl(), network: sl()));
  sl.registerLazySingleton<LandingRemoteDataSource>(
      () => LandingRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton(() => LandingRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => LandingNotifier(getCourses: sl()));
}
