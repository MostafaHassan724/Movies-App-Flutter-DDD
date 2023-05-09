import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeNotifier extends AutoDisposeNotifier<ThemeData> {
  static final lightTheme = ThemeData.light();
  static final darkTheme = ThemeData.dark();

  @override
  ThemeData build() {
    return darkTheme;
  }

  void toggleThemePressed() {
    state = state == lightTheme ? darkTheme : lightTheme;
  }
}
