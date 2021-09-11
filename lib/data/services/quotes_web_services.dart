// import 'dart:developer';
// import 'dart:convert';
// import 'package:dio/dio.dart';
// import 'package:flutter_bloc_dio_practice/constants/api_constants.dart';

// class QuoteWebServices {
//   late Dio dio;

//   QuoteWebServices() {
//     BaseOptions options = BaseOptions(
//       baseUrl: quotesBaseUrl,
//       receiveDataWhenStatusError: true,
//       connectTimeout: 20 * 1000, // 20 seconds
//       receiveTimeout: 20 * 1000,
//     );
//     dio = Dio(options);
//   }

//   Future<Map<String, dynamic>> getRandomQuote() async {
//     try {
//       Response response = await dio.get(quoteTagEndpoint);
//       // log(response.data.toString());
//       // log((response.data).runtimeType.toString());
//       // Map map = jsonDecode(response.data);
//       return jsonDecode(response.data);
//     } catch (e) {
//       log(e.toString());
//       return {};
//     }
//   }
// }
