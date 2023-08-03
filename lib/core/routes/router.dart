import 'package:flutter/widgets.dart';

import 'package:go_router/go_router.dart';

import 'package:unegvirtual_app/core/pages/check_auth_page.dart';
import 'package:unegvirtual_app/core/widgets/scaffold_with_nested_navigation.dart';
import 'package:unegvirtual_app/features/auth/presentation/pages/forgot_page.dart';
import 'package:unegvirtual_app/features/auth/presentation/pages/login_page.dart';
import 'package:unegvirtual_app/features/course/presentation/pages/pages.dart';
import 'package:unegvirtual_app/features/landing/presentation/pages/landing_page.dart';
import 'package:unegvirtual_app/features/user/presentation/pages/register_page.dart';
import 'package:unegvirtual_app/features/user/presentation/pages/user_page.dart';
import 'package:unegvirtual_app/features/user/presentation/pages/users_page.dart';

// Private navigators.
final _rootNavigatorKey = GlobalKey<NavigatorState>();

final _shellNavigatorCoursesKey = GlobalKey<NavigatorState>(
  debugLabel: 'shellCourses',
);

final _shellNavigatorUsersKey = GlobalKey<NavigatorState>(
  debugLabel: 'shellUsers',
);

final _shellNavigatorProfileKey = GlobalKey<NavigatorState>(
  debugLabel: 'shellProfile',
);

/// The router.
final router = GoRouter(
  initialLocation: CheckAuthPage.routeName,
  debugLogDiagnostics: true,
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      path: CheckAuthPage.routeName,
      builder: (context, state) => const CheckAuthPage(),
    ),
    GoRoute(
      path: LandingPage.routeName,
      builder: (context, state) => const LandingPage(),
    ),
    GoRoute(
      path: LogInPage.routeName,
      builder: (context, state) => const LogInPage(),
    ),
    GoRoute(
      path: ForgotPasswordPage.routeName,
      builder: (context, state) => const ForgotPasswordPage(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorCoursesKey,
          routes: [
            GoRoute(
              path: CoursesPage.routeName,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: CoursesPage(),
              ),
              routes: [
                GoRoute(
                  path: CreateCoursePage.routeName,
                  builder: (context, state) => const CreateCoursePage(),
                )
              ],
            )
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorUsersKey,
          routes: [
            GoRoute(
              path: UsersPage.routeName,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: UsersPage(),
              ),
              routes: [
                GoRoute(
                  path: RegisterPage.routeName,
                  builder: (context, state) => const RegisterPage(),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorProfileKey,
          routes: [
            GoRoute(
              path: UserPage.routeName,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: UserPage(),
              ),
            ),
          ],
        ),
      ],
    )
  ],
);
