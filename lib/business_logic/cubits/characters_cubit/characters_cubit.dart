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
  List<Character> searchedNetworkCharacters = [];
  List<Character> searchedLoadedCharacters = [];

  int paginationOffset = 0;

  bool isFirstFetch = false;
  bool isLoading = false;
  bool isSearchingLocal = false;
  bool isSearchingNetwork = false;

  void loadCharacters() {
    /// This line prevents unnecessary calls when swiping at bottom
    if (isLoading) return;

    if (paginationOffset == 0) {
      isFirstFetch = true;
    }
    toggleIsLoading(true);
    emit(CharactersLoadingState());
    charactersRepository
        .fetchAllCharacters(paginationOffset)
        .then((newCharacters) {
      paginationOffset += 10;
      isFirstFetch = false;
      characters.addAll(newCharacters);
      toggleIsLoading(false);
      emit(CharactersLoadedState());
    });
  }

  void loadSearchedNetworkCharacters(String searchedValue) {
    emit(SearchedCharactersLoadingState());
    charactersRepository
        .fetchSearchCharacters(searchedValue)
        .then((searchedCharactersNetwork) {
      searchedNetworkCharacters = [];
      searchedNetworkCharacters.addAll(searchedCharactersNetwork);
      emit(SearchedCharactersSuccessState());
    });
  }

  void addSearchedItemToSearchedList(String searchedCharacter) {
    searchedLoadedCharacters = characters
        .where((character) => character.characterAttributes!.name
            .toLowerCase()
            .startsWith(searchedCharacter))
        .toList();
    emit(AddSearchedItemToSearchedListState());
  }

  toggleIsLoading(bool flag) {
    isLoading = flag;
    emit(LoadingState());
  }

  void startSearch(
      {bool isSearchingOnNetwork = false, String searchValue = ''}) {
    if (isSearchingOnNetwork) {
      isSearchingNetwork = true;

      /// Emitting this state before calling the method to notify all listeners
      /// about [isSearchingNetwork] is now true so that no characters will try to
      /// be loaded when searching but the search result
      emit(StartSearchState());
      loadSearchedNetworkCharacters(searchValue);
    } else {
      isSearchingLocal = true;
      emit(StartSearchState());
    }
  }

  void stopSearch() {
    clearSearch();

    emit(StopSearchState());
  }

  void clearSearch() {
    isSearchingLocal = false;
    isSearchingNetwork = false;
    searchTextController.clear();
    emit(ClearSearchState());
  }

  void dispose() {
    searchTextController.dispose();
  }
}
