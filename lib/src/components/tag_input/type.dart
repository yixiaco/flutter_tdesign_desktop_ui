import 'package:dartx/dartx.dart';
import 'package:flutter/foundation.dart';

enum TTagExcessTagsDisplayType {
  /// 横向滚动显示
  scroll,

  /// 换行显示
  breakLine;
}

class TagInputChangeContext {
  final TagInputTriggerSource trigger;
  final int? index;
  final String? item;

  const TagInputChangeContext({
    required this.trigger,
    this.index,
    this.item,
  });
}

enum TagInputTriggerSource {
  enter,
  tagRemove,
  backspace,
  clear,
  reset;
}

enum InputValueChangeContext {
  input,
  clear,
  enter;
}

class TagInputDragSortContext {
  final List<String> newTags;
  final int currentIndex;
  final String current;
  final int targetIndex;
  final String target;

  const TagInputDragSortContext({
    required this.newTags,
    required this.currentIndex,
    required this.current,
    required this.targetIndex,
    required this.target,
  });
}

class TagInputRemoveContext {
  final List<String> value;
  final int index;
  final String item;
  final TagInputRemoveTrigger trigger;

  const TagInputRemoveContext({
    required this.value,
    required this.index,
    required this.item,
    required this.trigger,
  });
}

enum TagInputRemoveTrigger {
  tagRemove,
  backspace;
}

class TTagInputController extends ChangeNotifier {
  List<String> _value;

  TTagInputController({
    List<String>? value,
  }) : _value = value ?? [];

  List<String> get value => _value;

  set value(List<String> value) {
    if (!_value.contentEquals(value)) {
      _value = value;
      notifyListeners();
    }
  }

  /// 添加
  void add(String value) {
    _value.add(value);
    notifyListeners();
  }

  /// 删除指定下标
  void removeAt(int index) {
    if(index > 0 && index < _value.length) {
      _value.removeAt(index);
      notifyListeners();
    }
  }

  /// 添加全部
  void addAll(List<String> value) {
    _value.addAll(value);
    notifyListeners();
  }

  /// 删除最后一项
  void removeLast() {
    if (_value.isNotEmpty) {
      _value.removeLast();
      notifyListeners();
    }
  }

  /// 位置互换
  void exchange(int olIndex, int newIndex) {
    if(olIndex > 0 && olIndex < _value.length && newIndex > 0 && newIndex < _value.length) {
      var value = _value[olIndex];
      _value[olIndex] = _value[newIndex];
      _value[newIndex] = value;
      notifyListeners();
    }
  }

  /// 清除全部
  void clear() {
    if (_value.isNotEmpty) {
      _value = [];
      notifyListeners();
    }
  }
}
