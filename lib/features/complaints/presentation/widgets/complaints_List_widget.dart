import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadup/core/public_widgets/loading_widget.dart';
import 'package:loadup/core/constant/text_styles.dart';
import 'package:loadup/core/helpers/spacing.dart';
import 'package:loadup/core/helpers/translation_extension.dart';
import 'package:loadup/features/complaints/logic/cubit/complaints_cubit.dart';
import 'package:loadup/features/complaints/logic/cubit/delete_complaint_cubit.dart';
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
                  final deleteCubit = context.read<DeleteComplaintCubit>();

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
                            Text(
                              "${context.tr("shipment_id")}: ${complaint.shipmentId}",
                              style: AppTextStyles.font16Bold(context),
                            ),
                            Row(
                              children: [
                                /// زر التعديل
                                IconButton(
                                  icon: const Icon(Icons.edit, size: 20),
                                  onPressed: () {
                                    updateCubit.descriptionController.text =
                                        complaint.description ?? '';

                                    showDialog(
                                      context: context,
                                      builder: (dialogContext) {
                                        return AlertDialog(
                                          title: Text(
                                              context.tr("edit_complaint")),
                                          content: Form(
                                            key: updateCubit.formKey,
                                            child: TextFormField(
                                              controller: updateCubit
                                                  .descriptionController,
                                              maxLines: 3,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.trim().isEmpty) {
                                                  return context
                                                      .tr("description_empty");
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                labelText:
                                                    context.tr("description"),
                                                border:
                                                    const OutlineInputBorder(),
                                              ),
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(dialogContext)
                                                      .pop(),
                                              child: Text(context.tr("cancel")),
                                            ),
                                            ElevatedButton(
                                              onPressed: () async {
                                                final success =
                                                    await updateCubit
                                                        .updatecomplaints(
                                                            complaint.id);

                                                if (success) {
                                                  Navigator.of(dialogContext)
                                                      .pop();
                                                  context
                                                      .read<ComplaintsCubit>()
                                                      .getcomplaints();
                                                } else {
                                                  ScaffoldMessenger.of(
                                                          dialogContext)
                                                      .showSnackBar(
                                                    SnackBar(
                                                        content: Text(context.tr(
                                                            "update_complaint_failed"))),
                                                  );
                                                }
                                              },
                                              child: Text(context.tr("update")),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),

                                /// زر الحذف
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      size: 20, color: Colors.red),
                                  onPressed: () async {
                                    final success = await deleteCubit
                                        .deleteComplaint(complaint.id);

                                    if (success) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(context
                                                .tr("complaint_deleted"))),
                                      );
                                      context
                                          .read<ComplaintsCubit>()
                                          .getcomplaints();
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(context.tr(
                                                "delete_complaint_failed"))),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        verticalSpace(6),
                        Text(
                            "${context.tr("description")}: ${complaint.description}",
                            style: AppTextStyles.font14Grey(context)),
                        verticalSpace(6),
                        Text(
                            "${context.tr("created_at")}: ${complaint.createdAt}",
                            style: AppTextStyles.font16Bold(context)),
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
                    child: Text(context.tr("previous")),
                  ),
                  Text("${context.tr("page")} ${complaintsCubit.currentPage}"),
                  TextButton(
                    onPressed: () => complaintsCubit.nextPage(),
                    child: Text(context.tr("next")),
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
