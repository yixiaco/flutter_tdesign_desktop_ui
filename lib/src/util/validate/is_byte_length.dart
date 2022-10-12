bool isByteLength(str, {num min = 0, num? max}) {
  var len = Uri.encodeFull(str).split(RegExp(r'%..|.')).length - 1;
  return len >= min && (max == null || len <= max);
}
