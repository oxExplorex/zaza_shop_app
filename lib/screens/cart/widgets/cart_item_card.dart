import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/product.dart';
import '../../../theme/app_colors.dart';

// Виджет одной карточки в гаталоге
class CartItemCard extends StatelessWidget {
  final Product product;
  final int quantity;

  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onRemove;

  final VoidCallback onOpen;

  const CartItemCard({
    super.key,

    required this.product,
    required this.quantity,

    required this.onIncrease,
    required this.onDecrease,
    required this.onRemove,

    required this.onOpen,
  });

  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat(',###');

    // Одна карточка товара в корзине
    return Card(
      color: AppColors.white,
      elevation: 0,
      child: InkWell(
        onTap: onOpen,

        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              SizedBox(
                child: Image.network(
                  product.image,
                  fit: BoxFit.contain,

                  width: 64,
                  height: 64,

                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }

                    return const Center(child: CircularProgressIndicator());
                  },

                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.broken_image_outlined, size: 64);
                  },
                ),
              ),

              SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),

                    Row(
                      children: [
                        IconButton(
                          iconSize: 22,
                          onPressed: onDecrease,
                          constraints: BoxConstraints.tightFor(
                            width: 24,
                            height: 24,
                          ),
                          style: IconButton.styleFrom(
                            padding: EdgeInsets.zero,
                            backgroundColor: AppColors.white,
                            foregroundColor: AppColors.black,
                            side: BorderSide(color: AppColors.black),
                          ),
                          icon: Icon(Icons.remove),
                        ),

                        Text(
                          '$quantity',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),

                        IconButton(
                          onPressed: onIncrease,
                          iconSize: 22,
                          constraints: BoxConstraints.tightFor(
                            width: 24,
                            height: 24,
                          ),
                          style: IconButton.styleFrom(
                            padding: EdgeInsets.zero,
                            backgroundColor: AppColors.addButtonBackground,
                            foregroundColor: AppColors.navigationActive,
                          ),
                          icon: Icon(Icons.add_outlined),
                        ),

                        IconButton(
                          onPressed: onRemove,

                          icon: Icon(
                            Icons.delete_outline,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // TODO: вынести formatter в функцию priceCentsStr
              Column(
                children: [
                  Text(
                    '${formatter.format(product.priceCents)} ₽',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                ],
              ),

              const SizedBox(width: 12),
            ],
          ),
        ),
      ),
    );
  }
}
