import 'package:flutter/material.dart';

import 'package:flutter_bloc_dio_practice/constants/colors.dart';

class AppBarIconButton {
  final cubit;
  const AppBarIconButton({required this.cubit});

  List<Widget> buildList(BuildContext context) {
    return cubit.isSearching
        ? <Widget>[
            IconButton(
              onPressed: () {
                cubit.clearSearch();
                Navigator.pop(context);
              },
              icon: Icon(Icons.clear, color: AppColors.myGrey),
            ),
          ]
        : <Widget>[
            IconButton(
              onPressed: () {
                cubit.startSearch();
                ModalRoute.of(context)!.addLocalHistoryEntry(
                    LocalHistoryEntry(onRemove: cubit.stopSearching));
              },
              icon: Icon(
                Icons.search,
                color: AppColors.myGrey,
              ),
            ),
          ];
  }
}
