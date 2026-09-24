import 'package:flutter/material.dart';
import 'package:shop_project/screens/main_screen.dart';

import '../theme/app_colors.dart';

class WelcomeScreen extends StatefulWidget {
  final VoidCallback onThemeToggle;

  const WelcomeScreen({super.key, required this.onThemeToggle});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        children: [
          // картинка
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Image.asset(
              'assets/images/welcome_collage.png',
              width: MediaQuery.sizeOf(context).width,
              fit: BoxFit.contain,
            ),
          ),

          Expanded(
            child: Container(
              // карточка поверх с закруглением для красоты
              decoration: BoxDecoration(
                color: AppColors.background(context),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
              ),

              // текст и прочее
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Все, что нужно, в одном месте",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.heading(context),
                      ),
                    ),

                    const SizedBox(height: 24),

                    Text(
                      "От стильных образов и бьюти-новинок до умных гаджетов и товаров для уюта в доме. Соберите свой идеальный заказ прямо сейчас!",
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.secondaryText(context),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Кнопка Продолжить
                    Center(
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.white,
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 0,
                          ),

                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MainScreen(
                                  onThemeToggle: widget.onThemeToggle,
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            "Продолжить",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
