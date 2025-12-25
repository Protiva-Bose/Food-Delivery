import 'dart:ui';
import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  /// Primary Colors
  static const Color primary = Color(0xFF38E6FF);
  static const Color primaryDark = Color(0xFF10454C);

  /// Primary Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF38E6FF),
      Color(0xFF10454C),
    ],
  );
  static const LinearGradient gradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF10454C),
    Colors.black12,
    ],
  );

  /// Backgrounds
  static const Color background = Color(0xFFF5F5F5);
  static const Color backgroundDark = Color(0xFF121212);

  /// Text Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
}
