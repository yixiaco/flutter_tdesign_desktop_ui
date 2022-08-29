import 'package:flutter/material.dart';

/// 菜单栏选中项及展开菜单控制
class TMenuController<T> extends ChangeNotifier {
  TMenuController({
    List<T> expanded = const [],
    T? value,
  })  : _value = value,
        _expanded = expanded;

  /// 子菜单展开的导航集合。
  List<T> get expanded => _expanded;
  List<T> _expanded;

  set expanded(List<T> expanded) {
    if (_expanded != expanded) {
      _expanded = expanded;
      notifyListeners();
    }
  }

  /// 激活菜单项。
  T? get value => _value;
  T? _value;

  set value(T? value) {
    if (_value != value) {
      _value = value;
      notifyListeners();
    }
  }
}
