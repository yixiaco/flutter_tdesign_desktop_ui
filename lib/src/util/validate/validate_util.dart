/// 断言字符串
void assertString(dynamic input) {
  var isString = input is String;
  if (!isString) {
    var invalidType = input.runtimeType.toString();
    if (input == null) {
      invalidType = 'null';
    } else if (invalidType == 'object') {
      invalidType = input.runtimeType.toString();
    }
    throw TypeError();
  }
}

/// 参数合并
Map merge([Map obj = const {}, Map defaults = const {}]) {
  for (var element in defaults.entries) {
    var key = element.key;
    if (obj[key] == null) {
      obj[key] = defaults[key];
    }
  }
  return obj;
}
