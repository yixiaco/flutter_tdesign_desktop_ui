import 'package:flutter/widgets.dart';

typedef TTagInputCollapsedItemsCallback = Widget Function(List<String> collapsedTags, int count);

/// 标签输入框
/// 用于输入文本标签
class TTagInput extends StatefulWidget {
  const TTagInput({Key? key}) : super(key: key);

  /// 宽度随内容自适应
  final bool authWidth;

  /// 是否可清空
  final bool clearable;

  /// 标签过多的情况下，折叠项内容，默认为 +N。如果需要悬浮就显示其他内容，可以使用 collapsedItems 自定义。value 表示标签值，collapsedTags 表示折叠标签值，count 表示总标签数量
  final TTagInputCollapsedItemsCallback? collapsedItems;

  /// 是否禁用标签输入框
  final bool disabled;

  /// 拖拽调整标签顺序
  final bool dragSort;

  

  @override
  State<TTagInput> createState() => _TTagInputState();
}

class _TTagInputState extends State<TTagInput> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
