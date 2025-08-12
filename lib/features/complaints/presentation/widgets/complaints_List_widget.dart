import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadup/core/public_widgets/loading_widget.dart';
import 'package:loadup/core/constant/text_styles.dart';
import 'package:loadup/core/helpers/spacing.dart';
import 'package:loadup/features/complaints/logic/cubit/complaints_cubit.dart';
import 'package:loadup/features/complaints/logic/cubit/update_complaint_cubit.dart';

class ComplaintsListWidget extends StatelessWidget {
  const ComplaintsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComplaintsCubit, ComplaintsState>(
      builder: (context, state) {
        if (state is ComplaintsLoading) {
          return const LoadingWidget();
        } else if (state is ComplaintsError) {
          return Center(child: Text(state.error));
        } else if (state is ComplaintsSuccess) {
          final complaintsCubit = context.read<ComplaintsCubit>();
          final complaints = state.complaintsModel.data;

          return Column(
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: complaints.length,
                separatorBuilder: (_, __) => verticalSpace(10),
                itemBuilder: (context, index) {
                  final complaint = complaints[index];
                  final updateCubit = context.read<UpdateComplaintsCubit>();

                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Shipment ID: ${complaint.shipmentId}",
                                style: AppTextStyles.font16BlackRegular),
                            IconButton(
                              icon: const Icon(Icons.edit, size: 20),
                              onPressed: () {
                                updateCubit
                                    .descriptionController.text = complaint
                                        .description ??
                                    ''; 

                                showDialog(
                                  context: context,
                                  builder: (dialogContext) {
                                    return AlertDialog(
                                      title: const Text('Edit Complaint'),
                                      content: Form(
                                        key: updateCubit.formKey,
                                        child: TextFormField(
                                          controller:
                                              updateCubit.descriptionController,
                                          maxLines: 3,
                                          validator: (value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return 'Description can\'t be empty';
                                            }
                                            return null;
                                          },
                                          decoration: const InputDecoration(
                                            labelText: 'Description',
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(dialogContext).pop(),
                                          child: const Text('Cancel'),
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            final success = await updateCubit
                                                .updatecomplaints(complaint.id);

                                            if (success) {
                                             
                                              Navigator.of(dialogContext).pop();
                                              context
                                                  .read<ComplaintsCubit>()
                                                  .getcomplaints();
                                            } else {
                                             
                                              ScaffoldMessenger.of(
                                                      dialogContext)
                                                  .showSnackBar(
                                                const SnackBar(
                                                    content: Text(
                                                        'Failed to update complaint')),
                                              );
                                            }
                                          },
                                          child: const Text('Update'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                        verticalSpace(6),
                        Text("Description: ${complaint.description}",
                            style: AppTextStyles.font14GreyRegular),
                        verticalSpace(6),
                        Text("Date: ${complaint.createdAt}",
                            style: AppTextStyles.font16BlackRegular),
                      ],
                    ),
                  );
                },
              ),
              verticalSpace(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: complaintsCubit.currentPage > 1
                        ? () => complaintsCubit.previousPage()
                        : null,
                    child: const Text("Previous"),
                  ),
                  Text("Page ${complaintsCubit.currentPage}"),
                  TextButton(
                    onPressed: () => complaintsCubit.nextPage(),
                    child: const Text("Next"),
                  ),
                ],
              ),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
