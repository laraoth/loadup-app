import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadup/core/public_widgets/loading_widget.dart';
import 'package:loadup/features/create_shipment/data/models/centers_model.dart';
import 'package:loadup/features/create_shipment/logic/cubit/centers_cubit.dart';

class CenterSelectionScreen extends StatefulWidget {
  const CenterSelectionScreen({Key? key, required bool isOrigin})
      : super(key: key);

  @override
  State<CenterSelectionScreen> createState() => _CenterSelectionScreenState();
}

class _CenterSelectionScreenState extends State<CenterSelectionScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CentersCubit>().getcenters(page: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose the Center')),
      body: BlocBuilder<CentersCubit, CentersState>(
        builder: (context, state) {
          if (state is CentersLoading) {
            return LoadingWidget();
          } else if (state is CentersSuccess) {
            final centersCubit = context.read<CentersCubit>();
            final List<CenterDatum> centers = state.centersModel.data;

            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: centers.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (context, index) {
                      final item = centers[index];
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
                      onPressed: centersCubit.currentPage > 1
                          ? () => centersCubit.previousPage()
                          : null,
                      child: const Text("previous"),
                    ),
                    Text("page ${centersCubit.currentPage}"),
                    TextButton(
                      onPressed: () => centersCubit.nextPage(),
                      child: const Text("next"),
                    ),
                  ],
                ),
              ],
            );
          } else if (state is CentersError) {
            return Center(child: Text(state.error));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
