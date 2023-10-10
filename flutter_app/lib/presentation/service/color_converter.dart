import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';

class ColorConverter {
  static Color iconColorToColor(IconColor? iconColor) {
    if (iconColor == null || iconColor.code == null) {
      return Colors.white;
    }
    return stringToColor(iconColor.code!);
  }

  static Color stringToColor(String? hex) {
    if(hex == null) {
      return Colors.white;
    }
    String cleanHex = hex.toUpperCase().replaceAll("#", "");
    if (cleanHex.length == 6) {
      cleanHex = "FF$cleanHex";
    }
    return Color(int.parse(cleanHex, radix: 16));
  }
}
