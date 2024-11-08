import 'package:app_smartkho/data/api_client.dart';

class SupplierService {
  final ApiClient _apiClient = ApiClient();

  Future<List<Map<String, dynamic>>?> getAllSuppliers() async {
    try {
      final response = await _apiClient.dio.get('/suppliers');
      if (response.statusCode == 200 && response.data['status'] == 'success') {
        return List<Map<String, dynamic>>.from(response.data['data']);
      }
    } catch (e) {
      print("Lỗi khi lấy danh sách nhà cung cấp: $e");
    }
    return null;
  }
}
