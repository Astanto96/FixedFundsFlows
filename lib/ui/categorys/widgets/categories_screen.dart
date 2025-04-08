import 'package:fixedfundsflows/ui/categorys/viewmodel/categories_viewmodel.dart';
import 'package:fixedfundsflows/ui/widgets/custom_global_snackbar.dart';
import 'package:fixedfundsflows/ui/widgets/delete_dialog.dart';
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
    final viewModel = ref.watch(categoriesViewmodelProvider.notifier);

    return SafeArea(
      child: ColoredBox(
        color: Theme.of(context).colorScheme.surface,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(
                16,
                24,
                16,
                16,
              ),
              child: Text(
                'Categories',
                style: TextStyle(fontSize: 20),
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
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    title: Text(category.description),
                    trailing: IconButton(
                      onPressed: () async {
                        final wantToDelete = await DeleteDialog.show(
                          context: context,
                          itemName: category.description,
                        );
                        if (!wantToDelete) {
                          return;
                        }
                        final success =
                            await viewModel.deleteCategory(category.id!);
                        if (!context.mounted) {
                          return;
                        }

                        CustomGlobalSnackBar.show(
                          context: context,
                          isItGood: success,
                          text: success
                              ? '${category.description} successfully deleted'
                              : 'Cannot delete category – it is still in use.',
                        );
                      },
                      icon: const Icon(Icons.delete_outline),
                    ),
                    onTap: () {
                      // show category details btmsheet
                    },
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
    );
  }
}
