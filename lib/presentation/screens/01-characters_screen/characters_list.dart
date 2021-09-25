import 'package:flutter/material.dart';
import 'package:flutter_bloc_dio_practice/presentation/widgets/adaptive_indicator.dart';
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
    return Container(
      color: AppColors.myGrey,
      child: Column(
        children: [
          Expanded(
            child: GridView.builder(
                controller: widget.scrollController,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 3,
                  crossAxisSpacing: 1.0,
                  mainAxisSpacing: 1.0,
                ),
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: widget.cubit.searchTextController.text.isEmpty
                    ? widget.cubit.characters.length
                    : widget.cubit.isSearchingLocal
                        ? widget.cubit.searchedLoadedCharacters.length
                        : widget.cubit.searchedNetworkCharacters.length,
                itemBuilder: (ctx, index) {
                  // if (index < widget.cubit.characters.length) {
                  return CharacterItem(
                    character: widget.cubit.searchTextController.text.isEmpty
                        ? widget.cubit.characters[index]
                        : widget.cubit.isSearchingLocal
                            ? widget.cubit.searchedLoadedCharacters[index]
                            : widget.cubit.searchedNetworkCharacters[index],
                  );
                }),
          ),
          if (widget.cubit.isLoading)
            Expanded(
              child: Column(
                children: [
                  SizedBox(height: 30),
                  Center(child: AdaptiveCircularProgressIndicator()),
                  SizedBox(height: 30),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
