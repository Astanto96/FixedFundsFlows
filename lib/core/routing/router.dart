import 'package:fixedfundsflows/ui/auth/widgets/auth_screen.dart';
import 'package:fixedfundsflows/ui/categorys/widgets/categorys_screen.dart';
import 'package:fixedfundsflows/ui/overview/widgets/overview_screen.dart';
import 'package:fixedfundsflows/ui/statistic/widgets/statistic_screen.dart';
import 'package:fixedfundsflows/ui/widgets/layout_scaffold.dart';
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
              path: '/categorys',
              builder: (context, state) => const CategorysScreen(),
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
