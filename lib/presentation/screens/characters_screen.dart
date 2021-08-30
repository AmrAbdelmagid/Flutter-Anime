import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_dio_practice/business_logic/cubit/characters_cubit.dart';
import 'package:flutter_bloc_dio_practice/constants/colors.dart';
import 'package:flutter_bloc_dio_practice/presentation/widgets/character_screen_widgets/app_bar_actions.dart';
import 'package:flutter_bloc_dio_practice/presentation/widgets/character_screen_widgets/characters_list.dart';
import 'package:flutter_bloc_dio_practice/presentation/widgets/character_screen_widgets/search_text_field.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  _CharactersScreenState createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).fetchCharacters();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<CharactersCubit>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.myYellow,
        leading: cubit.isSearching
            ? BackButton(
                color: AppColors.myGrey,
              )
            : Container(),
        title: cubit.isSearching
            ? SearchTextField(cubit: cubit)
            : Text(
                'Characters',
                style: TextStyle(color: AppColors.myGrey),
              ),
        actions: AppBarIconButton(cubit: cubit).buildList(context),
      ),
      body: BlocBuilder<CharactersCubit, CharactersState>(
          builder: (context, state) {
        if (cubit.characters.isNotEmpty ||
            cubit.searchedCharacters.isNotEmpty) {
          return CharactersList(cubit: cubit);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}
