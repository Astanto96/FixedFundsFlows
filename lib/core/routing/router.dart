import 'package:fixedfundsflows/core/layout/layout_scaffold.dart';
import 'package:fixedfundsflows/ui/auth/widgets/auth_screen.dart';
import 'package:fixedfundsflows/ui/categories/widgets/categories_screen.dart';
import 'package:fixedfundsflows/ui/overview/widgets/overview_screen.dart';
import 'package:fixedfundsflows/ui/statistic/widgets/statistic_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/auth',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => Layoutscaffold(
        navigationShell: navigationShell,
      ),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/overview',
              builder: (context, state) => const OverviewScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/categories',
              builder: (context, state) => const CategoriesScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/statistic',
              builder: (context, state) => const StatisticScreen(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/auth',
      builder: (context, state) => const AuthScreen(),
    ),
  ],
);
