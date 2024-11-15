import 'package:app_smartkho/data/api_client.dart';

class TransactionService {
  final ApiClient _apiClient = ApiClient();

  Future<List<Map<String, dynamic>>?> getAllTransactions() async {
    try {
      final response = await _apiClient.dio.get('/transactions');
      if (response.statusCode == 200 && response.data['status'] == 'success') {
        return List<Map<String, dynamic>>.from(response.data['data']);
      }
    } catch (e) {
      print("Error fetching transactions: $e");
    }
    return null;
  }

  Future<Map<String, dynamic>> createTransaction(
      Map<String, dynamic> data) async {
    try {
      final response = await _apiClient.dio.post('/transactions', data: data);
      if (response.statusCode == 201 && response.data['status'] == 'success') {
        return response.data;
      }
    } catch (e) {
      print("Error creating transaction: $e");
    }
    return {'status': 'error', 'message': 'Failed to create transaction'};
  }
}
