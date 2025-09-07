// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:loadup/features/shipment_details/logic/cubit/checkpoints_cubit.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:loadup/core/helpers/translation_extension.dart';

// class MapScreen extends StatefulWidget {
//   const MapScreen({super.key});

//   @override
//   State<MapScreen> createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<CheckpointsCubit>().fetchCheckpoints();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(context.tr("map")),
//       ),
//       body: BlocBuilder<CheckpointsCubit, CheckpointsState>(
//         builder: (context, state) {
//           if (state is CheckpointsLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is CheckpointsError) {
//             return Center(child: Text(state.error));
//           } else if (state is CheckpointsSuccess) {
//             final checkpoints = state.checkpoints.data;

//             return FlutterMap(
//               options: const MapOptions(
//                 initialCenter: LatLng(33.5138, 36.2765),
//                 initialZoom: 7.5,
//               ),
//               children: [
//                 TileLayer(
//                   urlTemplate:
//                       "https://api.maptiler.com/maps/streets/{z}/{x}/{y}.png?key=YXlUwmI1D2LPK3Bxl342",
//                   userAgentPackageName: 'com.example.app',
//                 ),
//                 MarkerLayer(
//                   markers: checkpoints.map((c) {
//                     final coords =
//                         _getCoordinatesForGovernorate(c.governorate.name);

//                     return Marker(
//                       point: coords,
//                       width: 40,
//                       height: 40,
//                       child: Tooltip(
//                         message: "${c.name}\n(${c.governorate.name})",
//                         child: const Icon(Icons.location_on,
//                             color: Colors.red, size: 35),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//                 RichAttributionWidget(
//                   attributions: [
//                     TextSourceAttribution(
//                       '© MapTiler © OpenStreetMap contributors',
//                       onTap: () async {
//                         final url =
//                             Uri.parse('https://www.maptiler.com/copyright/');
//                         if (!await launchUrl(url,
//                             mode: LaunchMode.externalApplication)) {
//                           throw 'Could not launch $url';
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               ],
//             );
//           }
//           return const SizedBox.shrink();
//         },
//       ),
//     );
//   }

//   LatLng _getCoordinatesForGovernorate(String name) {
//     switch (name.toLowerCase()) {
//       case "damascus":
//         return const LatLng(33.5138, 36.2765);
//       case "aleppo":
//         return const LatLng(36.2021, 37.1343);
//       case "homs":
//         return const LatLng(34.7308, 36.7090);
//       case "hama":
//         return const LatLng(35.1318, 36.7578);
//       case "latakia":
//         return const LatLng(35.5236, 35.7917);
//       case "tartus":
//         return const LatLng(34.8890, 35.8866);
//       case "daraa":
//         return const LatLng(32.6180, 36.1052);
//       case "al-hasakah":
//         return const LatLng(36.5024, 40.7475);
//       case "raqqa":
//         return const LatLng(35.9506, 39.0079);
//       case "palmyra":
//         return const LatLng(34.5481, 38.2765);
//       default:
//         return const LatLng(33.5138, 36.2765);
//     }
//   }
// }
