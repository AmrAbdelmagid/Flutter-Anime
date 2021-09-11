import 'package:flutter/material.dart';
import '../../../constants/colors.dart';
import 'character_item.dart';

class CharactersList extends StatelessWidget {
  final cubit;
  const CharactersList({Key? key, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
          color: AppColors.myGrey,
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 3,
                crossAxisSpacing: 1.0,
                mainAxisSpacing: 1.0,
              ),
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: cubit.searchTextController.text.isEmpty
                  ? cubit.characters.length
                  : cubit.searchedCharacters.length,
              itemBuilder: (ctx, index) {
                return CharacterItem(
                  character: cubit.searchTextController.text.isEmpty
                      ? cubit.characters[index]
                      : cubit.searchedCharacters[index],
                );
              })),
    );
  }
}
