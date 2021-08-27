import 'package:flutter/material.dart';
import 'package:flutter_bloc_dio_practice/constants/strings.dart';
import 'package:flutter_bloc_dio_practice/presentation/screens/character_details_screen.dart';
import 'package:flutter_bloc_dio_practice/presentation/screens/characters_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreenRoute:
        return MaterialPageRoute(builder: (_) => CharactersScreen());
      case characterDetailsScreenRoute:
        return MaterialPageRoute(builder: (_) => CharacterDetailsScreen());
    }
  }
}
