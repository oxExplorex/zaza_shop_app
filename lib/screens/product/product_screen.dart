import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/product.dart';
import '../../state/cart_state.dart';
import '../../theme/app_colors.dart';
import '../../widgets/shop_navigation_bar.dart';

class ProductScreen extends StatefulWidget {
  final Product product;
  final CartState cart;
  final int sourceTab;

  const ProductScreen({
    super.key,
    required this.product,
    required this.cart,
    required this.sourceTab,
  });

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  var formatter = NumberFormat(',###');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: ColoredBox(
          color: AppColors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              ColoredBox(
                color: AppColors.primary,
                child: Padding(
                  padding: const EdgeInsetsGeometry.fromLTRB(12, 8, 12, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElevatedButton.icon(
                        label: Text(
                          'Назад',
                          style: TextStyle(color: AppColors.black),
                        ),
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.arrow_back_ios_new, size: 24),
                      ),

                      SizedBox(
                        height: 250,
                        width: double.infinity,

                        child: Image.network(
                          widget.product.image,
                          fit: BoxFit.contain,

                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }

                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },

                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.broken_image_outlined,
                              size: 48,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              ColoredBox(
                color: AppColors.primary,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.product.name,
                              style: TextStyle(fontSize: 24),
                            ),

                            SizedBox(height: 24),

                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primary,
                                      foregroundColor: AppColors.white,
                                      elevation: 0,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),

                                    onPressed: () =>
                                        widget.cart.increase(widget.product.id),
                                    child: Text('Добавить в корзину'),
                                  ),
                                ),

                                Expanded(
                                  child: Text(
                                    '${formatter.format(widget.product.priceCents)} ₽',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const Divider(
                        thickness: 2,
                        height: 2,
                        color: AppColors.dividerColor,
                      ),

                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: AppColors.primary,
                                    width: 3,
                                  )
                                )
                              ),
                              child: Text(
                                'Описание',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            SizedBox(height: 12,),
                            Text(
                              widget.product.description,
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),

                      const Divider(
                        thickness: 2,
                        height: 2,
                        color: AppColors.dividerColor,
                      ),

                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ключевые слова:',
                              style: TextStyle(fontSize: 18),
                            ),

                            SizedBox(height: 12,),

                            Text(
                              widget.product.keywords.join(', '),
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ShopNavigationBar(
        selectedIndex: widget.sourceTab,
        onSelected: (index) {
          Navigator.pop(context, index);
        },
      ),
    );
  }
}
