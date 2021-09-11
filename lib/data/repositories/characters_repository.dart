import 'package:flutter_bloc_dio_practice/data/models/character_model.dart';
import 'package:flutter_bloc_dio_practice/data/services/character_web_services.dart';

class CharacterRepository {
  final CharacterWebServices characterWebServices;

  CharacterRepository(this.characterWebServices);

  Future<List<Character>> fetchAllCharacters() async {
    final List<dynamic> characters =
        await characterWebServices.getAllCharacters();
    return characters as List<Character>;
  }
}
