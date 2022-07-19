import 'dart:convert';
import 'dart:io';

/// 将下划线方式命名的字符串转换为帕斯卡式
String toPascalCase(String name) {
  return upperFirst(toCamelCase(name));
}

/// 返回此字符串的第一个字母为大写的副本，或原始字符串（如果它为空或已以大写字母开头）。
///
/// ```dart
/// print('abcd'.capitalize()) // Abcd
/// print('Abcd'.capitalize()) // Abcd
/// ```
String upperFirst(String str) {
  switch (str.length) {
    case 0:
      return str;
    case 1:
      return str.toUpperCase();
    default:
      return str.substring(0, 1).toUpperCase() + str.substring(1);
  }
}

/// 将连接符方式命名的字符串转换为驼峰式。如果转换前的下划线大写方式命名的字符串为空，则返回空字符串。
String toCamelCase(String name, [String symbol = '-']) {
  final name2 = name.toString();
  if (name2.contains(symbol)) {
    final length = name2.length;
    final sb = StringBuffer();
    var upperCase = false;
    for (var i = 0; i < length; i++) {
      var c = name2[i];
      if (c == symbol) {
        upperCase = true;
      } else if (upperCase) {
        sb.write(c.toUpperCase());
        upperCase = false;
      } else {
        sb.write(c.toLowerCase());
      }
    }
    return sb.toString();
  } else {
    return name2;
  }
}

void main() async {
  final File iconsFile = File("bin/t_icon.json");
  final File out = File("lib/src/basic/t_icons.dart");
  const outClassName = 'TIcons';
  const packageName = 'tdesign_desktop_ui';

  final String iconsString = await iconsFile.readAsString();
  final Map<String, dynamic> iconsJson = json.decode(iconsString);

  final StringBuffer dartFileBuffer = StringBuffer();
  final family = iconsJson['iconName'];
  final icons = iconsJson['icons'] as List;

  for (var icon in icons) {
    var iconName = icon['name'];
    var varName = toCamelCase(iconName);
    var codepoint = icon['codepoint']?.replaceAll(r'\', '').toString().toLowerCase();
    dartFileBuffer.writeln('\n  /// <icon name="$iconName" /> or <${toPascalCase(varName)}Icon />');
    dartFileBuffer
        .writeln('  static const IconData $varName = _$outClassName(0x$codepoint);');
  }

  var fileContent = """
// GENERATED FILE, DO NOT EDIT

// ignore_for_file: non_constant_identifier_names

import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

@immutable
class _$outClassName extends IconData {
  const _$outClassName(super.codePoint)
      : super(
          fontFamily: '$family',
          fontPackage: '$packageName',
        );
}

/// Identifiers for the supported tdesign icons.
///
/// Use with the [Icon] class to show specific icons.
///
/// Icons are identified by their name, e.g. [TIcons.add].
///
/// See also:
///
///  * [Icon]
///  * [TButton]
///  * <https://tdesign.tencent.com/vue-next/components/icon>
///  * <https://github.com/Tencent/tdesign-icons>
class $outClassName {
  const $outClassName._();
  
  // BEGIN GENERATED ICONS
${dartFileBuffer.toString()}
  // END GENERATED ICONS
}
""";

  final formatProcess = await Process.start(
    'flutter',
    ['format', out.path],
    runInShell: true,
  );
  stdout.addStream(formatProcess.stdout);
  await out.writeAsString(fileContent);
}
