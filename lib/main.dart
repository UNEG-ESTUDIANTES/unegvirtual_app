import 'package:flutter/material.dart';

import 'package:classroom_app/core/pages/main_page.dart';
import 'package:classroom_app/features/home/presentation/pages/home_page.dart';

import 'features/auth/presentation/pages/login_page.dart';
import 'features/course/presentation/pages/course_page.dart';
import 'features/landing/presentation/pages/landing_page.dart';
import 'features/user/presentation/pages/user_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UNEG Classroom',
      initialRoute: LogInPage.routeName,
      routes: {
        LandingPage.routeName: (_) => const LandingPage(),
        HomePage.routeName: (_) => const HomePage(),
        UserPage.routeName: (_) => const UserPage(),
        MainPage.routeName: (_) => const MainPage(),
        LogInPage.routeName: (_) => const LogInPage(),
        CoursePage.routeName: (_) => const CoursePage(),
      },
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
    );
  }
}
