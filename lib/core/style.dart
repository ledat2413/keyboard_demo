import 'package:flutter/material.dart';

class KeyboardStyles {
  static const double keyRadius = 10.0;
  static final BoxDecoration keyDecoration = BoxDecoration(
    color: Colors.grey[700],
    borderRadius: BorderRadius.all(Radius.circular(keyRadius)),
    boxShadow: [
      BoxShadow(color: Colors.black45, offset: Offset(0, 2), blurRadius: 2),
    ],
  );

  static final BoxDecoration specialKeyDecoration = BoxDecoration(
    color: Colors.grey[800],
    borderRadius: BorderRadius.all(Radius.circular(keyRadius)),
    boxShadow: [
      BoxShadow(color: Colors.black45, offset: Offset(0, 2), blurRadius: 2),
    ],
  );

  static final TextStyle keyTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle topChipStyle = TextStyle(
    color: Colors.white,
    fontSize: 16,
  );

  static final BoxDecoration topChipDeco = BoxDecoration(
    color: Color(0xFF404041),
    borderRadius: BorderRadius.circular(20),
  );
}
