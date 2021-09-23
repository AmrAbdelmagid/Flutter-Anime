part of 'characters_cubit.dart';

@immutable
abstract class CharactersState {}

class CharactersInitial extends CharactersState {}

class CharactersLoadedState extends CharactersState {}

class LoadingState extends CharactersState {}

class CharactersLoadingState extends CharactersState {}

class AddSearchedItemToSearchedListState extends CharactersState {}

class StartSearchState extends CharactersState {}

class StopSearchState extends CharactersState {}

class ClearSearchState extends CharactersState {}
