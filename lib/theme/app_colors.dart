import 'package:flutter/material.dart';

class AppColors {
  // неизменяемые цвета

  // основной цвет приложения, отличающий от других ?наверное?
  static const primary = Color(0xffffa451);
  static const white = Color(0xffffffff);

  static const addButton = Color(0xffffffff);
  static const addButtonBackground = Color(0xffffe3c9);

  static const navigationActive = Color(0xffee8729);
  static const navigationInactive = primary;

  static bool _isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  // фон
  static Color background(BuildContext context) =>
      _isDark(context) ? const Color(0xff353535) : const Color(0xffffffff);

  // заголовок
  static Color heading(BuildContext context) =>
      _isDark(context) ? const Color(0xFFF5F1FF) : const Color(0xFF27214D);

  static Color secondaryText(BuildContext context) =>
      _isDark(context) ? const Color(0xFFD5D1E0) : const Color(0xFF5D577E);

  static Color inactiveText(BuildContext context) =>
      _isDark(context) ? const Color(0xFFA9A5B8) : const Color(0xFF938DB5);

  // каталог
  static Color price(BuildContext context) =>
      _isDark(context) ? const Color(0xFFFFA451) : const Color(0xFFF08626);

  static Color productCardYellow(BuildContext context) =>
      _isDark(context) ? const Color(0xFF3A3526) : const Color(0xFFFFFAEB);

  static Color productCardPink(BuildContext context) =>
      _isDark(context) ? const Color(0xFF3A2929) : const Color(0xFFFEF0F0);
}
