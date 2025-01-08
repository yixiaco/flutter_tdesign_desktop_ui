import 'dart:core';

import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';

const _hueStep = 2; // 色相阶梯
const _saturationStep = 0.16; // 饱和度阶梯，浅色部分
const _saturationStep2 = 0.05; // 饱和度阶梯，深色部分
const _brightnessStep1 = 0.05; // 亮度阶梯，浅色部分
const _brightnessStep2 = 0.15; // 亮度阶梯，深色部分
const _lightColorCount = 5; // 浅色数量，主色上
const _darkColorCount = 4; // 深色数量，主色下
const _defaultBackgroundColor = '#141414';
// 暗色主题颜色映射关系表
const _darkColorMap = [
  (index: 7, opacity: 0.15),
  (index: 6, opacity: 0.25),
  (index: 5, opacity: 0.3),
  (index: 5, opacity: 0.45),
  (index: 5, opacity: 0.65),
  (index: 5, opacity: 0.85),
  (index: 4, opacity: 0.9),
  (index: 3, opacity: 0.95),
  (index: 2, opacity: 0.97),
  (index: 1, opacity: 0.98),
];

/// RGB转为HSV
HSVColor rgbToHsv(double r, double g, double b) {
  return HSVColor.fromColor(Color.from(red: r, green: g, blue: b, alpha: 1));
}

/// RGB转为HEX，遵循CSS样式风格
String rgbToHex(Color color) {
  var hex = color.value.toRadixString(16).padLeft(8, '0');
  return hex.substring(2) + hex.substring(0, 2);
}

/// HEX转为Color，输入遵循CSS风格
Color inputToRGB(String color) {
  var colorHex = color.removePrefix('#');
  var hex = colorHex.padRight(8, 'F');
  // 由于前两位在Flutter中表示alpha，而在输出的hex中应该在后两位
  hex = hex.substring(hex.length - 2, hex.length) + hex.substring(0, hex.length - 2);
  return Color(int.parse(hex, radix: 16));
}

/// HSV转为Color
Color hsvToRGB({required double h, required double s, required double v}) {
  return HSVColor.fromAHSV(1, h, s, v).toColor();
}

/// Wrapper function ported from TinyColor.prototype.toHexString
/// Keep it here because of the prefix `#`
String toHex(Color color) {
  return '#${rgbToHex(color)}';
}

/// Wrapper function ported from TinyColor.prototype.mix, not treeshakable.
/// Amount in range [0, 1]
/// Assume color1 & color2 has no alpha, since the following src code did so.
Color mix(Color rgb1, Color rgb2, double amount) {
  final p = amount / 100;
  var rgb = Color.fromRGBO(
    ((rgb2.r - rgb1.r) * p + rgb1.r).round(),
    ((rgb2.g - rgb1.g) * p + rgb1.g).round(),
    ((rgb2.b - rgb1.b) * p + rgb1.b).round(),
    1,
  );
  return rgb;
}

double _getHue(HSVColor hsv, int i, [light = false]) {
  double hue;
  // 根据色相不同，色相转向不同
  if (hsv.hue.round() >= 60 && hsv.hue.round() <= 240) {
    hue = (light ? hsv.hue.round() - _hueStep * i : hsv.hue.round() + _hueStep * i).toDouble();
  } else {
    hue = (light ? hsv.hue.round() + _hueStep * i : hsv.hue.round() - _hueStep * i).toDouble();
  }
  if (hue < 0) {
    hue += 360;
  } else if (hue >= 360) {
    hue -= 360;
  }
  return hue;
}

double _getSaturation(HSVColor hsv, int i, [light = false]) {
  // grey color don't change saturation
  if (hsv.hue == 0 && hsv.saturation == 0) {
    return hsv.saturation;
  }
  double saturation;
  if (light) {
    saturation = hsv.saturation - _saturationStep * i;
  } else if (i == _darkColorCount) {
    saturation = hsv.saturation + _saturationStep;
  } else {
    saturation = hsv.saturation + _saturationStep2 * i;
  }
  // 边界值修正
  if (saturation > 1) {
    saturation = 1;
  }
  // 第一格的 s 限制在 0.06-0.1 之间
  if (light && i == _lightColorCount && saturation > 0.1) {
    saturation = 0.1;
  }
  if (saturation < 0.06) {
    saturation = 0.06;
  }
  return double.parse(saturation.toStringAsFixed(2));
}

double _getValue(HSVColor hsv, int i, [light = false]) {
  double value;
  if (light) {
    value = hsv.value + _brightnessStep1 * i;
  } else {
    value = hsv.value - _brightnessStep2 * i;
  }
  if (value > 1) {
    value = 1;
  }
  return double.parse(value.toStringAsFixed(2));
}

List<String> generateOfCssColor(String color, {bool light = true, String? backgroundColor}) {
  var bg = backgroundColor != null ? inputToRGB(backgroundColor) : null;
  var generateColors = generate(inputToRGB(color), light: light, backgroundColor: bg);
  return generateColors.map((e) => toHex(e)).toList();
}

List<Color> generate(Color color, {bool light = true, Color? backgroundColor}) {
  var patterns = <Color>[];
  for (var i = _lightColorCount; i > 0; i -= 1) {
    final hsv = rgbToHsv(color.r, color.g, color.b);
    var rgb = hsvToRGB(
      h: _getHue(hsv, i, true),
      s: _getSaturation(hsv, i, true),
      v: _getValue(hsv, i, true),
    );
    patterns.add(rgb);
  }
  patterns.add(color);
  for (var i = 1; i <= _darkColorCount; i += 1) {
    final hsv = rgbToHsv(color.r, color.g, color.b);
    var rgb = hsvToRGB(
      h: _getHue(hsv, i),
      s: _getSaturation(hsv, i),
      v: _getValue(hsv, i),
    );
    patterns.add(rgb);
  }

  // dark theme patterns
  if (!light) {
    return _darkColorMap.map((e) {
      return mix(
        backgroundColor ?? inputToRGB(_defaultBackgroundColor),
        patterns[e.index],
        e.opacity * 100,
      );
    }).toList();
  }
  return patterns;
}

/// 生成 MaterialColor
MaterialColor generateMaterialColor(Color color, {bool light = true, Color? backgroundColor}) {
  var colors = generate(color, light: light, backgroundColor: backgroundColor);
  return MaterialColor(color.value, {
    50: colors[0],
    100: colors[1],
    200: colors[2],
    300: colors[3],
    400: colors[4],
    500: colors[5],
    600: colors[6],
    700: colors[7],
    800: colors[8],
    900: colors[9],
  });
}