import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loadup/core/constant/colors.dart';
import 'package:loadup/core/constant/text_styles.dart';
import 'package:loadup/core/helpers/spacing.dart';
import 'package:loadup/core/public_widgets/custom_bottom_navigation_bar.dart';
import 'package:loadup/features/home/presentation/widgets/wallet_card_widget.dart';
import 'package:loadup/features/wallet/presentation/widgets/transaction_item_widget.dart';

class WalletScreen extends StatelessWidget {
  final String currentBalance;
  final List<Map<String, dynamic>> transactions;

  final String screenTitle = 'Wallet';
  final String transactionHistoryLabel = 'Transaction History';

  const WalletScreen({
    super.key,
    this.currentBalance = '0.00',
    this.transactions = const [
      {'title': 'Funds added', 'amount': '50', 'isPositive': true},
      {'title': 'Funds transferred', 'amount': '20', 'isPositive': false},
    ],
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(20),
              Text(screenTitle, style: AppTextStyles.font24BlackBold),
              verticalSpace(35),
              WalletCardWidget(
                  balance: currentBalance, showAddIcon: true, onAddTap: () {}),
              verticalSpace(24),
              Text(transactionHistoryLabel,
                  style: AppTextStyles.font18BlackBold),
              verticalSpace(16),
              Expanded(
                child: ListView.builder(
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    final tx = transactions[index];
                    return TransactionItem(
                      title: tx['title'],
                      amount: tx['amount'],
                      isPositive: tx['isPositive'],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
