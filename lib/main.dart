import 'package:flutter/material.dart';

import 'package:classroom_app/features/home/presentation/home_page.dart';

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
      title: 'Uneg',
      initialRoute: HomePage.routeName,
      routes: {
        LandingPage.routeName: (_) => const LandingPage(),
        HomePage.routeName: (_) => const HomePage(),
        UserPage.routeName: (_) => const UserPage(),
      },
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xffF2F2F2),
        colorSchemeSeed: Colors.blue,
      ),
    );
  }
}
