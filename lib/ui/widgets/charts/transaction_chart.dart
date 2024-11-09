import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:app_smartkho/data/services/transaction_service.dart';

class TransactionChart extends StatefulWidget {
  final int totalIn;
  final int totalOut;
  final TransactionService transactionService;

  const TransactionChart({
    Key? key,
    required this.totalIn,
    required this.totalOut,
    required this.transactionService,
  }) : super(key: key);

  @override
  State<TransactionChart> createState() => _TransactionChartState();
}

class _TransactionChartState extends State<TransactionChart> {
  String _selectedPeriod = 'Ngày';
  List<String> periods = ['Ngày', 'Tuần', 'Tháng', 'Năm'];
  int periodInTransactions = 0;
  int periodOutTransactions = 0;

  @override
  void initState() {
    super.initState();
    _loadTransactionsForPeriod();
  }

  Future<void> _loadTransactionsForPeriod() async {
    final transactions = await widget.transactionService.getAllTransactions();
    setState(() {
      periodInTransactions = transactions
              ?.where((t) => t['transactionType'] == 'IN' && _isWithinPeriod(t))
              .length ??
          0;
      periodOutTransactions = transactions
              ?.where(
                  (t) => t['transactionType'] == 'OUT' && _isWithinPeriod(t))
              .length ??
          0;
    });
  }

  bool _isWithinPeriod(Map<String, dynamic> transaction) {
    final transactionDate = DateTime.parse(transaction['transactionDate']);
    final now = DateTime.now();

    switch (_selectedPeriod) {
      case 'Ngày':
        return transactionDate.day == now.day &&
            transactionDate.month == now.month &&
            transactionDate.year == now.year;
      case 'Tuần':
        final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
        final endOfWeek = startOfWeek.add(const Duration(days: 6));
        return transactionDate.isAfter(startOfWeek) &&
            transactionDate.isBefore(endOfWeek);
      case 'Tháng':
        return transactionDate.month == now.month &&
            transactionDate.year == now.year;
      case 'Năm':
        return transactionDate.year == now.year;
      default:
        return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 20, bottom: 40, left: 10, right: 10),
        child: Column(
          children: [
            const Text(
              "Tỷ lệ giao dịch Nhập - Xuất",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: _selectedPeriod,
              items: periods.map((String period) {
                return DropdownMenuItem<String>(
                  value: period,
                  child: Text(period),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedPeriod = value!;
                  _loadTransactionsForPeriod();
                });
              },
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
            const SizedBox(height: 20),
            _buildLegend(), // Add the legend here
          ],
        ),
      ),
    );
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLegendItem(Colors.green, "Nhập"),
        const SizedBox(width: 20),
        _buildLegendItem(Colors.red, "Xuất"),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(fontSize: 14)),
      ],
    );
  }

  List<PieChartSectionData> _buildPieChartSections() {
    final double total =
        periodInTransactions + periodOutTransactions.toDouble();
    return [
      PieChartSectionData(
        color: Colors.green,
        value: periodInTransactions.toDouble(),
        title: '${((periodInTransactions / total) * 100).toStringAsFixed(1)}%',
        radius: 50,
        titleStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: Colors.red,
        value: periodOutTransactions.toDouble(),
        title: '${((periodOutTransactions / total) * 100).toStringAsFixed(1)}%',
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
