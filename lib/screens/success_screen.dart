import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class OrderSuccessScreen extends StatefulWidget {
  const OrderSuccessScreen({super.key});

  @override
  State<OrderSuccessScreen> createState() => _OrderSuccessScreenState();
}

class _OrderSuccessScreenState extends State<OrderSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 12),

              Icon(Icons.check_circle_outline, size: 100, color: Colors.green),

              SizedBox(height: 12),

              Text('Поздравляем!'),

              SizedBox(height: 6),

              Text('Ваш заказ оплачен и скоро появится в профиле'),

              SizedBox(height: 12),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  padding: const EdgeInsets.fromLTRB(24,14,24,14),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {},
                child: Text('Отследить заказ'),
              ),

              SizedBox(height: 12),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.white,
                  foregroundColor: AppColors.primary,
                  overlayColor: AppColors.primary,
                  padding: const EdgeInsets.fromLTRB(24,14,24,14),
                  elevation: 0,
                  side: BorderSide(color: AppColors.primary, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: Text('Продолжить покупки'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
