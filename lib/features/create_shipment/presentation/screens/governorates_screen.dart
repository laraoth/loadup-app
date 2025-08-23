import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadup/core/public_widgets/loading_widget.dart';
import 'package:loadup/features/create_shipment/data/models/governorates_model.dart';
import 'package:loadup/features/create_shipment/logic/cubit/governorates_cubit.dart';

class GovernorateSelectionScreen extends StatefulWidget {
  const GovernorateSelectionScreen({Key? key, required this.isOrigin})
      : super(key: key);

  final bool isOrigin;

  @override
  State<GovernorateSelectionScreen> createState() =>
      _GovernorateSelectionScreenState();
}

class _GovernorateSelectionScreenState
    extends State<GovernorateSelectionScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GovernoratesCubit>().getgovernorates(page: 1);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GovernoratesCubit>();

    return Scaffold(
      appBar: AppBar(title: const Text('Choose the Governorate')),
      body: Column(
        children: [
          // 🔍 مربع البحث
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: cubit.searchController,
              decoration: InputDecoration(
                hintText: "Search governorates...",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    cubit
                        .searchGovernorates(cubit.searchController.text.trim());
                  },
                ),
              ),
              onSubmitted: (value) {
                cubit.searchGovernorates(value.trim());
              },
            ),
          ),

          Expanded(
            child: BlocBuilder<GovernoratesCubit, GovernoratesState>(
              builder: (context, state) {
                if (state is GovernoratesLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is GovernoratesSuccess) {
                  final governorates = state.governoratesModel.data;
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          itemCount: governorates.length,
                          separatorBuilder: (_, __) => const Divider(),
                          itemBuilder: (context, index) {
                            final item = governorates[index];
                            return ListTile(
                              title: Text(item.name),
                              onTap: () => Navigator.pop(context, item),
                            );
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: cubit.currentPage > 1
                                ? cubit.previousPage
                                : null,
                            child: const Text("Previous"),
                          ),
                          Text("Page ${cubit.currentPage}"),
                          TextButton(
                            onPressed: cubit.nextPage,
                            child: const Text("Next"),
                          ),
                        ],
                      ),
                    ],
                  );
                } else if (state is GovernoratesError) {
                  return Center(child: Text(state.error));
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
