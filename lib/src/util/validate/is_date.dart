import 'dart:math' as math;

import 'package:tdesign_desktop_ui/src/util/validate/validate_util.dart';

const _defaultDateOptions = {
  'format': 'YYYY/MM/DD',
  'delimiters': ['/', '-'],
  'strictMode': false,
};

bool _isValidFormat(format) {
  return RegExp(
    r'(^(y{4}|y{2})[./-](m{1,2})[./-](d{1,2})$)|(^(m{1,2})[./-](d{1,2})[./-]((y{4}|y{2})$))|(^(d{1,2})[./-](m{1,2})[./-]((y{4}|y{2})$))',
    caseSensitive: false,
  ).hasMatch(format);
}

List<List<String>> _zip(List<String> date, List<String> format) {
  var zippedArr = <List<String>>[], len = math.min(date.length, format.length);

  for (var i = 0; i < len; i++) {
    zippedArr.add([date[i], format[i]]);
  }

  return zippedArr;
}

/// 验证是否是一个日期
bool isDate(input, options) {
  if (options is String) {
    // Allow backward compatbility for old format isDate(input [, format])
    options = merge({'format': options}, _defaultDateOptions);
  } else {
    options = merge(options, _defaultDateOptions);
  }
  String format = options['format'];
  List<String> delimiters = options['delimiters'];
  bool strictMode = options['strictMode'];

  if (input is String && _isValidFormat(format)) {
    var formatDelimiter = delimiters.firstWhere((delimiter) => format.contains(delimiter));
    var dateDelimiter = strictMode ? formatDelimiter : delimiters.firstWhere((delimiter) => input.contains(delimiter));
    var dateAndFormat = _zip(input.split(dateDelimiter), format.toLowerCase().split(formatDelimiter));
    var dateObj = {};

    for (var o in dateAndFormat) {
      var dateWord = o[0];
      var formatWord = o[1];
      if (dateWord.length != formatWord.length) {
        return false;
      }
      dateObj[String.fromCharCode(formatWord.codeUnitAt(0))] = dateWord;
    }

    return DateTime.tryParse('${dateObj['y']}-${dateObj['m']}-${dateObj['d']}') != null;
  }

  if (!strictMode) {
    return input is DateTime;
  }

  return false;
}
