import 'dart:developer';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_bloc_dio_practice/constants/api_constants.dart';
import 'package:flutter_bloc_dio_practice/data/models/character_model.dart';

class CharacterWebServices {
  late Dio _dio;

  CharacterWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: charactersBaseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, // 20 seconds
      receiveTimeout: 20 * 1000,
    );
    _dio = Dio(options);
  }

  Future<List<Character>> getAllCharacters() async {
    CharactersData? data;
    try {
      Response response = await _dio.get(charactersEndpoint);
      Map<String, dynamic> map = jsonDecode(response.data);
      data = CharactersData.fromJson(map);
      return data.charactersData;
      // return map['data'];
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
