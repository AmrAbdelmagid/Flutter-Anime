import 'package:flutter/material.dart';
import 'package:flutter_bloc_dio_practice/constants/colors.dart';

class CharacterInfo extends StatelessWidget {
  final String title;
  final String value;
  final int? maxLines;
  const CharacterInfo(
      {Key? key, required this.title, required this.value, this.maxLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,

      // overflow: TextOverflow.ellipsis,
      text: TextSpan(children: [
        TextSpan(
          text: '$title: ',
          style: TextStyle(
            color: AppColors.myWhite,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        TextSpan(
          text: value,
          style: TextStyle(
            color: AppColors.myWhite,
            fontSize: 16.0,
          ),
        ),
      ]),
    );
  }
}
