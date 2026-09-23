import 'package:flutter/material.dart';

import 'cart_screen.dart';
import 'catalog_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

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
            onPressed: () {},
            icon: const Icon(Icons.dark_mode_outlined),
          ),
        ],
      ),

      body: IndexedStack(index: currentPageIndex, children: pages),

      bottomNavigationBar: NavigationBar(
        selectedIndex: currentPageIndex,

        onDestinationSelected: (index) {
          setState(() {
            currentPageIndex = index;
          });
        },

        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: "Главная"),
          NavigationDestination(
            icon: Icon(Icons.shopping_cart),
            label: "Корзина",
          ),
        ],
      ),
    );
  }
}
