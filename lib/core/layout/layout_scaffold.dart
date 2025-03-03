import 'package:fixedfundsflows/domain/destination.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Layoutscaffold extends StatelessWidget {
  const Layoutscaffold({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('LayoutScaffold'));

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: navigationShell,
        bottomNavigationBar: BottomAppBar(
          child: SizedBox(
            height: kBottomNavigationBarHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: NavigationBar(
                    labelBehavior:
                        NavigationDestinationLabelBehavior.alwaysHide,
                    selectedIndex: navigationShell.currentIndex,
                    onDestinationSelected: navigationShell.goBranch,
                    destinations: destinations
                        .map(
                          (destination) => NavigationDestination(
                            icon: Icon(
                              destination.icon,
                            ),
                            label: destination.label,
                            selectedIcon: Icon(
                              destination.icon,
                              color: Colors.white,
                            ),
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
}
