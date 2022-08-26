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

    // 按钮
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

    // 交叉轴长度对齐
    Widget child = FixedCrossFlex(
      key: _labelKey,
      direction: direction,
      mainAxisSize: MainAxisSize.min,
      clipBehavior: Clip.hardEdge,
      children: buttons,
    );

    // 选中下划线
    switch (widget.theme) {
      case TTabsTheme.normal:
        child = CustomPaint(
          key: _painterKey,
          foregroundPainter: _painter
            .._painterKey = _painterKey
            ..placement = widget.placement
            ..t = _position
            ..tabKeys = _tabKeys
            ..color = colorScheme.brandColor
            ..index = _index
            ..strokeWidth = 1,
          child: child,
        );
        break;
      case TTabsTheme.card:
        break;
    }

    // 滚动条
    child = Padding(
      padding: EdgeInsets.only(right: direction == Axis.horizontal ? _addableIconWidth : 0),
      child: TSingleChildScrollView(
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
        child: child,
      ),
    );

    // 轨道与背景色
    switch (widget.theme) {
      case TTabsTheme.normal:
        child = CustomPaint(
          painter: _TabLabelTrackPainter(
            trackColor: colorScheme.bgColorSecondaryContainer,
            strokeWidth: 1,
            placement: widget.placement,
            tabKeys: _tabKeys,
            painterKey: _painterKey,
          ),
          child: child,
        );
        break;
      case TTabsTheme.card:
        child = Container(
          color: colorScheme.bgColorSecondaryContainer,
          child: child,
        );
        break;
    }

    child = UnconstrainedBox(constrainedAxis: direction, child: child);

    // 向前滚动
    Widget? startOffsetIcon;
    //向后滚动
    Widget? lastOffsetIcon;
    if (_showScroll && direction == Axis.horizontal) {
      if (!_startOffset) {
        startOffsetIcon = Positioned.fill(
          child: Align(
            child: ClipRect(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [_TabIconButton(
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
                )],
              ),
            ),
          ),
        );
      }
      if (!_lastOffset) {
        lastOffsetIcon = Positioned.fill(
          right: _addableIconWidth,
          child: Align(
            child: ClipRect(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [_TabIconButton(
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
                )],
              ),
            ),
          )
        );
      }
    }

    // 添加按钮
    Widget? addableButton;
    Widget? addableButtonPosition;
    if (widget.addable) {
      addableButton = _TabIconButton(
        size: widget.size,
        icon: TIcons.add,
        showShadow: _lastOffset,
        onTap: () => widget.onAdd?.call(),
      );
      addableButtonPosition = Positioned.fill(
        child: Align(
          child: ClipRect(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [addableButton],
            ),
          ),
        ),
      );
    }

    // 显示滚动按钮
    if (direction == Axis.horizontal) {
      child = Stack(
        fit: StackFit.passthrough,
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
