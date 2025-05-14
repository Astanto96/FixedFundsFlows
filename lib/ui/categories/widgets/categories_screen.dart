import 'package:fixedfundsflows/core/localization/app_localizations.dart';
import 'package:fixedfundsflows/ui/categories/viewmodel/categories_viewmodel.dart';
import 'package:fixedfundsflows/ui/statistic/viewmodel/statistic_viewmodel.dart';
import 'package:fixedfundsflows/ui/widgets/custom_global_snackbar.dart';
import 'package:fixedfundsflows/ui/widgets/delete_dialog.dart';
import 'package:fixedfundsflows/ui/widgets/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoriesScreen extends ConsumerStatefulWidget {
  const CategoriesScreen({super.key});

  @override
  ConsumerState<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends ConsumerState<CategoriesScreen> {
  @override
  void initState() {
    super.initState();
    // Schedule the load after the widget is built
    Future.microtask(() {
      ref.read(categoriesViewmodelProvider.notifier).loadCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    final categoriesState = ref.watch(categoriesViewmodelProvider);
    final categories = categoriesState.categories;
    final viewModel = ref.read(categoriesViewmodelProvider.notifier);
    final loc = ref.watch(appLocationsProvider);

    if (categoriesState.error != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        CustomGlobalSnackBar.show(
          context: context,
          isItGood: false,
          text: categoriesState.error!,
        );
        viewModel.clearError();
      });
    }
    return SafeArea(
      child: ColoredBox(
        color: Theme.of(context).colorScheme.surface,
        child: LoadingOverlay(
          isLoading: categoriesState.isLoading,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  24,
                  16,
                  16,
                ),
                child: Text(
                  loc.categories,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              Container(
                height: 1,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                color: Theme.of(context).colorScheme.secondary,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      title: Text(category.description),
                      trailing: IconButton(
                        onPressed: () async {
                          final wantToDelete = await DeleteDialog.show(
                              context: context,
                              itemName: category.description,
                              loc: loc);
                          if (!wantToDelete) {
                            return;
                          }
                          final success =
                              await viewModel.deleteCategory(category.id!);
                          ref
                              .read(statisticViewModelProvider.notifier)
                              .initializeStatisticState();

                          if (!context.mounted) {
                            return;
                          }

                          CustomGlobalSnackBar.show(
                            context: context,
                            isItGood: success,
                            text: success
                                ? loc.succDeleted(category.description)
                                : loc.cantDeleteCat,
                          );
                        },
                        icon: const Icon(Icons.delete_outline),
                      ),
                    );
                  },
                ),
              ),
              Container(
                height: 1,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
