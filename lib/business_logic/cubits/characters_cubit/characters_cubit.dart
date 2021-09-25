import 'dart:developer';

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
  int paginationOffset = 0;
  bool isFirstFetch = false;
  bool isLoading = false;

  List<Character> searchedNetworkCharacters = [];

  List<Character> searchedLoadedCharacters = [];
  bool isSearchingLocal = false;
  bool isSearchingNetwork = false;

  // toggleIsSearchingLocal(bool flag) {
  //   isSearchingLocal = flag;
  //   emit(SearchingState());
  // }

  toggleIsLoading(bool flag) {
    isLoading = flag;
    emit(LoadingState());
  }

  void loadCharacters() {
    // this line prevents unnecessary calls when swiping at bottom
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

  void startSearch(
      {bool isSearchingOnNetwork = false, String searchValue = ''}) {
    if (isSearchingOnNetwork) {
      isSearchingNetwork = true;
      emit(StartSearchState());
      loadSearchedNetworkCharacters(searchValue);
    } else {
      isSearchingLocal = true;
      emit(StartSearchState());
    }
  }

  void stopSearch() {
    clearSearch();
    isSearchingLocal = false;
    isSearchingNetwork = false;
    emit(StopSearchState());
  }

  void clearSearch() {
    searchTextController.clear();
    emit(ClearSearchState());
  }

  void dispose() {
    searchTextController.dispose();
  }
}
