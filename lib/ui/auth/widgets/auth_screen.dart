import 'package:fixedfundsflows/core/theme/app_spacing.dart';
import 'package:fixedfundsflows/ui/auth/viewmodel/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authAsync = ref.watch(authViewModelProvider);
    final isLoading = authAsync.isLoading;
    final hasError = authAsync.hasError;

// Check if authentication was successful
// If so, schedule a navigation to '/overview' after the current frame
// Using addPostFrameCallback ensures this runs after the widget tree is stable
// The mounted check ensures the context is still valid (widget not disposed)
    if (authAsync.hasValue && authAsync.value == true) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          context.replace('/overview');
        }
      });
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SizedBox.expand(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("FixedFundsFlows",
              style: TextStyle(
                fontSize: 45,
                color: Theme.of(context).textTheme.displayLarge?.color,
              )),
          Text("Know where your money flows",
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).textTheme.displayLarge?.color,
              )),
          if (hasError)
            Text(
              "Authentication failed, please try again",
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
                fontSize: 12,
              ),
            ),
          if (!isLoading)
            Column(
              children: [
                AppSpacing.sbh40,
                IconButton(
                  iconSize: 50,
                  onPressed: () {
                    ref.read(authViewModelProvider.notifier).authenticate();
                  },
                  icon: const Icon(Icons.lock_open_rounded),
                ),
              ],
            ),
        ],
      )),
    );
  }
}
