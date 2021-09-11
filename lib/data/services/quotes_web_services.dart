import 'dart:developer';
// import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_bloc_dio_practice/constants/api_constants.dart';
import 'package:flutter_bloc_dio_practice/data/models/quote.dart';

class QuoteWebServices {
  late Dio _dio;

  QuoteWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: quotesBaseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, // 20 seconds
      receiveTimeout: 20 * 1000,
    );
    _dio = Dio(options);
  }

  Future<Quote?>? getRandomQuote() async {
    try {
      Response response = await _dio.get(quoteTagEndpoint);

      // print(response.data.toString());
      // log((response.data).runtimeType.toString());
      // log('Data: ${response.data.toString()}');
      // Map<String, dynamic> map = jsonDecode(response.data);
      // log(map.toString());
      return Quote.fromJson(response.data);
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      return null;
    }
  }
}
