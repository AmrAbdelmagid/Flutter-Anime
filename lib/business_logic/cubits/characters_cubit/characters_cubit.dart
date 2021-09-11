import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../data/models/character_model.dart';
import '../../../data/repositories/characters_repository.dart';
import 'package:meta/meta.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  CharactersCubit(this.charactersRepository) : super(CharactersInitial());
  final CharacterRepository charactersRepository;
  final searchTextController = TextEditingController();

  List<Character> characters = [];
  List<Character> searchedCharacters = [];
  bool isSearching = false;

  void fetchCharacters() {
    charactersRepository.fetchAllCharacters().then((characters) {
      this.characters = characters;
      emit(CharactersLoadedState());
    });
  }

  void addSearchedItemToSearchedList(String searchedCharacter) {
    searchedCharacters = characters
        .where((character) => character.characterAttributes!.name
            .toLowerCase()
            .startsWith(searchedCharacter))
        .toList();
    emit(AddSearchedItemToSearchedListState());
  }

  void startSearch() {
    isSearching = true;
    emit(StartSearchState());
  }

  void stopSearch() {
    clearSearch();
    isSearching = false;
    emit(StopSearchState());
  }

  void clearSearch() {
    searchTextController.clear();
    emit(ClearSearchState());
  }
}
