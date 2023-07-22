import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:classroom_app/core/pages/check_auth_page.dart';
import 'package:classroom_app/core/pages/main_page.dart';
import 'package:classroom_app/core/providers/auth_provider.dart';
import 'package:classroom_app/core/providers/user_provider.dart';
import 'package:classroom_app/core/services/notifications_service.dart';
import 'package:classroom_app/features/auth/presentation/pages/forgot_page.dart';
import 'package:classroom_app/features/course/presentation/pages/add_multi_students.dart';
import 'package:classroom_app/features/course/presentation/providers/course_provider.dart';
import 'package:classroom_app/features/course/presentation/providers/students_enrollment_provider.dart';
import 'package:classroom_app/features/home/presentation/pages/home_page.dart';
import 'package:classroom_app/features/landing/presentation/providers/landing_provider.dart';
import 'package:classroom_app/injection_container.dart' as di;

import 'features/auth/presentation/pages/login_page.dart';
import 'features/course/presentation/pages/course_page.dart';
import 'features/course/presentation/pages/create_course_page.dart';
import 'features/landing/presentation/pages/landing_page.dart';
import 'features/user/presentation/pages/user_page.dart';

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
          create: (_) => StudentsEnrollmentProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'UNEG Classroom',
        scaffoldMessengerKey: NotificationsService.messengerKey,
        initialRoute: CheckAuthPage.routeName,
        routes: {
          LandingPage.routeName: (_) => const LandingPage(),
          HomePage.routeName: (_) => const HomePage(),
          UserPage.routeName: (_) => const UserPage(),
          MainPage.routeName: (_) => const MainPage(),
          LogInPage.routeName: (_) => const LogInPage(),
          CheckAuthPage.routeName: (_) => const CheckAuthPage(),
          ForgotPasswordPage.routeName: (_) => const ForgotPasswordPage(),
          CoursePage.routeName: (_) => const CoursePage(),
          CreateCoursePage.routeName: (_) => const CreateCoursePage(),
          MultiStudentsEnrollPage.routeName: (_) =>
              const MultiStudentsEnrollPage(),
        },
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.blue,
        ),
      ),
    );
  }
}
