const defaultOptions = {'loose': false};
const strictBooleans = ['true', 'false', '1', '0'];
const looseBooleans = [...strictBooleans, 'yes', 'no'];

/// 验证是否是一个布尔值
bool isBoolean({str, options = defaultOptions}) {
  if (str is bool) {
    return true;
  } else if (str is String) {
    if (options['loose']) {
      return looseBooleans.contains(str.toLowerCase());
    }
    return strictBooleans.contains(str);
  }
  return false;
}
