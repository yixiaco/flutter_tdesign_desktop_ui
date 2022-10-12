import 'package:flutter/material.dart';
import 'package:tdesign_desktop_ui/src/components/menu/type.dart';

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
  void addExpanded(Set<T> value) {
    if(!expanded.containsAll(value)) {
      expanded.addAll(value);
      notifyListeners();
    }
  }

  /// 移除展开的导航集合
  void removeExpanded(Set<T> value) {
    var any = expanded.any((element) => value.contains(element));
    if(any) {
      expanded.removeAll(value);
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

  /// 在子菜单项中查询是否包含选中的菜单
  bool containsValue(List<TMenuProps<T>> props) {
    if (value == null) {
      return false;
    }
    for (var prop in props) {
      if (prop is TSubMenuProps<T>) {
        if (containsValue((prop).children)) {
          return true;
        }
      } else if (prop is TMenuGroupProps<T>) {
        if (containsValue((prop).children)) {
          return true;
        }
      } else if (prop is TMenuItemProps<T>) {
        if (prop.value == value) {
          return true;
        }
      }
    }
    return false;
  }
}
