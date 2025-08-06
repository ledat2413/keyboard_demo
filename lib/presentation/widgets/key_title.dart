import 'package:flutter/material.dart';
import '../../core/style.dart';
import '../../core/style.dart';

class KeyTile extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final double width;
  final double height;
  final bool isSpecial;

  const KeyTile({
    super.key,
    required this.child,
    required this.onTap,
    this.width = 31,
    this.height = 38,
    this.isSpecial = false,
  });

  @override
  Widget build(BuildContext context) {
    final decoration = isSpecial
        ? KeyboardStyles.specialKeyDecoration
        : KeyboardStyles.keyDecoration;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 6.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(KeyboardStyles.keyRadius),
        onTap: onTap,
        child: Container(
          width: width,
          height: height,
          decoration: decoration,
          alignment: Alignment.center,
          child: DefaultTextStyle(
            style: KeyboardStyles.keyTextStyle,
            child: child,
          ),
        ),
      ),
    );
  }
}
