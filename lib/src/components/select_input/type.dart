import 'package:flutter/foundation.dart';

class SelectInputValue {
  /// 标签名称
  final String label;

  /// 值
  final dynamic value;

  /// 子选项
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
  List<String>? tagInputValue;

  TSelectInputFocusContext({
    required this.inputValue,
    this.tagInputValue,
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

  /// 新增一项
  void add(T value) {
    _value.add(value);
    notifyListeners();
  }

  /// 删除下标项
  void removeAt(int index) {
    _value.removeAt(index);
    notifyListeners();
  }

  void clear() {
    _value.clear();
    notifyListeners();
  }
}
