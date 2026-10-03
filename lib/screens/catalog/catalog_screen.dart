import 'package:flutter/material.dart';
import 'package:shop_project/models/catalog_category.dart';
import 'package:shop_project/screens/catalog/widgets/category_list.dart';
import 'package:shop_project/screens/catalog/widgets/product_card.dart';

import '../../models/product.dart';
import '../../state/cart_state.dart';
import '../../state/product_state.dart';
import '../product/product_screen.dart';

class CatalogScreen extends StatefulWidget {
  final CartState cart;
  final ProductState productState;
  final ValueChanged<int> onTabSelected;

  const CatalogScreen({
    super.key,
    required this.cart,
    required this.productState,
    required this.onTabSelected,
  });

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  // Выбранная категория по дефолту первая(одежда)
  CatalogCategory _selectedCategory = CatalogCategory.clothing;

  // все категории в массиве
  final List<CatalogCategory> categoryList = CatalogCategory.values;

  // Фильтрация по категории
  List<Product> get _visibleProducts {
    final categories = _selectedCategory.categories;

    return widget.productState.products.where((product) {
      // фильтрация
      return categories.contains(product.category);
    }).toList();
  }

  // TODO: favoriteIds List<int>

  @override
  void initState() {
    super.initState();

    widget.productState.loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    // для построения использовать ListenableBuilder
    // слушает изменения в ChangeNotifier
    return ListenableBuilder(
      listenable: widget.productState,
      builder: (context, child) {
        final state = widget.productState;

        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.errorMessage != null) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(state.errorMessage!),

                ElevatedButton(
                  onPressed: widget.productState.loadProducts,
                  child: const Text('Повторить'),
                ),
              ],
            ),
          );
        }

        final visibleProducts = _visibleProducts;

        return Column(
          children: [
            // категории
            // Одежда
            // Электроника
            // Красота
            // Для домаК
            CategoryList(
              categories: categoryList,
              selectedCategory: _selectedCategory,

              // передаем функцию, чтобы изменять категорию в другом виджете
              onSelected: (category) {
                setState(() {
                  _selectedCategory = category;
                });
              },
            ),

            // загрузка каталога
            Expanded(
              child: RefreshIndicator(
                onRefresh: state.loadProducts,
                child: GridView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: visibleProducts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.65,
                  ),
                  itemBuilder: (context, index) {
                    final product = visibleProducts[index];
                    return ProductCard(
                      product: product,
                      index: index,
                      onAdd: () => widget.cart.increase(product.id),

                      onOpen: () async {
                        final tab = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ProductScreen(
                                product: product,
                                cart: widget.cart,
                                sourceTab: 1,
                              );
                            },
                          ),
                        );

                        if (!mounted) return;

                        if (tab != null) {
                          widget.onTabSelected(tab);
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
