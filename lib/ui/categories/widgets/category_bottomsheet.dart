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
  Widget build(BuildContext context) {
    final state = ref.watch(categoryViewModelProvider);
    final viewmodel = ref.watch(categoryViewModelProvider.notifier);

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
                  const Center(
                    child: Text(
                      'Categories',
                      style: TextStyle(
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
                labelText: 'Description',
                helperText: '',
                errorText: state.descriptionError,
              ),
              onChanged: (value) => viewmodel.updateDescription(value),
            ),
            AppSpacing.sbh40,
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
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
                        text: '${state.description} successfully created',
                      );
                      Navigator.pop(context);
                    }
                  }
                },
                child: const Text('Create'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
