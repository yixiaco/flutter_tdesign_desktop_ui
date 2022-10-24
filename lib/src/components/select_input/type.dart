import 'package:flutter/foundation.dart';

class SelectInputKeys {
  final String label;
  final String id;
  final String children;

  const SelectInputKeys({
    required this.label,
    required this.id,
    required this.children,
  });

  @override
  String toString() {
    return 'SelectInputKeys{label: $label, id: $id, children: $children}';
  }
}

class TSelectInputFocusContext {
  /// 表示输入框的值
  String inputValue;

  /// 表示标签输入框的值
  dynamic tagInputValue;

  TSelectInputFocusContext({
    required this.inputValue,
    required this.tagInputValue,
  });
}

class TSelectController<T> extends ChangeNotifier {
  T _value;

  TSelectController({
    required T value,
  }) : _value = value;

  T get value => _value;

  set value(T value) {
    if (_value != value) {
      _value = value;
      notifyListeners();
    }
  }
}

class TSelectMultipleController<T> extends TSelectController<List<T>> {
  TSelectMultipleController({required super.value});
}
