import 'package:dio/dio.dart';

// https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=4ff5268e85954a2f81444c5c3340f7a5

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String pathUrl,
    required Map<String, dynamic> query,
  }) async {
    return await dio!.get(
      pathUrl,
      queryParameters: query,
    );
  }
}
