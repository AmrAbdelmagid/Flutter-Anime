import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_dio_practice/data/models/character_model.dart';
import 'package:flutter_bloc_dio_practice/data/repositories/characters_repository.dart';
import 'package:meta/meta.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  CharactersCubit(this.charactersRepository) : super(CharactersInitial());
  final CharacterRepository charactersRepository;
  List<Character> characters = [];

  List<Character> fetchCharacters() {
    charactersRepository.fetchAllCharacters().then((characters) {
      emit(CharactersLoadedState(characters));
      this.characters = characters;
    });
    return characters;
  }
}
