import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_dio_practice/business_logic/cubits/cubit/quotes_cubit.dart';
import 'package:flutter_bloc_dio_practice/constants/colors.dart';
import 'package:flutter_bloc_dio_practice/data/models/character_model.dart';
import 'package:flutter_bloc_dio_practice/presentation/widgets/character_details_screen_widgets/animated_quote.dart';
import 'package:flutter_bloc_dio_practice/presentation/widgets/character_details_screen_widgets/character_info.dart';
import 'package:flutter_bloc_dio_practice/presentation/widgets/character_details_screen_widgets/character_sliver_app_bar.dart';
import 'package:flutter_bloc_dio_practice/presentation/widgets/character_details_screen_widgets/editable_divider.dart';

class CharacterDetailsScreen extends StatefulWidget {
  final Character character;
  const CharacterDetailsScreen({Key? key, required this.character})
      : super(key: key);

  @override
  State<CharacterDetailsScreen> createState() => _CharacterDetailsScreenState();
}

class _CharacterDetailsScreenState extends State<CharacterDetailsScreen> {
  @override
  void initState() {
    BlocProvider.of<QuotesCubit>(context).loadRandomQuote();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<QuotesCubit>(context);
    return Scaffold(
      backgroundColor: AppColors.myGrey,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          CharacterSliverAppBar(character: widget.character),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: EdgeInsets.fromLTRB(14.0, 14.0, 14.0, 0),
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CharacterInfo(
                          title: 'Name',
                          value: widget.character.characterAttributes!.name),
                      EditableDivider(endIndent: 280),
                      CharacterInfo(
                          title: 'Created at',
                          value:
                              widget.character.characterAttributes!.createdAt),
                      EditableDivider(endIndent: 240),
                      CharacterInfo(
                          title: 'Description',
                          maxLines: 12,
                          value: widget
                              .character.characterAttributes!.description),
                      EditableDivider(endIndent: 200),
                      AnimatedQuote(cubit: cubit),
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
