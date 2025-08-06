import 'package:flutter/material.dart';

class KeyboardRepositoryImpl {
  // In future: persist settings, load layouts, etc.
  void logKeyPress(String key) {
    // ignore: avoid_print
    debugPrint('Key pressed: $key');
  }
}
