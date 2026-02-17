import 'package:flutter/material.dart';

extension TextStyleExtension on TextStyle {
  /// Change text color
  TextStyle withColor(Color color) {
    return copyWith(color: color);
  }

  /// Change font size
  TextStyle withSize(double size) {
    return copyWith(fontSize: size);
  }

  /// Make text bold
  TextStyle get bold {
    return copyWith(fontWeight: FontWeight.bold);
  }

  /// Make text semi-bold
  TextStyle get semiBold {
    return copyWith(fontWeight: FontWeight.w600);
  }

  /// Make text medium
  TextStyle get medium {
    return copyWith(fontWeight: FontWeight.w500);
  }

  /// Make text regular
  TextStyle get regular {
    return copyWith(fontWeight: FontWeight.w400);
  }

  /// Underline text
  TextStyle get underline {
    return copyWith(decoration: TextDecoration.underline);
  }

  /// Line height
  TextStyle withHeight(double height) {
    return copyWith(height: height);
  }

  /// Letter spacing
  TextStyle withLetterSpacing(double spacing) {
    return copyWith(letterSpacing: spacing);
  }
}
