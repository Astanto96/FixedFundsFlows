import 'package:fixedfundsflows/ui/overview/widgets/overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FixedFundsFlowsApp extends StatelessWidget {
  FixedFundsFlowsApp({super.key});

  final _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const OverviewScreen(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}
