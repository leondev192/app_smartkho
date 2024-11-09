import 'package:app_smartkho/data/respositories/transaction_repository.dart';
import 'package:flutter/material.dart';
import 'package:app_smartkho/data/models/transaction_model.dart';
import 'package:app_smartkho/ui/widgets/cards/transaction_card.dart';
import 'package:app_smartkho/ui/widgets/loadings/custom_loading.dart';
import 'package:app_smartkho/ui/themes/colors.dart';
import 'package:app_smartkho/ui/themes/fonts.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final TransactionRepository _transactionRepository = TransactionRepository();
  late Future<List<TransactionModel>> _transactionFuture;
  String _selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    _transactionFuture = _fetchAndSortTransactions();
  }

  Future<List<TransactionModel>> _fetchAndSortTransactions() async {
    final transactions = await _transactionRepository.getTransactions();
    transactions.sort((a, b) => b.transactionDate
        .compareTo(a.transactionDate)); // Sắp xếp theo ngày mới nhất
    return transactions;
  }

  Future<void> _refreshTransactions() async {
    setState(() {
      _transactionFuture = _fetchAndSortTransactions();
    });
  }

  List<TransactionModel> _filterTransactions(
      List<TransactionModel> transactions) {
    switch (_selectedFilter) {
      case 'IN':
        return transactions.where((t) => t.transactionType == 'IN').toList();
      case 'OUT':
        return transactions.where((t) => t.transactionType == 'OUT').toList();
      case 'Pending':
        return transactions.where((t) => !t.approved).toList();
      default:
        return transactions;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: const Text(
            "Lịch sử giao dịch",
            style: TextStyle(
                color: AppColors.whiteColor, fontSize: AppFonts.xxLarge),
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
                children: [
                  ChoiceChip(
                    label: const Text('Tất cả',
                        style: TextStyle(fontSize: AppFonts.medium)),
                    selected: _selectedFilter == 'All',
                    selectedColor: AppColors.primaryColor,
                    onSelected: (selected) =>
                        setState(() => _selectedFilter = 'All'),
                  ),
                  const SizedBox(width: 8),
                  ChoiceChip(
                    label: const Text('Giao dịch nhập',
                        style: TextStyle(fontSize: AppFonts.medium)),
                    selected: _selectedFilter == 'IN',
                    selectedColor: Colors.green,
                    onSelected: (selected) =>
                        setState(() => _selectedFilter = 'IN'),
                  ),
                  const SizedBox(width: 8),
                  ChoiceChip(
                    label: const Text('Giao dịch xuất',
                        style: TextStyle(fontSize: AppFonts.medium)),
                    selected: _selectedFilter == 'OUT',
                    selectedColor: Colors.red,
                    onSelected: (selected) =>
                        setState(() => _selectedFilter = 'OUT'),
                  ),
                  const SizedBox(width: 8),
                  ChoiceChip(
                    label: const Text('Chờ duyệt',
                        style: TextStyle(fontSize: AppFonts.medium)),
                    selected: _selectedFilter == 'Pending',
                    selectedColor: Colors.orange,
                    onSelected: (selected) =>
                        setState(() => _selectedFilter = 'Pending'),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<TransactionModel>>(
              future: _transactionFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CustomLoading(width: 80, height: 80);
                } else if (snapshot.hasError) {
                  return const Center(child: Text("Lỗi khi tải dữ liệu"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("Không có giao dịch"));
                }
                final transactions = _filterTransactions(snapshot.data!);
                return RefreshIndicator(
                  onRefresh: _refreshTransactions,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      return TransactionCard(transaction: transactions[index]);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
