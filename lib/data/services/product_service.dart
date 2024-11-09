// lib/data/services/product_service.dart
import '../api_client.dart';

class ProductService {
  final ApiClient _apiClient = ApiClient();

  Future<List<Map<String, dynamic>>?> getAllProducts() async {
    try {
      final response = await _apiClient.dio.get('/products');
      if (response.statusCode == 200 && response.data['status'] == 'success') {
        return List<Map<String, dynamic>>.from(response.data['data']);
      }
    } catch (e) {
      print("Lỗi khi lấy danh sách sản phẩm: $e");
    }
    return null;
  }
}
