const _defaultOptions = {'loose': false};
const _strictBooleans = ['true', 'false', '1', '0'];
const _looseBooleans = [..._strictBooleans, 'yes', 'no'];

/// 验证是否是一个布尔值
bool isBoolean({str, options = _defaultOptions}) {
  if (str is bool) {
    return true;
  } else if (str is String) {
    if (options['loose']) {
      return _looseBooleans.contains(str.toLowerCase());
    }
    return _strictBooleans.contains(str);
  }
  return false;
}
