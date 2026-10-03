import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'cart/cart_screen.dart';
import 'catalog/catalog_screen.dart';

class MainScreen extends StatefulWidget {
  final VoidCallback onThemeToggle;

  const MainScreen({super.key, required this.onThemeToggle});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentPageIndex = 0;

  final List<Widget> pages = const [CatalogScreen(), CartScreen()];

  // TODO: адаптивность через MediaQuery к логотипу?

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/images/logo.png",
          height: 150,
          fit: BoxFit.contain,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: widget.onThemeToggle,
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined,
            ),
          ),
        ],
      ),

      body: IndexedStack(index: currentPageIndex, children: pages),

      // TODO: заменить на Row(Expanded) так как нельзя сделать как на макете :(
      bottomNavigationBar: NavigationBar(
        // скрывает названия у NavigationDestination
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,

        selectedIndex: currentPageIndex,

        onDestinationSelected: (index) {
          setState(() {
            currentPageIndex = index;
          });
        },

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
      ),
    );
  }
}
