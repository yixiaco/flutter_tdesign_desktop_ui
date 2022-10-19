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
  clear;
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
