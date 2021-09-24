import '../models/character_model.dart';
import '../services/character_web_services.dart';

class CharacterRepository {
  final CharacterWebServices characterWebServices;

  CharacterRepository(this.characterWebServices);

  Future<List<Character>> fetchAllCharacters(int paginationOffset) async {
    final List<dynamic> characters =
        await characterWebServices.getAllCharacters(paginationOffset);
    return characters as List<Character>;
  }

  Future<List<Character>> fetchSearchCharacters(String searchValue) async {
    final List<dynamic> characters =
        await characterWebServices.getSearchCharacters(searchValue);
    return characters as List<Character>;
  }
}
