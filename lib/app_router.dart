import 'package:flutter/material.dart';
import 'package:flutter_bloc_dio_practice/presentation/widgets/characters_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => CharactersScreen());
    }
  }
}
