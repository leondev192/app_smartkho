import 'package:app_smartkho/data/api_client.dart';
import 'package:dio/dio.dart';

class AuthService {
  final ApiClient _apiClient = ApiClient(); // Sử dụng ApiClient

  Future<Map<String, dynamic>?> login(String email, String password) async {
    try {
      final response = await _apiClient.dio.post(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 201) {
        return response.data;
      } else {
        print('Unexpected response: ${response.data}');
        return null;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Error response: ${e.response?.data}');
        return e.response?.data;
      } else {
        print('Error: ${e.error}');
        return {'status': 'error', 'message': 'Lỗi kết nối tới server.'};
      }
    }
  }
}
