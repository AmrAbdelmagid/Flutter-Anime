import 'package:flutter/material.dart';
import 'package:flutter_bloc_dio_practice/constants/colors.dart';
import 'package:flutter_bloc_dio_practice/data/models/character_model.dart';

class CharacterSliverAppBar extends StatelessWidget {
  final Character character;
  const CharacterSliverAppBar({Key? key, required this.character})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: AppColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          character.characterAttributes!.name,
          style: TextStyle(color: AppColors.myWhite),
        ),
        background: Hero(
          tag: character.id,
          child: Image.network(
            character.characterAttributes!.imageSource!.original,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
