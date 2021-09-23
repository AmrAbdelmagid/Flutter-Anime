import 'package:flutter/material.dart';
import '../../../constants/colors.dart';
import 'character_item.dart';

class CharactersList extends StatefulWidget {
  final cubit;
  final scrollController;

  const CharactersList(
      {required this.scrollController, Key? key, required this.cubit})
      : super(key: key);

  @override
  State<CharactersList> createState() => _CharactersListState();
}

class _CharactersListState extends State<CharactersList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      controller: widget.scrollController,
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
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: widget.cubit.searchTextController.text.isEmpty
                    ? widget.cubit.characters.length
                    : widget.cubit.searchedCharacters.length,
                itemBuilder: (ctx, index) {
                  // if (index < widget.cubit.characters.length) {
                  return CharacterItem(
                    character: widget.cubit.searchTextController.text.isEmpty
                        ? widget.cubit.characters[index]
                        : widget.cubit.searchedCharacters[index],
                  );
                }),
            if (widget.cubit.isLoading)
              Column(
                children: [
                  SizedBox(height: 30),
                  Center(child: CircularProgressIndicator.adaptive()),
                  SizedBox(height: 30),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
