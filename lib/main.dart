import 'package:flutter/material.dart';

import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:provider/provider.dart';

import 'package:unegvirtual_app/core/providers/auth_provider.dart';
import 'package:unegvirtual_app/core/providers/user_provider.dart';
import 'package:unegvirtual_app/core/routes/router.dart';
import 'package:unegvirtual_app/core/services/notifications_service.dart';
import 'package:unegvirtual_app/core/theme/theme.dart';
import 'package:unegvirtual_app/features/course/presentation/providers/course_provider.dart';
import 'package:unegvirtual_app/features/course/presentation/providers/students_enrollment_provider.dart';
import 'package:unegvirtual_app/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inject dependencies.
  await di.init();

  // Turn off the # in the URLs on the web
  usePathUrlStrategy();

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
      child: MaterialApp.router(
        title: 'UNEG Virtual',
        scaffoldMessengerKey: NotificationsService.messengerKey,
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
      ),
    );
  }
}
