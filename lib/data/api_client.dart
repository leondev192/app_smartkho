import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiClient {
  final Dio dio;

  ApiClient()
      : dio = Dio(
          BaseOptions(
            baseUrl: dotenv.env['API_BASE_URL'] ?? '',
            connectTimeout: const Duration(milliseconds: 10000),
            receiveTimeout: const Duration(milliseconds: 10000),
            headers: {
              'Content-Type': 'application/json',
              'accept': '*/*',
            },
          ),
        ) {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (e, handler) {
        return handler.next(e);
      },
    ));
  }
}
