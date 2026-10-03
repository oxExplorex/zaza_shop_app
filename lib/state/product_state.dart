
// общее хранение товаров, как это сделано с корзиной
// ибо на каждом экране своя память

import 'package:flutter/cupertino.dart';

import '../models/product.dart';
import '../services/product_api.dart';

class ProductState extends ChangeNotifier {
  final ProductApi _productApi = ProductApi();

  List<Product> _products = [];
  bool _isLoading = false;
  String? _errorMessage;

  // lambda функции
  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Product? getById(int productId) {
    for (final product in _products) {
      if (product.id == productId) {
        return product;
      }
    }
    return null;
  }


  Future<void> loadProducts() async {
    if (_isLoading) return;

    _isLoading = true;
    _errorMessage = null;

    debugPrint('Начало загрузки');

    try {
      _products = await _productApi.getProducts();
      debugPrint('Получено товаров: ${_products.length}');
    } catch (e) {
      _errorMessage = 'Не удалось загрузить товары';
      debugPrint('Ошибка загрузки товаров: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

}


