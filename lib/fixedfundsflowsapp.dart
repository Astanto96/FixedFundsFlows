import 'package:fixedfundsflows/core/routing/router.dart';
import 'package:fixedfundsflows/core/theme/dark_theme.dart';
import 'package:fixedfundsflows/core/theme/light_theme.dart';
import 'package:fixedfundsflows/core/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FixedFundsFlowsApp extends ConsumerWidget {
  const FixedFundsFlowsApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: LightTheme.theme,
      darkTheme: DarkTheme.theme,
      themeMode: ref.watch(themeNotifierProvider),
    );
  }
}
