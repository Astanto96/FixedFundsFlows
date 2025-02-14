import 'package:fixedfundsflows/ui/auth/viewmodel/auth_view_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authViewModelProvider);

// Authentifizierung nur einmal beim Start ausführen
    ref.listen<bool?>(authViewModelProvider, (previous, next) {
      if (next == true) {
        context.replace('/overview'); // Sicherer Aufruf ohne async gaps
      }
    });

    Future.microtask(() {
      if (authState == null || false) {
        ref.read(authViewModelProvider.notifier).authenticate();
      }
    });

    return const Center(
      child: Text("FixedFundsFlows"),
    );
  }
}
