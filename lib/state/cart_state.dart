import 'package:flutter/cupertino.dart';

// класс для хранения айдишников в корзине. \
// Позже можно добавить хранение на устройстве и  чтение из памяти этих данных
// ChangeNotifier - сообщает об изменениях тому объекту, кто слушает его(с помощью notifyListeners)

class CartState extends ChangeNotifier {
  // { id(товара): count(кол-во)}
  final Map<int, int> _quantities = {};


  List<int> get productsIds => _quantities.keys.toList();


  int quantityOf(int productId) {
    return _quantities[productId] ?? 0;
  }

  void increase(int productId) {
    _quantities[productId] = quantityOf(productId) + 1;
    notifyListeners();
  }

  void decrease(int productId) {

    if (quantityOf(productId) == 0) {
      return;
    }

    if (quantityOf(productId) == 1) {
      _quantities.remove(productId);
    } else {
      _quantities[productId] = quantityOf(productId) - 1;
    }
    notifyListeners();
  }

  void remove(int productId) {
    if (!_quantities.containsKey(productId)) {
      return; // если нет, то ничего не делаем
    }

    _quantities.remove(productId);
    notifyListeners();
  }

  void clear() {
    _quantities.clear();
    notifyListeners();
  }

}
