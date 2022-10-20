import 'package:flutter_test/flutter_test.dart';

void main() {
  print(RegExp('prefix(\\d+)').firstMatch('prefix11')?.group(1));
}
