import 'package:flutter/material.dart';

import 'features/home/presentation/pages/home_page.dart';
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
      initialRoute: UserPage.routeName,
      routes: {
        HomePage.routeName: (_) => const HomePage(),
        UserPage.routeName: (_) => const UserPage()
      },
      theme: ThemeData(useMaterial3: true),
    );
  }
}
