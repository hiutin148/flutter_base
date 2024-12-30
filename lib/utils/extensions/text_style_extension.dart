import 'package:flutter/material.dart';

extension TextStyleExtension on TextStyle {
  /// Font Weight
  TextStyle get w600 => copyWith(fontWeight: FontWeight.w600);

  /// Color
  TextStyle get white => copyWith(color: Colors.white);
  TextStyle get white67 => copyWith(color: Colors.white.withOpacity(0.67));
}
