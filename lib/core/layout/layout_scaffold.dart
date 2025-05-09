import 'package:fixedfundsflows/core/utils/bottom_sheets.dart';
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
                      AppBottomSheets.showCreateContract(context);
                      break;
                    case 1:
                      AppBottomSheets.showCreateCategory(context);
                      break;
                    case 2:
                      AppBottomSheets.showCreateContract(context);
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
  }
}
