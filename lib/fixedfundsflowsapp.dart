import 'package:fixedfundsflows/application/services/app_start_service.dart';
import 'package:fixedfundsflows/core/localization/locale_provider.dart';
import 'package:fixedfundsflows/core/routing/router.dart';
import 'package:fixedfundsflows/core/theme/dark_theme.dart';
import 'package:fixedfundsflows/core/theme/light_theme.dart';
import 'package:fixedfundsflows/core/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FixedFundsFlowsApp extends ConsumerWidget {
  const FixedFundsFlowsApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(appStartServiceProvider).initializeHive();
    ref.read(appStartServiceProvider).initializeAppIfNeeded();
    final locale = ref.watch(localeNotifierProvider);

    return MaterialApp.router(
      locale: locale,
      supportedLocales: const [
        Locale('en'),
        Locale('de'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: LightTheme.theme,
      darkTheme: DarkTheme.theme,
      themeMode: ref.watch(themeNotifierProvider),
    );
  }
}
