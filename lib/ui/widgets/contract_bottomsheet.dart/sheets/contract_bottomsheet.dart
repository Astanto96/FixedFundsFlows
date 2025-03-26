import 'package:fixedfundsflows/core/theme/app_spacing.dart';
import 'package:fixedfundsflows/core/utils/billing_period.dart';
import 'package:fixedfundsflows/domain/category.dart';
import 'package:fixedfundsflows/ui/overview/viewmodel/overview_viewmodel.dart';
import 'package:fixedfundsflows/ui/widgets/contract_bottomsheet.dart/contract_viewmodel.dart';
import 'package:fixedfundsflows/ui/widgets/contract_bottomsheet.dart/sheets/contract_bottomsheet_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContractBottomsheet extends ConsumerStatefulWidget {
  const ContractBottomsheet({
    super.key,
  });

  @override
  _ContractBottomsheetState createState() => _ContractBottomsheetState();
}

class _ContractBottomsheetState extends ConsumerState<ContractBottomsheet> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(contractViewModelProvider.notifier).loadCategorys();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(contractViewModelProvider);
    final viewmodel = ref.watch(contractViewModelProvider.notifier);

    return Padding(
      padding: AppSpacing.padding24,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ContractBottomsheetHeader(title: 'Create Contract'),
              AppSpacing.sbh16,
              TextFormField(
                initialValue: state.description,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  helperText: '',
                ),
                onChanged: (value) {
                  viewmodel.updateDescription(value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Description is required';
                  }
                  return null;
                },
              ),
              AppSpacing.sbh16,
              DropdownButtonFormField<BillingPeriod>(
                value: state.selectedPeriod,
                decoration: const InputDecoration(labelText: 'Billing Period'),
                items: BillingPeriod.values
                    .map(
                      (period) => DropdownMenuItem(
                        value: period,
                        child: Text(period.toString().split('.').last),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    viewmodel.updatePeriod(value);
                  }
                },
              ),
              AppSpacing.sbh16,
              DropdownButtonFormField<Category>(
                value: state.selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  helperText: '',
                ),
                items: state.categories
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(category.description),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  viewmodel.updateCategory(value);
                },
              ),
              AppSpacing.sbh16,
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  helperText: '',
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  viewmodel.updateAmount(int.tryParse(value) ?? 0);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Amount is required';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Enter a valid number';
                  }
                  return null;
                },
              ),
              AppSpacing.sbh40,
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      viewmodel.saveContract();
                      ref
                          .read(overviewViewModelProvider.notifier)
                          .loadContractsForPeriod();
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//kurze gedanken dazu:
//Form auslagern, viewmodel etc bleibt ja gleich soweit
//bool mitgeben "isDetailsMode" um festzulegen ob als ContractDetails 
//oder CreateContracts verwendet wird
//entsprechend mechanismus "wenn flag gesetzt, dann zeige das"
//validation muss noch ins Viewmodel gezogen werden
//und das themetemplate entsprechend angepasst werden in den Themes