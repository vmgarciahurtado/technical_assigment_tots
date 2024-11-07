import 'package:flutter/material.dart';

class TextStyles {
  static TextStyle bodyStyle(
      {Color color = Colors.black, bool isBold = false}) {
    return TextStyle(
      color: color,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      fontFamily: 'OpenSans',
      fontSize: 18,
    );
  }

  static TextStyle body2Style(
      {Color color = Colors.black, bool isBold = false}) {
    return TextStyle(
      color: color,
      letterSpacing: 3,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      fontFamily: 'OpenSans',
      fontSize: 16,
    );
  }

  static TextStyle bodyUnderLineStyle(
      {Color color = Colors.black, bool isBold = false}) {
    return TextStyle(
      decoration: TextDecoration.underline,
      color: color,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      fontFamily: 'OpenSans',
      fontSize: 14,
    );
  }
}
