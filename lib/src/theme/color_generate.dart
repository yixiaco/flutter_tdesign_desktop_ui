import 'dart:core';

import 'package:dartx/dartx.dart';
import 'package:flutter/painting.dart';

const hueStep = 2; // 色相阶梯
const saturationStep = 0.16; // 饱和度阶梯，浅色部分
const saturationStep2 = 0.05; // 饱和度阶梯，深色部分
const brightnessStep1 = 0.05; // 亮度阶梯，浅色部分
const brightnessStep2 = 0.15; // 亮度阶梯，深色部分
const lightColorCount = 5; // 浅色数量，主色上
const darkColorCount = 4; // 深色数量，主色下
// 暗色主题颜色映射关系表
const darkColorMap = [
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

class HsvObject {
  final double h;
  final double s;
  final double v;

  HsvObject({required this.h, required this.s, required this.v});
}

HSVColor rgbToHsv(int r, int g, int b) {
  return HSVColor.fromColor(Color.fromRGBO(r, g, b, 1));
}

String rgbToHex(int r, int g, int b) {
  var hex = Color.fromRGBO(r, g, b, 1).value.toRadixString(16).padLeft(8, '0');
  return hex.substring(2) + hex.substring(0,2);
}

Color inputToRGB(String color) {
  var colorHex = color.removePrefix('#');
  var hex = colorHex.padRight(8, 'F');
  // 由于前两位在Flutter中表示alpha，而在输出的hex中应该在后两位
  hex = hex.substring(hex.length - 2, hex.length) + hex.substring(0, hex.length - 2);
  return Color(int.parse(hex, radix: 16));
}

Color hsvToRGB({required double h, required double s, required double v}) {
  return HSVColor.fromAHSV(1, h, s, v).toColor();
}

HsvObject toHsv({required int r, required int g, required int b}) {
  final hsv = rgbToHsv(r, g, b);
  return HsvObject(h: hsv.hue, s: hsv.saturation, v: hsv.value);
}

/// Wrapper function ported from TinyColor.prototype.toHexString
/// Keep it here because of the prefix `#`
String toHex(Color color) {
  return '#${rgbToHex(color.red, color.green, color.blue)}';
}

/// Wrapper function ported from TinyColor.prototype.mix, not treeshakable.
/// Amount in range [0, 1]
/// Assume color1 & color2 has no alpha, since the following src code did so.
Color mix(Color rgb1, Color rgb2, double amount) {
  final p = amount / 100;
  var rgb = Color.fromRGBO(
    ((rgb2.red - rgb1.red) * p + rgb1.red).round(),
    ((rgb2.green - rgb1.green) * p + rgb1.green).round(),
    ((rgb2.blue - rgb1.blue) * p + rgb1.blue).round(),
    1,
  );
  return rgb;
}

double getHue(HsvObject hsv, int i, [light = false]) {
  double hue;
  // 根据色相不同，色相转向不同
  if (hsv.h.round() >= 60 && hsv.h.round() <= 240) {
    hue = (light ? hsv.h.round() - hueStep * i : hsv.h.round() + hueStep * i).toDouble();
  } else {
    hue = (light ? hsv.h.round() + hueStep * i : hsv.h.round() - hueStep * i).toDouble();
  }
  if (hue < 0) {
    hue += 360;
  } else if (hue >= 360) {
    hue -= 360;
  }
  return hue;
}

double getSaturation(HsvObject hsv, int i, [light = false]) {
  // grey color don't change saturation
  if (hsv.h == 0 && hsv.s == 0) {
    return hsv.s;
  }
  double saturation;
  if (light) {
    saturation = hsv.s - saturationStep * i;
  } else if (i == darkColorCount) {
    saturation = hsv.s + saturationStep;
  } else {
    saturation = hsv.s + saturationStep2 * i;
  }
  // 边界值修正
  if (saturation > 1) {
    saturation = 1;
  }
  // 第一格的 s 限制在 0.06-0.1 之间
  if (light && i == lightColorCount && saturation > 0.1) {
    saturation = 0.1;
  }
  if (saturation < 0.06) {
    saturation = 0.06;
  }
  return double.parse(saturation.toStringAsFixed(2));
}

double getValue(HsvObject hsv, int i, [light = false]) {
  double value;
  if (light) {
    value = hsv.v + brightnessStep1 * i;
  } else {
    value = hsv.v - brightnessStep2 * i;
  }
  if (value > 1) {
    value = 1;
  }
  return double.parse(value.toStringAsFixed(2));
}

List<String> generate(String color, {String? theme, String? backgroundColor}) {
  var patterns = <String>[];
  final pColor = inputToRGB(color);
  for (var i = lightColorCount; i > 0; i -= 1) {
    final hsv = toHsv(r: pColor.red, g: pColor.green, b: pColor.blue);
    var rgb = hsvToRGB(
      h: getHue(hsv, i, true),
      s: getSaturation(hsv, i, true),
      v: getValue(hsv, i, true),
    );
    final colorString = toHex(rgb);
    patterns.add(colorString);
  }
  patterns.add(toHex(pColor));
  for (var i = 1; i <= darkColorCount; i += 1) {
    final hsv = toHsv(r: pColor.red, g: pColor.green, b: pColor.blue);
    var rgb = hsvToRGB(
      h: getHue(hsv, i),
      s: getSaturation(hsv, i),
      v: getValue(hsv, i),
    );
    final colorString = toHex(rgb);
    patterns.add(colorString);
  }

  // dark theme patterns
  if (theme == 'dark') {
    return darkColorMap.map((e) {
      var mix2 = mix(
        inputToRGB(backgroundColor ?? '#141414'),
        inputToRGB(patterns[e.index]),
        e.opacity * 100,
      );
      return toHex(mix2);
    }).toList();
  }
  return patterns;
}
