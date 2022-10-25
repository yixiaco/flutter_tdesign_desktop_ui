import 'package:flutter/foundation.dart';

class SelectInputValue {
  final String label;
  final dynamic value;
  final List<SelectInputValue>? children;

  const SelectInputValue({
    required this.label,
    this.value,
    this.children,
  });
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

class TSelectInputController extends ChangeNotifier {}

class TSelectInputSingleController<T extends SelectInputValue> extends TSelectInputController {
  T? _value;

  TSelectInputSingleController({
    T? value,
  }) : _value = value;

  T? get value => _value;

  set value(T? value) {
    if (_value != value) {
      _value = value;
      notifyListeners();
    }
  }
}

class TSelectInputMultipleController<T extends SelectInputValue> extends TSelectInputController {
  List<T> _value;

  TSelectInputMultipleController({
    List<T> value = const [],
  }) : _value = value;

  List<T> get value => _value;

  set value(List<T> value) {
    if (_value != value) {
      _value = value;
      notifyListeners();
    }
  }
}
