// services/history_service.dart

import 'package:app_smartkho/data/api_client.dart';
import 'package:app_smartkho/data/models/transaction_model.dart';

class HistoryService {
  final ApiClient _apiClient = ApiClient();

  Future<List<TransactionModel>?> fetchTransactions() async {
    try {
      final response = await _apiClient.dio.get('/transactions');
      if (response.statusCode == 200 && response.data['status'] == 'success') {
        return (response.data['data'] as List)
            .map((transaction) => TransactionModel.fromJson(transaction))
            .toList();
      }
    } catch (e) {
      print("Lỗi khi lấy danh sách giao dịch: $e");
    }
    return null;
  }
}
