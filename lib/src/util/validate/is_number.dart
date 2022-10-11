/// 验证是否是一个数字
bool isNumber(input) {
  if(input is num) {
    return true;
  }
  var str = input?.toString();
  if(str != null) {
    return num.tryParse(str) != null;
  }
  return false;
}