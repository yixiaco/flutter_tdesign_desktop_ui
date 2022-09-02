import 'package:flutter/material.dart';

/// 菜单栏选中项及展开菜单控制
class TMenuController<T> extends ChangeNotifier {
  TMenuController({
    Set<T>? expanded,
    T? value,
  })  : _value = value,
        _expanded = expanded ?? <T>{};

  /// 子菜单展开的导航集合。
  Set<T> get expanded => _expanded;
  Set<T> _expanded;

  set expanded(Set<T> expanded) {
    if (_expanded != expanded) {
      _expanded = expanded;
      notifyListeners();
    }
  }

  /// 新增展开的导航集合
  void addExpanded(T value) {
    if (expanded.add(value)) {
      notifyListeners();
    }
  }

  /// 移除展开的导航集合
  void removeExpanded(T value) {
    if (expanded.remove(value)) {
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
