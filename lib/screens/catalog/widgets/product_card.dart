import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/product.dart';
import '../../../theme/app_colors.dart';


// Виджет одной карточки в гаталоге
class ProductCard extends StatelessWidget {
  final Product product;
  final int index;

  const ProductCard({super.key, required this.product, required this.index});

  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat(',###');

    // Одна карточка товара в каталоге
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,

      // расцветка карточек(слева один цвет, спраава другой)
      color: index.isOdd
          ? AppColors.productCardPink(context)
          : AppColors.productCardYellow(context),

      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // продукты
            Expanded(
              child: Center(

                // загрузка картинки
                child: Image.network(
                  product.image,
                  fit: BoxFit.contain,

                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }

                    return const Center(child: CircularProgressIndicator());
                  },

                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.broken_image_outlined, size: 48);
                  },
                ),
              ),
            ),

            Text(
              product.name,
              maxLines: 2,
              style: TextStyle(
                color: AppColors.heading(context),
                fontWeight: FontWeight.w600,
              ),
            ),

            Text(
              '${formatter.format(product.priceCents)} ₽',
              style: TextStyle(
                color: AppColors.price(context),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
