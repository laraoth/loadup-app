import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadup/core/helpers/translation_extension.dart';
import 'package:loadup/core/public_widgets/loading_widget.dart';
import 'package:loadup/features/create_shipment/data/models/centers_model.dart';
import 'package:loadup/features/create_shipment/logic/cubit/centers_cubit.dart';
import 'package:loadup/features/create_shipment/logic/cubit/shipment_request_cubit.dart';

class CenterSelectionScreen extends StatefulWidget {
  final bool isOrigin;
  final int governorateId; // أضفنا هذا

  const CenterSelectionScreen({
    Key? key,
    required this.isOrigin,
    required this.governorateId,
  }) : super(key: key);

  @override
  State<CenterSelectionScreen> createState() => _CenterSelectionScreenState();
}

class _CenterSelectionScreenState extends State<CenterSelectionScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CentersCubit>().getcenters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.tr('Choose the Center'))),
      body: BlocBuilder<CentersCubit, CentersState>(
        builder: (context, state) {
          if (state is CentersLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CentersSuccess) {
            // الفلترة باستخدام governorateId مباشرة
            final List<CenterDatum> centers = state.centersModel.data
                .where((center) => center.governorateId == widget.governorateId)
                .toList();

            if (centers.isEmpty) {
              return Center(child: Text('No centers found'));
            }

            return ListView.separated(
              itemCount: centers.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final item = centers[index];
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text(item.location),
                  onTap: () {
                    Navigator.pop(context, item);
                  },
                );
              },
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
