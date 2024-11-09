import 'package:flutter/material.dart';
import 'package:app_smartkho/data/models/transaction_model.dart';
import 'package:app_smartkho/ui/themes/colors.dart';
import 'package:app_smartkho/ui/themes/fonts.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionCard({Key? key, required this.transaction})
      : super(key: key);

  String _formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy HH:mm').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.whiteColor,
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Icon(
          transaction.transactionType == 'IN'
              ? Icons.arrow_downward
              : Icons.arrow_upward,
          color:
              transaction.transactionType == 'IN' ? Colors.green : Colors.red,
          size: 30,
        ),
        title: Text(
          transaction.productName,
          style: const TextStyle(
            fontSize: AppFonts.medium,
            fontWeight: FontWeight.bold,
            color: AppColors.textColorBold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Số lượng: ${transaction.quantity}',
              style: const TextStyle(
                  fontSize: AppFonts.small, color: AppColors.textColorBold),
            ),
            Text(
              'Ngày giao dịch: ${_formatDate(transaction.transactionDate)}',
              style: const TextStyle(
                  fontSize: AppFonts.small, color: AppColors.textColorBold),
            ),
            if (transaction.remarks != null)
              Text(
                'Ghi chú: ${transaction.remarks}',
                style: const TextStyle(
                    fontSize: AppFonts.small, color: Colors.grey),
              ),
          ],
        ),
        trailing: Icon(
          transaction.approved ? Icons.check_circle : Icons.pending,
          color: transaction.approved ? Colors.green : Colors.grey,
          size: 28,
        ),
      ),
    );
  }
}
