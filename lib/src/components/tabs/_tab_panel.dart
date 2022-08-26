part of 'tabs.dart';

/// 选项卡面板
class _TabPanel<T> extends StatefulWidget {
  const _TabPanel({
    Key? key,
    required this.index,
    this.value,
    required this.list,
  }) : super(key: key);

  final int index;

  /// 激活的选项卡值
  final T? value;

  ///	选项卡列表
  final List<TTabsPanel<T>> list;

  @override
  State<_TabPanel<T>> createState() => _TabPanelState<T>();
}

class _TabPanelState<T> extends State<_TabPanel<T>> {
  late Map<T, Widget> cachePage;

  @override
  void initState() {
    super.initState();
    cachePage = {};
  }

  @override
  void dispose() {
    super.dispose();
    cachePage.clear();
  }

  @override
  void didUpdateWidget(covariant _TabPanel<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    // 删除隐藏时销毁的页面
    var destroyValues = widget.list.where((element) => element.destroyOnHide).map((e) => e.value);
    cachePage.removeWhere((key, value) => destroyValues.contains(key));
  }

  @override
  Widget build(BuildContext context) {
    const empty = SizedBox();
    var index = widget.index;
    if (index == -1) {
      return IndexedStack(
        children: [empty, ...cachePage.values],
      );
    }

    var tabsPanel = widget.list[index];

    Widget child = tabsPanel.panel ?? empty;

    child = KeyedSubtree(key: ValueKey(tabsPanel.value), child: child);

    if (!tabsPanel.destroyOnHide) {
      cachePage[tabsPanel.value] = child;
    }

    List<Widget> cache = [];
    cachePage.forEach((key, value) {
      if (key != tabsPanel.value) {
        cache.add(value);
      }
    });

    return IndexedStack(
      sizing: StackFit.passthrough,
      children: [child, ...cache],
    );
  }
}
