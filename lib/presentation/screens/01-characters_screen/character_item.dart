import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../constants/colors.dart';
import '../../../constants/strings.dart';
import '../../../data/models/character_model.dart';

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
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, characterDetailsScreenRoute,
            arguments: character), // pass the current taped character
        child: GridTile(
          child: Hero(
            tag: character.id,
            child: Container(
              color: AppColors.myGrey,
              child: character.characterAttributes!.imageSource != null &&
                      character
                          .characterAttributes!.imageSource!.original.isNotEmpty
                  ? FadeInImage.assetNetwork(
                      height: double.infinity,
                      width: double.infinity,
                      placeholder: 'assets/images/placeholder.png',
                      image:
                          character.characterAttributes!.imageSource!.original,
                      fit: BoxFit.cover,
                    )
                  : SvgPicture.asset('assets/images/placeholder.svg'),
            ),
          ),
          footer: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            color: Colors.black54,
            alignment: Alignment.bottomCenter,
            child: Text(
              character.characterAttributes!.name,
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
      ),
    );
  }
}
