bool isByteLength(str, options, [max0]) {
  var min;
  var max;
  if (options is Map) {
    min = options['min'] ?? 0;
    max = options['max'];
  } else {
    // backwards compatibility: isByteLength(str, min [, max])
    min = options;
    max = max0;
  }

  var len = Uri.encodeFull(str).split(RegExp(r'%..|.')).length - 1;
  return len >= min && (max == null || len <= max);
}
