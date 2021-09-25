import 'package:flutter/material.dart';
import '../../menu_items/menu_item_model.dart';
import '../../menu_items/menu_items.dart';

import '../../../constants/colors.dart';

class AppBarIconButton {
  final cubit;
  const AppBarIconButton({required this.cubit});

  List<Widget> buildList(BuildContext context) {
    return cubit.isSearchingLocal || cubit.isSearchingNetwork
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
            PopupMenuButton<MenuItem>(
                onSelected: (item) => _onSelected(context, item),
                color: AppColors.myGrey,
                icon: Icon(
                  Icons.more_vert,
                  color: AppColors.myGrey,
                ),
                itemBuilder: (context) => [
                      ...MenuItems.items.map(_buildItem).toList(),
                    ]),
          ];
  }

  PopupMenuItem<MenuItem> _buildItem(MenuItem item) => PopupMenuItem<MenuItem>(
      value: item,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            item.icon,
            color: AppColors.myYellow,
          ),
          SizedBox(width: 12),
          Text(item.text, style: TextStyle(color: AppColors.myWhite)),
        ],
      ));

  _onSelected(context, item) {
    switch (item) {
      case MenuItems.searchNetwork:
        cubit.startSearch(
            isSearchingOnNetwork: true,
            searchValue: cubit.searchTextController.text);
        ModalRoute.of(context)!.addLocalHistoryEntry(
            LocalHistoryEntry(onRemove: cubit.stopSearch));
        break;
      case MenuItems.searchLoaded:
        cubit.startSearch();
        ModalRoute.of(context)!.addLocalHistoryEntry(
            LocalHistoryEntry(onRemove: cubit.stopSearch));
        break;
    }
  }
}
