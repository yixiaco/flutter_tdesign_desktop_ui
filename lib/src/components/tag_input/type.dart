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

  @override
  String toString() {
    return 'TagInputChangeContext{trigger: $trigger, index: $index, item: $item}';
  }
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

  @override
  String toString() {
    return 'TagInputDragSortContext{newTags: $newTags, currentIndex: $currentIndex, current: $current, targetIndex: $targetIndex, target: $target}';
  }
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

  @override
  String toString() {
    return 'TagInputRemoveContext{value: $value, index: $index, item: $item, trigger: $trigger}';
  }
}

enum TagInputRemoveTrigger {
  tagRemove,
  backspace;
}

class TTagInputController extends ChangeNotifier {
  List<String> _value;

  /// 是否允许值变更
  bool update;

  TTagInputController({
    List<String>? value,
    this.update = true,
  }) : _value = value ?? [];

  List<String> get value => _value;

  set value(List<String> value) {
    if (update) {
      _value = value;
      notifyListeners();
    }
  }

  /// 强制更新
  void forceUpdate(List<String> value) {
    _value = value;
    notifyListeners();
  }

  /// 添加
  void add(String value) {
    if (update) {
      _value.add(value);
      notifyListeners();
    }
  }

  /// 删除指定下标
  void removeAt(int index) {
    if (update && index >= 0 && index < _value.length) {
      _value.removeAt(index);
      notifyListeners();
    }
  }

  /// 添加全部
  void addAll(List<String> value) {
    if (update) {
      _value.addAll(value);
      notifyListeners();
    }
  }

  /// 删除最后一项
  void removeLast() {
    if (update && _value.isNotEmpty) {
      _value.removeLast();
      notifyListeners();
    }
  }

  /// 将旧下标中的数据移动到新下标中
  void moveIndex(int olIndex, int newIndex) {
    if (update) {
      var value = _value.removeAt(olIndex);
      _value.insert(newIndex, value);
      notifyListeners();
    }
  }

  /// 清除全部
  void clear() {
    if (update && _value.isNotEmpty) {
      _value = [];
      notifyListeners();
    }
  }
}
