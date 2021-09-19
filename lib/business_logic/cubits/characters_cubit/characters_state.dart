part of 'characters_cubit.dart';

@immutable
abstract class CharactersState {}

class CharactersInitial extends CharactersState {}

class CharactersLoadedState extends CharactersState {
  final List<Character> characters;

  CharactersLoadedState(this.characters);
}

class CharactersLoadingState extends CharactersState {
  final List<Character> oldCharacters;
  final bool isFirstFetch;

  CharactersLoadingState(this.oldCharacters, {this.isFirstFetch = false});
}

class AddSearchedItemToSearchedListState extends CharactersState {}

class StartSearchState extends CharactersState {}

class StopSearchState extends CharactersState {}

class ClearSearchState extends CharactersState {}
