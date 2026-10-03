import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class ShopNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const ShopNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onSelected,

});


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return NavigationBar(
      // скрывает названия у NavigationDestination
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,

      selectedIndex: selectedIndex,

      onDestinationSelected: onSelected,


      backgroundColor: AppColors.navigationInactive,
      indicatorColor: AppColors.navigationActive,

      destinations: [
        NavigationDestination(
          icon: Icon(Icons.home, color: AppColors.white, size: 30),
          label: "Каталог",
        ),
        NavigationDestination(
          icon: Icon(Icons.shopping_cart, color: AppColors.white),
          label: "Корзина",
        ),
      ],
    );
  }

}