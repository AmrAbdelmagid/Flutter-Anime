import '../models/character_model.dart';
import '../services/character_web_services.dart';

class CharacterRepository {
  final CharacterWebServices characterWebServices;

  CharacterRepository(this.characterWebServices);

  Future<List<Character>> fetchAllCharacters() async {
    final List<dynamic> characters =
        await characterWebServices.getAllCharacters();
    return characters as List<Character>;
  }
}
