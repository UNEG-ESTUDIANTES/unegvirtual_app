import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'features/home/presentation/pages/home_page.dart';

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
        initialRoute: 'home',
        routes: {
          'home': (_) => HomePage(),
        },
        theme: ThemeData(appBarTheme: const AppBarTheme(color: Colors.white)));
  }
}
