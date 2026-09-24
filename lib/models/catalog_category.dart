// чтобы нормально индексировать категории
enum CatalogCategory { clothing, electronics, beauty, home, health }

// получение названий категорий
extension CatalogCategoryList on CatalogCategory {
  List<String> get categories {
    switch (this) {
      case CatalogCategory.clothing:
        return ['Fashion & Apparel'];

      case CatalogCategory.electronics:
        return ['Electronics & Gadgets'];

      case CatalogCategory.beauty:
        return ['Beauty & Personal Care'];

      case CatalogCategory.home:
        return ['Home & Kitchen'];

      case CatalogCategory.health:
        return ['Health & Fitness'];
    }
  }
}

// получение название категорий
extension CatalogCategoryName on CatalogCategory {
  String get nameRu {
    switch (this) {
      case CatalogCategory.clothing:
        return 'Одежда';

      case CatalogCategory.electronics:
        return 'Электроника';

      case CatalogCategory.beauty:
        return 'Красота';

      case CatalogCategory.home:
        return 'Для дома';

      case CatalogCategory.health:
        return 'Здоровье';
    }
  }
}


