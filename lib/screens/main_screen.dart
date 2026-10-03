import 'package:flutter/material.dart';

import '../state/cart_state.dart';
import '../state/product_state.dart';
import '../theme/app_colors.dart';
import '../widgets/shop_navigation_bar.dart';
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

  // корзина {id:count,}
  final CartState _cart = CartState();

  // содержимое каталога
  final ProductState _products = ProductState();

  // TODO: адаптивность через MediaQuery к логотипу?

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: currentPageIndex == 0
            ? AppColors.white
            : AppColors.primary,
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

      body: IndexedStack(
        index: currentPageIndex,
        children: [
          CatalogScreen(
            cart: _cart,
            productState: _products,
            onTabSelected: (index) {
              setState(() {
                currentPageIndex = index;
              });
            },
          ),
          CartScreen(
            cart: _cart,
            productState: _products,
            onTabSelected: (index) {
              setState(() {
                currentPageIndex = index;
              });
            },
          ),
        ],
      ),

      // TODO: заменить на Row(Expanded) так как нельзя сделать как на макете :(
      bottomNavigationBar: ShopNavigationBar(
        selectedIndex: currentPageIndex,
        onSelected: (index) {
          setState(() {
            currentPageIndex = index;
          });
        },
      ),
    );
  }

  // чтобы был общий states на всех экранах
  @override
  void dispose() {
    _cart.dispose();
    _products.dispose();
    super.dispose();
  }
}
