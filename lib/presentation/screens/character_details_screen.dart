import 'package:flutter/material.dart';
import 'package:flutter_bloc_dio_practice/constants/colors.dart';
import 'package:flutter_bloc_dio_practice/data/models/character_model.dart';
import 'package:flutter_bloc_dio_practice/presentation/widgets/character_details_screen_widgets/character_info.dart';
import 'package:flutter_bloc_dio_practice/presentation/widgets/character_details_screen_widgets/character_sliver_app_bar.dart';
import 'package:flutter_bloc_dio_practice/presentation/widgets/character_details_screen_widgets/editable_divider.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Character character;
  const CharacterDetailsScreen({Key? key, required this.character})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.myGrey,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          CharacterSliverAppBar(character: character),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: EdgeInsets.fromLTRB(14.0, 14.0, 14.0, 0),
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CharacterInfo(title: 'Name', value: character.enName),
                      EditableDivider(endIndent: 280),
                      CharacterInfo(
                          title: 'Created at', value: character.createdAt),
                      EditableDivider(endIndent: 240),
                      CharacterInfo(
                          title: 'Description', value: character.description),
                      EditableDivider(endIndent: 200),
                    ],
                  ),
                ),
                SizedBox(
                  height: 400,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
