import 'package:flutter_bloc_dio_practice/data/models/character_model.dart';
import 'package:flutter_bloc_dio_practice/data/services/character_web_services.dart';

class CharacterRepository {
  final CharacterWebServices characterWebServices;

  CharacterRepository(this.characterWebServices);

  Future<List<Character>> getAllCharacters() async {
    final characters = await characterWebServices.getAllCharacters();
    return characters
        .map((characters) => Character.fromJson(characters))
        .toList();
  }
}
