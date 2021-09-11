import 'package:dio/dio.dart';

class DioHelper {
  static Dio _dio = Dio();

  static init() {
    _dio = Dio(
      BaseOptions(
        receiveDataWhenStatusError: true,
        connectTimeout: 20 * 1000, // 20 seconds
        receiveTimeout: 20 * 1000,
      ),
    );
  }

  static Future<Response> getData({
    required String pathUrl,
  }) async {
    return await _dio.get(pathUrl);
  }
}
