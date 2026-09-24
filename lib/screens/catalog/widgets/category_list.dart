import 'package:flutter/material.dart';
import 'package:shop_project/models/catalog_category.dart';

// Отрисовка категории
class CategoryList extends StatelessWidget {

  final List<CatalogCategory> categories;

  final CatalogCategory selectedCategory;

  final ValueChanged<CatalogCategory> onSelected;

  const CategoryList ({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,

      child: Row(
        children: [
          for (final category in categories)
            TextButton(
              onPressed: () {
                onSelected(category);
              },

              child: Text(
                category.nameRu
              ),
            )
        ],
      ),
    );
  }





}