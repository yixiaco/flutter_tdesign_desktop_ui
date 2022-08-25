part of 'tabs.dart';

/// 标签
class _TabsLabel<T> extends StatefulWidget {
  const _TabsLabel({
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
  State<_TabsLabel<T>> createState() => _TabsLabelState<T>();
}

/// icon宽度
const double _kIconWidth = 40;

class _TabsLabelState<T> extends State<_TabsLabel<T>> with SingleTickerProviderStateMixin {
  late List<GlobalKey> _tabKeys;
  final _LabelPainter _painter = _LabelPainter();
  late AnimationController _controller;
  late CurvedAnimation _position;
  late bool _showScroll;
  final GlobalKey _painterKey = GlobalKey();
  final GlobalKey _labelKey = GlobalKey();
  late ScrollController _scrollController;

  /// 到初始
  late bool _startOffset;

  /// 到结尾
  late bool _lastOffset;

  /// 添加按钮的宽度
  double get _addableIconWidth => widget.addable ? _kIconWidth : 0;

  late int _index;

  @override
  void initState() {
    super.initState();
    _index = widget._index;
    _showScroll = false;
    _startOffset = true;
    _lastOffset = false;
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
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      var noScroll = _scrollController.offset == 0;
      var maxScrollExtent = _scrollController.position.maxScrollExtent - _scrollController.offset == 0;
      if (_startOffset != noScroll || _lastOffset != maxScrollExtent) {
        setState(() {});
      }
      _scrollOffset();
    });
  }

  void _scrollOffset() {
    if (_scrollController.hasClients) {
      _startOffset = _scrollController.offset == 0;
      _lastOffset = _scrollController.position.maxScrollExtent - _scrollController.offset == 0;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _painter.dispose();
    _controller.dispose();
    _position.dispose();
    _scrollController.dispose();
  }

  @override
  void didUpdateWidget(covariant _TabsLabel<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.list.length > _tabKeys.length) {
      final int delta = widget.list.length - _tabKeys.length;
      _tabKeys.addAll(List<GlobalKey>.generate(delta, (int n) => GlobalKey()));
    } else if (widget.list.length < _tabKeys.length) {
      _tabKeys.removeRange(widget.list.length, _tabKeys.length);
    }
    if (widget.list.length != _tabKeys.length || _index != widget._index) {
      _index = widget._index;
      _painter._oldRect = _painter._currentRect;
      if (_index != -1) {
        _controller.forward(from: 0);
      } else {
        _controller.reverse();
      }
    }
    // 选项发生变化时，使选项暴露在视线中
    if (widget.value != oldWidget.value && _index != -1) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        var tabKey = _tabKeys[_index];
        var box = _labelKey.currentContext!.findRenderObject() as RenderBox;
        var targetBox = tabKey.currentContext!.findRenderObject() as RenderBox;
        var offset2 = targetBox.localToGlobal(Offset.zero) - box.localToGlobal(Offset.zero);
        var offset = _scrollController.offset;
        switch (widget.placement) {
          case TTabsPlacement.top:
          case TTabsPlacement.bottom:
            var width = tabKey.currentContext!.size!.width;
            if (offset + _kIconWidth > offset2.dx) {
              _animateTo(offset2.dx - _kIconWidth);
            } else if (offset + context.size!.width - _kIconWidth - _addableIconWidth < offset2.dx + width) {
              _animateTo(offset + (offset2.dx + width - (offset + context.size!.width - _kIconWidth - _addableIconWidth)));
            }
            break;
          case TTabsPlacement.left:
          case TTabsPlacement.right:
            var height = tabKey.currentContext!.size!.height;
            if (offset > offset2.dy) {
              _animateTo(offset2.dy);
            } else if (offset + context.size!.width < offset2.dy + height) {
              _animateTo(offset + (offset2.dy + height - (offset + context.size!.height)));
            }
            break;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _scrollOffset();
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;
    Axis direction;
    switch (widget.placement) {
      case TTabsPlacement.top:
      case TTabsPlacement.bottom:
        direction = Axis.horizontal;
        break;
      case TTabsPlacement.left:
      case TTabsPlacement.right:
        direction = Axis.vertical;
        break;
    }
    List<Widget> buttons = List.generate(widget.list.length, (index) {
      var panel = widget.list[index];
      return KeyedSubtree(
        key: _tabKeys[index],
        child: _TabButton<T>(
          key: ValueKey(index),
          checked: widget.value == panel.value,
          placement: widget.placement,
          theme: widget.theme,
          size: widget.size,
          disabled: widget.disabled || panel.disabled,
          onChange: (checked) => widget.onChange?.call(panel.value),
          index: index,
          value: panel.value,
          onRemove: (value, index) {
            panel.onRemove?.call(value);
            widget.onRemove?.call(value, index);
          },
          removable: panel.removable,
          dragSort: widget.dragSort,
          onDragSort: widget.onDragSort,
          child: panel.label,
        ),
      );
    });

    Widget child = FixedCrossFlex(
      key: _labelKey,
      direction: direction,
      mainAxisSize: MainAxisSize.min,
      clipBehavior: Clip.hardEdge,
      children: buttons,
    );

    switch (widget.theme) {
      case TTabsTheme.normal:
        child = CustomPaint(
          key: _painterKey,
          foregroundPainter: _painter
            .._painterKey = _painterKey
            ..placement = widget.placement
            ..trackColor = colorScheme.bgColorSecondaryContainer
            ..t = _position
            ..tabKeys = _tabKeys
            ..color = colorScheme.brandColor
            ..index = _index
            ..strokeWidth = 1,
          child: child,
        );
        break;
      case TTabsTheme.card:
        child = child;
        break;
    }

    child = TSingleChildScrollView(
      controller: _scrollController,
      primary: false,
      scrollDirection: direction,
      showScroll: direction == Axis.vertical,
      onShowScroll: (showScroll) {
        /// 显示滚动
        setState(() {
          _showScroll = showScroll;
        });
      },
      // 由于按钮长度有可能不一致，此处使用[FixedCrossFlex]调整交叉轴取最长的轴对齐
      child: Padding(
        padding: EdgeInsets.only(right: direction == Axis.horizontal ? _addableIconWidth : 0),
        child: child,
      ),
    );

    Widget? startOffsetIcon;
    Widget? lastOffsetIcon;
    if (_showScroll && direction == Axis.horizontal) {
      if (!_startOffset) {
        startOffsetIcon = Positioned(
          left: 0,
          right: 0,
          child: ClipRect(
            child: Align(
              alignment: Alignment.centerLeft,
              child: _TabIconButton(
                size: widget.size,
                icon: TIcons.chevronLeft,
                right: false,
                showShadow: true,
                onTap: () {
                  var offset = max(
                    _scrollController.position.minScrollExtent,
                    _scrollController.offset - context.size!.width + _kIconWidth * 2 + _addableIconWidth,
                  );
                  _animateTo(offset);
                },
              ),
            ),
          ),
        );
      }
      if (!_lastOffset) {
        lastOffsetIcon = Positioned(
          left: 0,
          right: _addableIconWidth,
          child: ClipRect(
            child: Align(
              alignment: Alignment.centerRight,
              child: _TabIconButton(
                size: widget.size,
                icon: TIcons.chevronRight,
                showShadow: true,
                onTap: () {
                  var offset = min(
                    _scrollController.position.maxScrollExtent,
                    _scrollController.offset + context.size!.width - _kIconWidth * 2 - _addableIconWidth,
                  );
                  _animateTo(offset);
                },
              ),
            ),
          ),
        );
      }
    }

    Widget? addableButton;
    Widget? addableButtonPosition;
    if (widget.addable) {
      addableButton = _TabIconButton(
        size: widget.size,
        icon: TIcons.add,
        showShadow: _lastOffset,
        onTap: () => widget.onAdd?.call(),
      );
      addableButtonPosition = Positioned(
        right: 0,
        left: 0,
        child: ClipRect(
          child: Align(
            alignment: Alignment.centerRight,
            child: addableButton,
          ),
        ),
      );
    }

    // 显示滚动按钮
    if (direction == Axis.horizontal) {
      child = Stack(
        children: [
          child,
          if (startOffsetIcon != null) startOffsetIcon,
          if (lastOffsetIcon != null) lastOffsetIcon,
          if (addableButtonPosition != null) addableButtonPosition,
        ],
      );
    } else {
      child = ClipRect(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            child,
            if (addableButton != null) addableButton,
          ],
        ),
      );
    }

    return child;
  }

  Future<void> _animateTo(double offset) {
    return _scrollController.animateTo(
      offset,
      duration: TVar.animDurationModerate,
      curve: TVar.animTimeFnEasing,
    );
  }
}
