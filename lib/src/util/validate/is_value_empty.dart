/// 是否为空值
bool isValueEmpty(input) {
  if (input == null) {
    return true;
  } else if (input is String && input.isEmpty) {
    return true;
  } else if (input is Iterable && input.isEmpty) {
    return true;
  } else if (input is Map && input.isEmpty) {
    return true;
  }
  return false;
}
