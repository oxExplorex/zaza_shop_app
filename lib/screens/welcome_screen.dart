import 'package:flutter/material.dart';
import 'package:shop_project/screens/main_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffa451),
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
              // белая карточка поверх с закруглением для красоты
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),

              // текст и прочее
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Все, что нужно, в одном месте",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Roboto",
                        color: Color(0xff27214D),
                      ),
                    ),

                    const SizedBox(height: 24),

                    const Text(
                      "От стильных образов и бьюти-новинок до умных гаджетов и товаров для уюта в доме. Соберите свой идеальный заказ прямо сейчас!",
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Roboto",
                        color: Color(0xff5D577E),
                      ),
                    ),

                    const SizedBox(height: 24),


                    // Кнопка Продолжить
                    Center(
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffffa451),
                            foregroundColor: const Color(0xffffffff),
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
                                builder: (context) => const MainScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "Продолжить",
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: "Roboto",
                            ),
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
