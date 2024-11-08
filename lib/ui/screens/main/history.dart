import 'package:app_smartkho/data/models/transaction_model.dart';
import 'package:app_smartkho/data/respositories/history_repository.dart';
import 'package:app_smartkho/ui/widgets/loadings/custom_loading.dart';
import 'package:app_smartkho/ui/themes/colors.dart';
import 'package:app_smartkho/ui/themes/fonts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final HistoryRepository _historyRepository = HistoryRepository();
  List<TransactionModel> _transactions = [];
  bool _isLoading = true;
  bool _isRefreshing = false;
  String _selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    _fetchTransactions();
  }

  Future<void> _fetchTransactions() async {
    if (!_isRefreshing) {
      setState(() {
        _isLoading = true;
      });
    }
    final transactions = await _historyRepository.getTransactions();
    setState(() {
      _transactions = (transactions ?? [])
        ..sort((a, b) => b.transactionDate.compareTo(a.transactionDate));
      _isLoading = false;
      _isRefreshing = false;
    });
  }

  Future<void> _refreshTransactions() async {
    setState(() {
      _isRefreshing = true;
    });
    await _fetchTransactions();
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy HH:mm').format(date);
  }

  List<TransactionModel> _getFilteredTransactions() {
    if (_selectedFilter == 'All') {
      return _transactions;
    } else if (_selectedFilter == 'IN') {
      return _transactions.where((t) => t.transactionType == 'IN').toList();
    } else if (_selectedFilter == 'OUT') {
      return _transactions.where((t) => t.transactionType == 'OUT').toList();
    } else if (_selectedFilter == 'Pending') {
      return _transactions.where((t) => !t.approved).toList();
    }
    return _transactions;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Lịch sử giao dịch",
            style: TextStyle(
              fontSize: AppFonts.large,
              color: AppColors.textColorBold,
            ),
          ),
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ChoiceChip(
                    label: const Text(
                      'Tất cả',
                      style: TextStyle(fontSize: AppFonts.medium),
                    ),
                    selected: _selectedFilter == 'All',
                    selectedColor: AppColors.primaryColor,
                    onSelected: (selected) {
                      setState(() {
                        _selectedFilter = 'All';
                      });
                    },
                  ),
                  const SizedBox(width: 8),
                  ChoiceChip(
                    label: const Text(
                      'Giao dịch nhập',
                      style: TextStyle(fontSize: AppFonts.medium),
                    ),
                    selected: _selectedFilter == 'IN',
                    selectedColor: Colors.green,
                    onSelected: (selected) {
                      setState(() {
                        _selectedFilter = 'IN';
                      });
                    },
                  ),
                  const SizedBox(width: 8),
                  ChoiceChip(
                    label: const Text(
                      'Giao dịch xuất',
                      style: TextStyle(fontSize: AppFonts.medium),
                    ),
                    selected: _selectedFilter == 'OUT',
                    selectedColor: Colors.red,
                    onSelected: (selected) {
                      setState(() {
                        _selectedFilter = 'OUT';
                      });
                    },
                  ),
                  const SizedBox(width: 8),
                  ChoiceChip(
                    label: const Text(
                      'Chờ duyệt',
                      style: TextStyle(fontSize: AppFonts.medium),
                    ),
                    selected: _selectedFilter == 'Pending',
                    selectedColor: Colors.orange,
                    onSelected: (selected) {
                      setState(() {
                        _selectedFilter = 'Pending';
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: _isLoading && !_isRefreshing
                ? const CustomLoading(width: 80, height: 80)
                : RefreshIndicator(
                    onRefresh: _refreshTransactions,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8.0),
                      itemCount: _getFilteredTransactions().length,
                      itemBuilder: (context, index) {
                        final transaction = _getFilteredTransactions()[index];
                        return Card(
                          color: AppColors.whiteColor,
                          elevation: 3,
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            leading: Icon(
                              transaction.transactionType == 'IN'
                                  ? Icons.arrow_downward
                                  : Icons.arrow_upward,
                              color: transaction.transactionType == 'IN'
                                  ? Colors.green
                                  : Colors.red,
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
                                    fontSize: AppFonts.small,
                                    color: AppColors.textColorBold,
                                  ),
                                ),
                                Text(
                                  'Ngày giao dịch: ${_formatDate(transaction.transactionDate)}',
                                  style: const TextStyle(
                                    fontSize: AppFonts.small,
                                    color: AppColors.textColorBold,
                                  ),
                                ),
                                if (transaction.remarks != null)
                                  Text(
                                    'Ghi chú: ${transaction.remarks}',
                                    style: const TextStyle(
                                      fontSize: AppFonts.small,
                                      color: Colors.grey,
                                    ),
                                  ),
                              ],
                            ),
                            trailing: Icon(
                              transaction.approved
                                  ? Icons.check_circle
                                  : Icons.pending,
                              color: transaction.approved
                                  ? Colors.green
                                  : Colors.grey,
                              size: 28,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
