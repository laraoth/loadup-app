// import 'package:flutter/material.dart';
// import 'package:loadup/core/constant/colors.dart';
// import 'package:loadup/core/constant/text_styles.dart';

// class WalletCardWidget extends StatelessWidget {
//   final String balance;
//   final bool showAddIcon;
//   final VoidCallback? onAddTap;

//   const WalletCardWidget({
//     super.key,
//     required this.balance,
//     this.showAddIcon = false,
//     this.onAddTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16),
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: AppColors.deepBlue,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 8,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           const Icon(
//             Icons.account_balance_wallet_outlined,
//             color: Colors.white,
//             size: 32,
//           ),
//           const SizedBox(width: 16),
//           // النصوص
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Your Wallet",
//                   style: AppTextStyles.font16BlackRegular.copyWith(
//                     fontSize: 16,
//                     color: Colors.white,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 const SizedBox(height: 6),
//                 Text(balance, style: AppTextStyles.font24WhiteBold),
//               ],
//             ),
//           ),

//           if (showAddIcon)
//             GestureDetector(
//               onTap: onAddTap,
//               child: CircleAvatar(
//                 backgroundColor: Colors.white,
//                 radius: 18,
//                 child: Icon(Icons.add, color: AppColors.pureBlack),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
