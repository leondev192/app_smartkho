import 'package:app_smartkho/ui/widgets/cards/stat_card.dart';
import 'package:app_smartkho/ui/widgets/charts/transaction_chart.dart';
import 'package:app_smartkho/ui/widgets/loadings/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_smartkho/data/services/product_service.dart';
import 'package:app_smartkho/data/services/transaction_service.dart';
import 'package:app_smartkho/ui/themes/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductService _productService = ProductService();
  final TransactionService _transactionService = TransactionService();

  int totalProducts = 0;
  int totalInTransactions = 0;
  int totalOutTransactions = 0;
  int pendingTransactions = 0;
  bool _isLoading = true;

  String email = '';
  String fullName = '';
  String avatarUrl = '';

  @override
  void initState() {
    super.initState();
    _loadInformation();
    _fetchData();
  }

  Future<void> _loadInformation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email') ?? 'no email';
      fullName = prefs.getString('fullName') ?? 'No Name';
      avatarUrl = prefs.getString('avatarUrl') ?? '';
    });
  }

  Future<void> _fetchData() async {
    try {
      final products = await _productService.getAllProducts();
      final transactions = await _transactionService.getAllTransactions();

      setState(() {
        totalProducts = products?.length ?? 0;
        totalInTransactions =
            transactions?.where((t) => t['transactionType'] == 'IN').length ??
                0;
        totalOutTransactions =
            transactions?.where((t) => t['transactionType'] == 'OUT').length ??
                0;
        pendingTransactions =
            transactions?.where((t) => t['approved'] == false).length ?? 0;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      print("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage:
                      avatarUrl.isNotEmpty ? NetworkImage(avatarUrl) : null,
                  radius: 20,
                  backgroundColor: AppColors.whiteColor,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Xin chào 👋',
                      style: TextStyle(
                          fontSize: 14, color: AppColors.textColorBold),
                    ),
                    Text(fullName,
                        style: const TextStyle(
                            fontSize: 14, color: AppColors.primaryColor)),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search_rounded,
                      color: AppColors.primaryColor),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_rounded,
                      color: AppColors.primaryColor),
                ),
              ],
            ),
          ],
        ),
      ),
      body: _isLoading
          ? const CustomLoading(width: 80, height: 80)
          : RefreshIndicator(
              onRefresh: _fetchData,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildQuickStats(),
                    const SizedBox(height: 20),
                    TransactionChart(
                      totalIn: totalInTransactions,
                      totalOut: totalOutTransactions,
                      transactionService: _transactionService,
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildQuickStats() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: [
        StatCard(
            title: "Tổng sản phẩm",
            count: totalProducts,
            icon: Icons.inventory,
            color: Colors.blue),
        StatCard(
            title: "Giao dịch nhập",
            count: totalInTransactions,
            icon: Icons.arrow_downward,
            color: Colors.green),
        StatCard(
            title: "Giao dịch xuất",
            count: totalOutTransactions,
            icon: Icons.arrow_upward,
            color: Colors.red),
        StatCard(
            title: "Chờ duyệt",
            count: pendingTransactions,
            icon: Icons.pending,
            color: Colors.orange),
      ],
    );
  }
}
