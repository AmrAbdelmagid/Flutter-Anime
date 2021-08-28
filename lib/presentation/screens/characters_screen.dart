import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_dio_practice/business_logic/cubit/characters_cubit.dart';
import 'package:flutter_bloc_dio_practice/constants/colors.dart';
import 'package:flutter_bloc_dio_practice/data/models/character_model.dart';
import 'package:flutter_bloc_dio_practice/presentation/widgets/character_screen_widgets/character_item.dart';
import 'package:flutter_bloc_dio_practice/presentation/widgets/character_screen_widgets/character_screen_body.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  _CharactersScreenState createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  List<Character>? allCharacters;
  @override
  void initState() {
    super.initState();
    allCharacters = BlocProvider.of<CharactersCubit>(context).fetchCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Characters',
          style: TextStyle(color: AppColors.myGrey),
        ),
        backgroundColor: AppColors.myYellow,
      ),
      body: BlocBuilder<CharactersCubit, CharactersState>(
          builder: (context, state) {
        if (state is CharactersLoadedState) {
          allCharacters = state.characters;
          return SingleChildScrollView(
            child: Container(
              color: AppColors.myGrey,
              child: Column(
                children: [
                  GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2 / 3,
                        crossAxisSpacing: 1.0,
                        mainAxisSpacing: 1.0,
                      ),
                      shrinkWrap: true,
                      // physics: const ClampingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemBuilder: (ctx, index) {
                        // TODO: Not Done!
                        return CharacterItem();
                      })
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      }),
    );
  }
}
