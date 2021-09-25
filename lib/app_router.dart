import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'business_logic/cubits/characters_cubit/characters_cubit.dart';
import 'business_logic/cubits/cubit/quotes_cubit.dart';
import 'constants/strings.dart';
import 'data/models/character_model.dart';
import 'data/repositories/characters_repository.dart';
import 'data/repositories/quotes_repository.dart';
import 'data/services/character_web_services.dart';
import 'data/services/quotes_web_services.dart';
import 'presentation/screens/02-character_details_screen/character_details_screen.dart';
import 'presentation/screens/01-characters_screen/characters_screen.dart';

class AppRouter {
  late CharacterRepository characterRepository;
  late CharactersCubit characterCubit;
  late QuoteRepository quoteRepository;
  late QuotesCubit quotesCubit;

  AppRouter() {
    characterRepository = CharacterRepository(CharacterWebServices());
    characterCubit = CharactersCubit(characterRepository);
    quoteRepository = QuoteRepository(QuoteWebServices());
    quotesCubit = QuotesCubit(quoteRepository);
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
            builder: (_) => BlocProvider<QuotesCubit>(
                  create: (context) => quotesCubit,
                  child: CharacterDetailsScreen(character: character),
                ));
    }
  }
}
