import 'package:fixedfundsflows/data/provider/hive_provider.dart';
import 'package:fixedfundsflows/domain/destination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class Layoutscaffold extends ConsumerWidget {
  const Layoutscaffold({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('LayoutScaffold'));

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hiveState = ref.watch(hiveInitProvider);

    return hiveState.when(
      loading: () {
        print("⏳ [LayoutScaffold] Warte auf Hive-Initialisierung...");
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      error: (error, stackTrace) {
        print("❌ [LayoutScaffold] Hive-Initialisierung fehlgeschlagen: $error");
        return Scaffold(
          body: Center(
            child: Text(
              'Fehler bei der Initialisierung: $error',
            ),
          ),
        );
      },
      data: (_) {
        print("✅ [LayoutScaffold] Hive ist bereit, UI wird geladen.");
        return Scaffold(
          body: navigationShell,
          bottomNavigationBar: BottomAppBar(
            child: SizedBox(
              height: kBottomNavigationBarHeight,
              child: Row(
                children: [
                  Expanded(
                    child: NavigationBar(
                      selectedIndex: navigationShell.currentIndex,
                      onDestinationSelected: navigationShell.goBranch,
                      destinations: destinations
                          .map(
                            (destination) => NavigationDestination(
                              icon: Icon(
                                destination.icon,
                              ),
                              label: destination.label,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      switch (navigationShell.currentIndex) {
                        case 0:
                          //Contract hinzufügen
                          break;
                        case 1:
                          //Category hinzufügen
                          break;
                        case 2:
                          //Contract hinzufügen
                          break;
                      }
                    },
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
