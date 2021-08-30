import 'package:flutter/material.dart';
import 'package:flutter_bloc_dio_practice/constants/colors.dart';
import 'package:flutter_bloc_dio_practice/data/models/character_model.dart';

class CharacterItem extends StatelessWidget {
  final Character character;
  const CharacterItem({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
      padding: EdgeInsetsDirectional.all(4.0),
      decoration: BoxDecoration(
          color: AppColors.myWhite, borderRadius: BorderRadius.circular(8.0)),
      child: GridTile(
        child: Container(
          color: AppColors.myGrey,
          child: character.image.isNotEmpty
              ? FadeInImage.assetNetwork(
                  height: double.infinity,
                  width: double.infinity,
                  placeholder: 'assets/images/loading.gif',
                  image: character.image,
                  fit: BoxFit.cover,
                )
              : Image.asset('assets/images/loading.gif'),
        ),
        footer: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          color: Colors.black54,
          alignment: Alignment.bottomCenter,
          child: Text(
            character.name,
            style: TextStyle(
                height: 1.3,
                fontSize: 16.0,
                color: AppColors.myWhite,
                fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
