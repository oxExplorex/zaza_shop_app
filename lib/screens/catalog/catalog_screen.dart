import 'package:flutter/material.dart';
import 'package:shop_project/models/catalog_category.dart';
import 'package:shop_project/screens/catalog/widgets/category_list.dart';
import 'package:shop_project/screens/catalog/widgets/product_card.dart';

import '../../models/product.dart';
import '../../services/product_api.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  final ProductApi _productApi = ProductApi();

  List<Product> _products = [];

  bool _isLoading = true;
  String? _errorMessage;

  // Выбранная категория по дефолту первая(одежда)
  CatalogCategory _selectedCategory = CatalogCategory.clothing;

  // все категории в массиве
  final List<CatalogCategory> categoryList = CatalogCategory.values;

  // Фильтрация по категории
  List<Product> get _visibleProducts {
    final categories = _selectedCategory.categories;

    return _products.where((product) {
      // фильтрация
      return categories.contains(product.category);
    }).toList();
  }

  // TODO: favoriteIds List<int>

  @override
  void initState() {
    super.initState();

    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      final List<Product> products = await _productApi.getProducts();

      if (!mounted) return;

      debugPrint('Получено товаров: ${products.length}');

      setState(() {
        _products = products;
        _isLoading = false;
        _errorMessage = null;
      });
    } catch (e) {
      if (!mounted) return;

      debugPrint('Ошибка загрузки товаров: $e');

      setState(() {
        _isLoading = false;
        _errorMessage = 'Не удалось загрузить товары';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_errorMessage!),

            ElevatedButton(
              onPressed: _loadProducts,
              child: const Text('Повторить'),
            ),
          ],
        ),
      );
    }

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
            onRefresh: _loadProducts,
            child: GridView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: _visibleProducts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.65,
              ),
              itemBuilder: (context, index) {
                final product = _visibleProducts[index];
                return ProductCard(product: product, index: index);
              },
            ),
          ),
        ),
      ],
    );
  }
}
