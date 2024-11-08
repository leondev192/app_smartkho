import 'package:dio/dio.dart';

class ApiClient {
  final Dio dio;

  ApiClient()
      : dio = Dio(
          BaseOptions(
            baseUrl: 'https://be-smartkho.onrender.com/api/v1', // Base URL
            connectTimeout:
                const Duration(milliseconds: 5000), // Timeout kết nối (ms)
            receiveTimeout:
                const Duration(milliseconds: 5000), // Timeout nhận dữ liệu (ms)
            headers: {
              'Content-Type': 'application/json',
              'accept': '*/*',
            },
          ),
        ) {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Bạn có thể thêm token vào header ở đây nếu cần
        // options.headers['Authorization'] = 'Bearer your_token_here';
        return handler.next(options);
      },
      onResponse: (response, handler) {
        // Xử lý response nếu cần
        return handler.next(response);
      },
      onError: (e, handler) {
        // Xử lý lỗi nếu cần
        // print('Dio Error: ${e.message}');
        return handler.next(e);
      },
    ));
  }
}
