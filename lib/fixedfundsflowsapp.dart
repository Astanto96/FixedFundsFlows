import 'package:fixedfundsflows/core/routing/router.dart';
import 'package:flutter/material.dart';

class FixedFundsFlowsApp extends StatelessWidget {
  const FixedFundsFlowsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
