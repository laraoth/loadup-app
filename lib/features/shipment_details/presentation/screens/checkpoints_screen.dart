import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loadup/core/constant/colors.dart';
import 'package:loadup/core/constant/text_styles.dart';
import 'package:loadup/features/shipment_details/logic/cubit/checkpoints_cubit.dart';
import 'package:loadup/features/shipment_details/logic/cubit/checkpoints_state.dart';
import 'package:loadup/features/shipment_details/presentation/widgets/checkpoint_item_widget.dart';

class CheckpointsScreen extends StatefulWidget {
  final int groupId;

  const CheckpointsScreen({super.key, required this.groupId});

  @override
  State<CheckpointsScreen> createState() => _CheckpointsScreenState();
}

class _CheckpointsScreenState extends State<CheckpointsScreen> {
  int page = 1;
  final int perPage = 10;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    context.read<CheckpointsCubit>().getCheckpoints(
          page: page,
          groupId: widget.groupId,
          perPage: perPage,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
      appBar: AppBar(
        backgroundColor: AppColors.appBarBackground(context),
        title: Text(
          'Shipment Checkpoints',
          style: AppTextStyles.font18Bold(context),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: BlocBuilder<CheckpointsCubit, CheckpointsState>(
          builder: (context, state) {
            if (state is CheckpointsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CheckpointsError) {
              return Center(
                child: Text(
                  state.error,
                  style: AppTextStyles.font14Grey(context),
                ),
              );
            } else if (state is CheckpointsSuccess) {
              final checkpoints = state.checkpointsModel.data.checkpoints;

              if (checkpoints.isEmpty) {
                return Center(
                  child: Text(
                    "No Checkpoints Found",
                    style: AppTextStyles.font14Grey(context),
                  ),
                );
              }

              return Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemCount: checkpoints.length,
                      separatorBuilder: (_, __) => SizedBox(height: 10.h),
                      itemBuilder: (context, index) {
                        final checkpoint = checkpoints[index];
                        return CheckpointItemWidget(checkpoint: checkpoint);
                      },
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: page > 1
                            ? () {
                                setState(() {
                                  page--;
                                });
                                _loadData();
                              }
                            : null,
                        child: const Text("Previous"),
                      ),
                      Text("Page $page",
                          style: AppTextStyles.font14Grey(context)),
                      ElevatedButton(
                        onPressed: checkpoints.length == perPage
                            ? () {
                                setState(() {
                                  page++;
                                });
                                _loadData();
                              }
                            : null,
                        child: const Text("Next"),
                      ),
                    ],
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
