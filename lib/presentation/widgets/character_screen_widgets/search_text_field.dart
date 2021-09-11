import 'package:flutter/material.dart';
import '../../../constants/colors.dart';

class SearchTextField extends StatelessWidget {
  final cubit;
  const SearchTextField({Key? key, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: cubit.searchTextController,
      cursorColor: AppColors.myGrey,
      decoration: InputDecoration(
        hintText: 'Find an anime character',
        border: InputBorder.none,
        hintStyle: TextStyle(color: AppColors.myGrey, fontSize: 18.0),
      ),
      style: TextStyle(color: AppColors.myGrey, fontSize: 18.0),
      onChanged: (searchedCharacter) {
        cubit.addSearchedItemToSearchedList(searchedCharacter);
      },
    );
  }
}
