import 'package:flutter/material.dart';

import 'menu_item_model.dart';

class MenuItems {
  static const List<MenuItem> items = [
    searchNetwork,
    searchLoaded,
  ];

  static const searchNetwork = MenuItem(
    text: 'Search Network',
    icon: Icons.travel_explore,
  );

  static const searchLoaded = MenuItem(
    text: 'Search loaded',
    icon: Icons.search,
  );
}
