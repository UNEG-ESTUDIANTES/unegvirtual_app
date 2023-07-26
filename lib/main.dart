import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:classroom_app/core/providers/auth_provider.dart';
import 'package:classroom_app/core/providers/user_provider.dart';
import 'package:classroom_app/core/routes/router.dart';
import 'package:classroom_app/core/services/notifications_service.dart';
import 'package:classroom_app/features/course/presentation/providers/course_provider.dart';
import 'package:classroom_app/features/course/presentation/providers/students_enrollment_provider.dart';
import 'package:classroom_app/features/home/presentation/provider/home_provider.dart';
import 'package:classroom_app/features/landing/presentation/providers/landing_provider.dart';
import 'package:classroom_app/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inject dependencies.
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.sl<AuthProvider>(),
        ),
        ChangeNotifierProvider<LandingProvider>(
          create: (_) => di.sl<LandingProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.sl<UserProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.sl<CourseProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.sl<HomeProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => StudentsEnrollmentProvider(),
        ),
      ],
      child: MaterialApp.router(
        title: 'UNEG Classroom',
        scaffoldMessengerKey: NotificationsService.messengerKey,
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.blue,
        ),
      ),
    );
  }
}
