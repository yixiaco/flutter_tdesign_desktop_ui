import 'package:flutter/material.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 选项卡
/// 用于承载同一层级下不同页面或类别的组件，方便用户在同一个页面框架下进行快速切换。
class TTabs<T> extends StatefulWidget {
  const TTabs({
    Key? key,
    this.addable = false,
    this.disabled = false,
    this.dragSort = false,
    required this.value,
    required this.list,
    this.placement = TTabsPlacement.top,
    this.size,
    this.theme = TTabsTheme.normal,
    this.onAdd,
    this.onChange,
    this.onDragSort,
    this.onRemove,
  }) : super(key: key);

  /// 选项卡是否可增加
  final bool addable;

  /// 是否禁用选项卡
  final bool disabled;

  /// 是否开启拖拽调整顺序
  final bool dragSort;

  /// 激活的选项卡值
  final T? value;

  ///	选项卡列表
  final List<TTabsPanel<T>> list;

  /// 选项卡位置
  final TTabsPlacement placement;

  /// 组件尺寸
  final TComponentSize? size;

  /// 选项卡风格
  final TTabsTheme theme;

  /// 点击添加选项卡时触发
  final void Function()? onAdd;

  /// 激活的选项卡发生变化时触发
  final void Function(T value)? onChange;

  /// 拖拽排序时触发
  final void Function(int currentIndex, T current, int targetIndex, T target)? onDragSort;

  /// 删除选项卡时触发
  final void Function(T value, int index)? onRemove;

  /// 当前下标
  int get _index => list.indexWhere((element) => element.value == value);

  @override
  State<TTabs> createState() => _TTabsState();
}

class _TTabsState extends State<TTabs> with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late List<GlobalKey> _tabKeys;
  final _LabelPainter _painter = _LabelPainter();
  late AnimationController _controller;
  late CurvedAnimation _position;

  @override
  void initState() {
    super.initState();
    if (widget._index != -1) {
      _pageController = PageController(initialPage: widget._index);
    }
    _tabKeys = widget.list.map((option) => GlobalKey()).toList();
    _controller = AnimationController(
      vsync: this,
      duration: TVar.animDurationBase,
      value: widget._index != -1 ? 1 : 0,
    );
    _position = CurvedAnimation(
      parent: _controller,
      curve: TVar.animTimeFnEasing,
      reverseCurve: TVar.animTimeFnEasing.flipped,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _painter.dispose();
    _pageController.dispose();
    _controller.dispose();
    _position.dispose();
  }

  @override
  void didUpdateWidget(covariant TTabs oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.list.length > _tabKeys.length) {
      final int delta = widget.list.length - _tabKeys.length;
      _tabKeys.addAll(List<GlobalKey>.generate(delta, (int n) => GlobalKey()));
    } else if (widget.list.length < _tabKeys.length) {
      _tabKeys.removeRange(widget.list.length, _tabKeys.length);
    }
    if (widget.list.length != _tabKeys.length || widget.value != oldWidget.value) {
      _painter._oldRect = _painter._currentRect;
      if (widget._index != -1) {
        _controller.forward(from: 0);
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);

    return _buildLabel(theme);
  }

  /// 构建标签
  Widget _buildLabel(TThemeData theme) {
    var colorScheme = theme.colorScheme;
    return CustomPaint(
      painter: _painter
        ..tabKeys = _tabKeys
        ..color = colorScheme.brandColor
        ..index = widget._index,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(widget.list.length, (index) {
          return KeyedSubtree(child: widget.list[index].label);
        }),
      ),
    );
  }
}

/// tab painter
class _LabelPainter extends AnimationChangeNotifierPainter {
  Rect? _oldRect;
  Rect? _currentRect;

  int get index => _index!;
  int? _index;

  set index(int value) {
    if (value == _index) {
      return;
    }
    _index = value;
    notifyListeners();
  }

  Color get color => _color!;
  Color? _color;

  set color(Color value) {
    if (value == _color) {
      return;
    }
    _color = value;
    notifyListeners();
  }

  List<GlobalKey> get tabKeys => _tabKeys!;
  List<GlobalKey>? _tabKeys;

  set tabKeys(List<GlobalKey> value) {
    if (value == _tabKeys) {
      return;
    }
    _tabKeys = value;
    notifyListeners();
  }

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
  }

  @override
  bool shouldRepaint(covariant _LabelPainter oldDelegate) {
    return this != oldDelegate;
  }
}

class _TabButton extends StatefulWidget {
  const _TabButton({
    Key? key,
    required this.checked,
    this.disabled = false,
    this.onChange,
    required this.child,
  }) : super(key: key);

  /// 是否禁用组件
  final bool disabled;

  /// 是否选中状态
  final bool checked;

  /// 子组件
  final Widget child;

  /// 选中状态变化时触发
  final void Function(bool checked)? onChange;

  @override
  State<_TabButton> createState() => _TabButtonState();
}

class _TabButtonState extends State<_TabButton> with TickerProviderStateMixin, TToggleableStateMixin {
  @override
  Widget build(BuildContext context) {
    // 鼠标
    final effectiveMouseCursor = MaterialStateProperty.resolveWith<MouseCursor>((states) {
      if (states.contains(MaterialState.disabled)) {
        return SystemMouseCursors.noDrop;
      }
      return SystemMouseCursors.click;
    });

    return Semantics(
      inMutuallyExclusiveGroup: true,
      checked: value,
      child: buildToggleable(
        mouseCursor: effectiveMouseCursor,
        child: widget.child,
      ),
    );
  }

  @override
  ValueChanged<bool?>? get onChanged {
    return (value) => widget.onChange?.call(value ?? false);
  }

  @override
  bool get tristate => false;

  @override
  bool? get value => widget.checked;

  @override
  bool get isInteractive => !widget.disabled;
}
