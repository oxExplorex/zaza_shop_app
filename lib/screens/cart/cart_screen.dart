import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_project/screens/cart/widgets/cart_item_card.dart';
import 'package:shop_project/screens/success_screen.dart';

import '../../state/cart_state.dart';
import '../../state/product_state.dart';
import '../../theme/app_colors.dart';
import '../product/product_screen.dart';

class CartScreen extends StatefulWidget {
  final CartState cart;
  final ProductState productState;
  final ValueChanged<int> onTabSelected;

  const CartScreen({
    super.key,
    required this.cart,
    required this.productState,
    required this.onTabSelected,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat(',###');

    return Scaffold(
      backgroundColor: AppColors.white,

      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Center(
          child: Text('Корзина', style: TextStyle(color: AppColors.white)),
        ),
        backgroundColor: AppColors.primary,
      ),
      body: ListenableBuilder(
        listenable: Listenable.merge([widget.cart, widget.productState]),
        builder: (context, child) {
          final productsIds = widget.cart.productsIds;

          if (productsIds.isEmpty) {
            return Center(child: Text("Корзина пуста"));
          }

          int total = 0;

          for (final id in productsIds) {
            final product = widget.productState.getById(id);

            if (product != null) {
              total += product.priceCents * widget.cart.quantityOf(id);
            }
          }

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemCount: productsIds.length + 1,

                  separatorBuilder: (context, index) => Divider(
                    height: 1,
                    thickness: 1,
                    color: AppColors.inactiveCategory,
                  ),

                  itemBuilder: (context, index) {
                    if (index == productsIds.length) {
                      return SizedBox();
                    }

                    final id = productsIds[index];
                    final product = widget.productState.getById(id);
                    final quantity = widget.cart.quantityOf(id);

                    if (product == null) {
                      return Card(
                        child: Column(
                          children: [
                            SizedBox(
                              child: Icon(
                                Icons.broken_image_outlined,
                                size: 48,
                              ),
                            ),

                            Text('Товар больше недоступен'),

                            IconButton(
                              onPressed: () => widget.cart.remove(id),
                              icon: Icon(
                                Icons.delete_outline_outlined,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return CartItemCard(
                      product: product,
                      quantity: quantity,
                      onIncrease: () => widget.cart.increase(id),
                      onDecrease: () => widget.cart.decrease(id),
                      onRemove: () => widget.cart.remove(id),
                      onOpen: () async {
                        final tab = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ProductScreen(
                                product: product,
                                cart: widget.cart,
                                sourceTab: 0,
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

              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Итого', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                          Text('${formatter.format(total)} ₽', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)],
                      ),
                    ),

                    Expanded(
                      child: SizedBox(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () async {
                            widget.cart.clear();
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const OrderSuccessScreen(),
                              ),
                            );

                            if (!mounted) return;

                            widget.onTabSelected(0);
                          },
                          child: const Text('Оплатить'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
