import 'package:flutter/widgets.dart';

import 'package:go_router/go_router.dart';

import 'package:classroom_app/core/pages/check_auth_page.dart';
import 'package:classroom_app/features/auth/presentation/pages/forgot_page.dart';
import 'package:classroom_app/features/auth/presentation/pages/login_page.dart';
import 'package:classroom_app/features/home/presentation/pages/home_page.dart';
import 'package:classroom_app/features/landing/presentation/pages/landing_page.dart';
import 'package:classroom_app/features/user/presentation/pages/register_page.dart';
import 'package:classroom_app/features/user/presentation/pages/user_page.dart';
import 'package:classroom_app/features/user/presentation/pages/users_page.dart';

// Private navigators.
final _shellNavigatorHomeKey = GlobalKey<NavigatorState>(
  debugLabel: 'shellHome',
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
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorHomeKey,
          routes: [
            GoRoute(
              path: HomePage.routeName,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: HomePage(),
              ),
            ),
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
