import 'package:app_smartkho/ui/widgets/loadings/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:app_smartkho/ui/themes/colors.dart';
import 'package:app_smartkho/data/services/product_service.dart';
import 'package:app_smartkho/data/services/transaction_service.dart';

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

  String email = '';
  String fullName = '';
  String avatarUrl = '';
  bool _isLoading = true;

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
      setState(() {
        _isLoading = false;
      });
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
                        fontSize: 14,
                        color: AppColors.textColorBold,
                      ),
                    ),
                    Text(
                      fullName,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search_rounded,
                    color: AppColors.primaryColor,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notifications_rounded,
                    color: AppColors.primaryColor,
                  ),
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
                    _buildTransactionChart(),
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
        _buildStatCard(
            "Tổng sản phẩm", totalProducts, Icons.inventory, Colors.blue),
        _buildStatCard("Giao dịch nhập", totalInTransactions,
            Icons.arrow_downward, Colors.green),
        _buildStatCard("Giao dịch xuất", totalOutTransactions,
            Icons.arrow_upward, Colors.red),
        _buildStatCard(
            "Chờ duyệt", pendingTransactions, Icons.pending, Colors.orange),
      ],
    );
  }

  Widget _buildStatCard(String title, int count, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(height: 10),
          Text(
            "$count",
            style: TextStyle(
                fontSize: 20, color: color, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(title, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildTransactionChart() {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text(
                "Tỷ lệ giao dịch Nhập - Xuất",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              AspectRatio(
                aspectRatio: 1.2,
                child: PieChart(
                  PieChartData(
                    sections: _buildPieChartSections(),
                    sectionsSpace: 2,
                    centerSpaceRadius: 40,
                    borderData: FlBorderData(show: false),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> _buildPieChartSections() {
    final double total = totalInTransactions + totalOutTransactions.toDouble();

    return [
      PieChartSectionData(
        color: Colors.green,
        value: totalInTransactions.toDouble(),
        title: '${((totalInTransactions / total) * 100).toStringAsFixed(1)}%',
        radius: 50,
        titleStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: Colors.red,
        value: totalOutTransactions.toDouble(),
        title: '${((totalOutTransactions / total) * 100).toStringAsFixed(1)}%',
        radius: 50,
        titleStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ];
  }
}
