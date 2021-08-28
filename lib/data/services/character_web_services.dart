import 'dart:developer';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_bloc_dio_practice/constants/api_constants.dart';

class CharacterWebServices {
  late Dio dio;

  CharacterWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, // 20 seconds
      receiveTimeout: 20 * 1000,
    );
    dio = Dio(options);
  }

  Future<List<dynamic>> getAllCharacters() async {
    try {
      Response response = await dio.get(charactersEndpoint);
      // log(response.data.toString());
      // log((response.data).runtimeType.toString());
      Map map = jsonDecode(response.data);
      return map['data'];
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
