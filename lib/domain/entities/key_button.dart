import 'package:flutter/material.dart';

enum KeyType {
  char,
  backspace,
  enter,
  space,
  mode,
  emoji,
  mic,
  upper,
  numberMode,
  charMode,
  grammarMode,
  translateMode,
  paraphrasingMode,
}

class KeyButton {
  final String label;
  final KeyType type;
  final IconData? icon;

  KeyButton({required this.label, this.type = KeyType.char, this.icon});
}
