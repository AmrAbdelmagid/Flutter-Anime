import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_dio_practice/business_logic/cubit/characters_cubit.dart';
import 'package:flutter_bloc_dio_practice/constants/strings.dart';
import 'package:flutter_bloc_dio_practice/data/repositories/characters_repository.dart';
import 'package:flutter_bloc_dio_practice/data/services/character_web_services.dart';
import 'package:flutter_bloc_dio_practice/presentation/screens/character_details_screen.dart';
import 'package:flutter_bloc_dio_practice/presentation/screens/characters_screen.dart';

import 'data/models/character_model.dart';

class AppRouter {
  late CharacterRepository characterRepository;
  late CharactersCubit characterCubit;

  AppRouter() {
    characterRepository = CharacterRepository(CharacterWebServices());
    characterCubit = CharactersCubit(characterRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreenRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<CharactersCubit>(
            create: (context) => characterCubit,
            child: CharactersScreen(),
          ),
        );
      case characterDetailsScreenRoute:
        final character = settings.arguments as Character;
        return MaterialPageRoute(
            builder: (_) => CharacterDetailsScreen(character: character));
    }
  }
}
