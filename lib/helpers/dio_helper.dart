import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
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
    return await dio.get(pathUrl);
  }
}
