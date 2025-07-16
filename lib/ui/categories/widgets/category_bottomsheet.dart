import 'package:fixedfundsflows/core/localization/app_localizations.dart';
import 'package:fixedfundsflows/core/theme/app_spacing.dart';
import 'package:fixedfundsflows/ui/categories/viewmodel/categories_viewmodel.dart';
import 'package:fixedfundsflows/ui/categories/viewmodel/category_viewmodel.dart';
import 'package:fixedfundsflows/ui/statistic/viewmodel/statistic_viewmodel.dart';
import 'package:fixedfundsflows/ui/widgets/custom_global_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryBottomsheet extends ConsumerStatefulWidget {
  const CategoryBottomsheet({super.key});

  @override
  _CategoryBottomsheetState createState() => _CategoryBottomsheetState();
}

class _CategoryBottomsheetState extends ConsumerState<CategoryBottomsheet> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref
          .read(categoryViewModelProvider.notifier)
          .checkIfMaxCategoriesReached();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(categoryViewModelProvider);
    final viewmodel = ref.read(categoryViewModelProvider.notifier);
    final loc = ref.watch(appLocationsProvider);

    return Padding(
      padding: AppSpacing.padding24,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              height: 56,
              child: Stack(
                children: [
                  Center(
                    child: Text(
                      loc.categories,
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                  ),
                ],
              ),
            ),
            AppSpacing.sbh16,
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: loc.descripction,
                helperText: '',
                errorText: state.descriptionError,
              ),
              onChanged: (value) => viewmodel.updateDescription(value),
            ),
            AppSpacing.sbh40,
            Row(
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  color: state.isMaxCategoriesReached
                      ? Theme.of(context).colorScheme.error
                      : Theme.of(context).textTheme.bodyMedium?.color,
                  size: 14,
                ),
                AppSpacing.sbw8,
                Text(
                  state.isMaxCategoriesReached ? loc.maxReached24 : loc.maxIs24,
                  style: TextStyle(
                    fontSize: 12,
                    color: state.isMaxCategoriesReached
                        ? Colors.red
                        : Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: state.isMaxCategoriesReached
                    ? null
                    : () async {
                        final success = await viewmodel.saveCategory();
                        if (success) {
                          ref
                              .read(categoriesViewmodelProvider.notifier)
                              .loadCategories();
                          ref
                              .read(statisticViewModelProvider.notifier)
                              .initializeStatisticState();

                          if (context.mounted) {
                            CustomGlobalSnackBar.show(
                              context: context,
                              isItGood: true,
                              text: loc.succCreated(state.description),
                            );
                            Navigator.pop(context);
                          }
                        }
                      },
                child: Text(loc.create),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
