import 'package:fixedfundsflows/core/theme/app_spacing.dart';
import 'package:fixedfundsflows/core/utils/billing_period.dart';
import 'package:fixedfundsflows/domain/category.dart';
import 'package:fixedfundsflows/domain/contract.dart';
import 'package:fixedfundsflows/ui/overview/viewmodel/contract_viewmodel.dart';
import 'package:fixedfundsflows/ui/overview/viewmodel/overview_viewmodel.dart';
import 'package:fixedfundsflows/ui/overview/widgets/contract_bottomsheet_header.dart';
import 'package:fixedfundsflows/ui/widgets/contract_delete_dialog.dart';
import 'package:fixedfundsflows/ui/widgets/custom_global_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContractBottomsheet extends ConsumerStatefulWidget {
  final bool isDetailsMode;
  final Contract? contractForDetails;

  const ContractBottomsheet({
    super.key,
    required this.isDetailsMode,
    this.contractForDetails,
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
      final viewmodel = ref.read(contractViewModelProvider.notifier);
      viewmodel.loadCategories();

      if (widget.isDetailsMode && widget.contractForDetails != null) {
        viewmodel.initializeWithContract(widget.contractForDetails!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(contractViewModelProvider);
    final viewmodel = ref.watch(contractViewModelProvider.notifier);
    final contractForDetails = widget.contractForDetails;

    return Padding(
      padding: AppSpacing.padding24,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ContractBottomsheetHeader(
                title: widget.isDetailsMode
                    ? 'Contract Details'
                    : 'Create Contract',
                onDelete: widget.isDetailsMode && contractForDetails?.id != null
                    ? () async {
                        final userConsfirmed = await DeleteDialog.show(
                          context: context,
                          itemName: state.description,
                        );
                        if (!userConsfirmed) {
                          return;
                        }
                        final success = await viewmodel
                            .deleteContract(contractForDetails!.id!);
                        if (success) {
                          ref
                              .read(overviewViewModelProvider.notifier)
                              .loadContractsForPeriod();

                          if (context.mounted) {
                            CustomGlobalSnackBar.show(
                              context: context,
                              isItGood: true,
                              text:
                                  '${contractForDetails.description} successfully deleted',
                            );
                            Navigator.pop(context);
                          }
                        }
                      }
                    : null,
              ),
              AppSpacing.sbh16,
              TextFormField(
                initialValue: widget.isDetailsMode
                    ? contractForDetails?.description
                    : null,
                decoration: InputDecoration(
                  labelText: 'Description',
                  helperText: '',
                  errorText: state.descriptionError,
                ),
                onChanged: (value) {
                  viewmodel.updateDescription(value);
                },
              ),
              AppSpacing.sbh16,
              DropdownButtonFormField<BillingPeriod>(
                value: widget.isDetailsMode
                    ? contractForDetails?.billingPeriod
                    : state.selectedPeriod,
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
                value: contractForDetails?.category,
                decoration: InputDecoration(
                  labelText: 'Category',
                  helperText: '',
                  errorText: state.categoryError,
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
                initialValue: widget.isDetailsMode
                    ? contractForDetails?.amount.toString()
                    : null,
                decoration: InputDecoration(
                  labelText: 'Amount',
                  helperText: '',
                  errorText: state.amountError,
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  viewmodel.updateAmount(int.tryParse(value) ?? 0);
                },
              ),
              AppSpacing.sbh40,
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final success = await viewmodel.saveContract();
                    if (success) {
                      ref
                          .read(overviewViewModelProvider.notifier)
                          .loadContractsForPeriod();

                      if (context.mounted) {
                        if (widget.isDetailsMode) {
                          CustomGlobalSnackBar.show(
                            context: context,
                            isItGood: true,
                            text: '${state.description} successfully updated',
                          );
                        } else {
                          CustomGlobalSnackBar.show(
                            context: context,
                            isItGood: true,
                            text: '${state.description} successfully created',
                          );
                          Navigator.pop(context);
                        }
                      }
                    }
                  },
                  child: Text(widget.isDetailsMode ? 'Submit' : 'Create'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
