import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadup/core/public_widgets/loading_widget.dart';
import 'package:loadup/features/create_shipment/data/models/governorates_model.dart';
import 'package:loadup/features/create_shipment/logic/cubit/governorates_cubit.dart';

class GovernorateSelectionScreen extends StatefulWidget {
  const GovernorateSelectionScreen({Key? key, required bool isOrigin})
      : super(key: key);

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
    return Scaffold(
      appBar: AppBar(title: const Text('Choose the governorate')),
      body: BlocBuilder<GovernoratesCubit, GovernoratesState>(
        builder: (context, state) {
          if (state is GovernoratesLoading) {
            return LoadingWidget();
          } else if (state is GovernoratesSuccess) {
            final governoratesCubit = context.read<GovernoratesCubit>();
            final List<GovernorateDatum> governorates =
                state.governoratesModel.data;

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
                        onTap: () {
                          Navigator.pop(context, item);
                        },
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: governoratesCubit.currentPage > 1
                          ? () => governoratesCubit.previousPage()
                          : null,
                      child: const Text("pre"),
                    ),
                    Text("page ${governoratesCubit.currentPage}"),
                    TextButton(
                      onPressed: () => governoratesCubit.nextPage(),
                      child: const Text("next"),
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
    );
  }
}
