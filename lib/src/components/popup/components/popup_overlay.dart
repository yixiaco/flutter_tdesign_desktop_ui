part of '../popup.dart';

/// 浮层内容对象
class _PopupOverlay extends StatefulWidget {
  const _PopupOverlay({
    Key? key,
    required this.animation,
    this.onEnter,
    required this.popupState,
    required this.onRemove,
  }) : super(key: key);

  final Animation<double> animation;
  final PointerEnterEventListener? onEnter;
  final TPopupState popupState;
  final VoidCallback onRemove;

  @override
  State<_PopupOverlay> createState() => _PopupOverlayState();
}

class _PopupOverlayState extends State<_PopupOverlay> {
  late ValueNotifier<bool> _visible;

  /// 反方向布局
  late ValueNotifier<bool> _isReverse;
  final GlobalKey _containerKey = GlobalKey();
  late _PopupLevelNotifier levelNotifier;

  /// 默认垂直偏移
  static const double _defaultVerticalOffset = 4.0;
  static double popupContentArrowSpacer = TVar.spacer2;

  @override
  void initState() {
    super.initState();
    levelNotifier = _PopupLevelNotifier({});
    _visible = ValueNotifier(false);
    _isReverse = ValueNotifier(false);
    _updateIgnore();
    widget.animation.addListener(_updateIgnore);
  }

  @override
  void didUpdateWidget(covariant _PopupOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animation != oldWidget.animation) {
      oldWidget.animation.removeListener(_updateIgnore);
      widget.animation.addListener(_updateIgnore);
    }
  }

  @override
  void dispose() {
    levelNotifier.dispose();
    widget.animation.removeListener(_updateIgnore);
    _visible.dispose();
    _isReverse.dispose();
    widget.onRemove();
    super.dispose();
  }

  void _updateIgnore() {
    if (widget.animation.value > 0) {
      _visible.value = true;
    } else {
      _visible.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(widget.popupState.context);
    var popupTheme = TPopupTheme.of(widget.popupState.context);
    var colorScheme = theme.colorScheme;
    var popupShadow = theme.shadow2Inset;
    var popupTopArrowShadow = [theme.shadowInsetLeft, theme.shadowInsetBottom];
    var popupLeftArrowShadow = [theme.shadowInsetLeft, theme.shadowInsetTop];
    var popupBottomArrowShadow = [theme.shadowInsetTop, theme.shadowInsetRight];
    var popupRightArrowShadow = [theme.shadowInsetRight, theme.shadowInsetBottom];

    TPopup currentPopupWidget = widget.popupState.widget;

    // 浮层样式
    var style = currentPopupWidget.style ?? popupTheme.style;

    // 浮层背景色
    var bgColorContainer = style?.backgroundColor ?? colorScheme.bgColorContainer;
    // 浮层内边距
    var padding = style?.padding ?? EdgeInsets.symmetric(vertical: 4, horizontal: TVar.spacer);

    // 当小部件完全不显示时，忽略所有事件
    Widget result = ValueListenableBuilder<bool>(
      builder: (BuildContext context, value, Widget? child) {
        return DefaultTextStyle(
          style: TextStyle(
            fontSize: theme.fontData.fontSizeBase,
            fontFamily: theme.fontFamily,
            color: colorScheme.textColorPrimary,
          ),
          child: Visibility(
            visible: value,
            maintainState: true,
            maintainAnimation: true,
            // maintainSize : true,
            child: child!,
          ),
        );
      },
      valueListenable: _visible,
      child: FadeTransition(
        opacity: widget.animation,
        child: ValueListenableBuilder(
          valueListenable: _isReverse,
          builder: (BuildContext context, bool value, Widget? child) {
            return Container(
              key: _containerKey,
              margin: style?.margin,
              clipBehavior: Clip.antiAlias,
              width: style?.width,
              height: style?.height,
              constraints: style?.constraints,
              transform: style?.transform,
              transformAlignment: style?.transformAlignment,
              decoration: ShapeDecoration(
                color: bgColorContainer,
                shadows: [...popupShadow, ...popupTopArrowShadow, ...popupRightArrowShadow, ...popupBottomArrowShadow, ...popupLeftArrowShadow],
                shape: BubbleShapeBorder(
                  smooth: 0,
                  arrowQuadraticBezierLength: 0,
                  arrowAngle: 6,
                  arrowHeight: 6,
                  direction: currentPopupWidget.showArrow
                      ? currentPopupWidget.placement.sides(
                          top: value ? BubbleDirection.top : BubbleDirection.bottom,
                          left: value ? BubbleDirection.left : BubbleDirection.right,
                          right: value ? BubbleDirection.right : BubbleDirection.left,
                          bottom: value ? BubbleDirection.bottom : BubbleDirection.top,
                        )
                      : BubbleDirection.none,
                  radius: style?.radius ?? BorderRadius.circular(TVar.borderRadiusDefault),
                  border: style?.border,
                  position: currentPopupWidget.placement.valueOf(
                    topLeft: () => BubblePosition.start(popupContentArrowSpacer),
                    top: () => const BubblePosition.center(0),
                    topRight: () => BubblePosition.end(popupContentArrowSpacer),
                    rightTop: () => BubblePosition.start(popupContentArrowSpacer),
                    right: () => const BubblePosition.center(0),
                    rightBottom: () => BubblePosition.end(popupContentArrowSpacer),
                    bottomLeft: () => BubblePosition.start(popupContentArrowSpacer),
                    bottom: () => const BubblePosition.center(0),
                    bottomRight: () => BubblePosition.end(popupContentArrowSpacer),
                    leftTop: () => BubblePosition.start(popupContentArrowSpacer),
                    left: () => const BubblePosition.center(0),
                    leftBottom: () => BubblePosition.end(popupContentArrowSpacer),
                  )!,
                ),
              ),
              padding: padding,
              child: child,
            );
          },
          child: currentPopupWidget.content ?? currentPopupWidget.builderContent?.call(context),
        ),
      ),
    );
    if (widget.onEnter != null) {
      result = MouseRegion(
        onEnter: widget.onEnter,
        child: result,
      );
    }

    // 获取定位
    var box = widget.popupState.context.findRenderObject() as RenderBox;
    var target = box.localToGlobal(
      box.size.topLeft(Offset.zero),
      ancestor: Overlay.of(widget.popupState.context)?.context.findRenderObject(),
    );

    return Positioned.fill(
      child: CustomSingleChildLayout(
        delegate: _PopupPositionDelegate(
          offset: _defaultVerticalOffset,
          placement: currentPopupWidget.placement,
          margin: 5.0,
          target: _PopupOffset.of(box.size, target),
          callback: (isReverse) {
            SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
              _isReverse.value = isReverse;
            });
          },
        ),
        child: _PopupLevel(
          overlayState: this,
          popupLevel: levelNotifier,
          child: result,
        ),
      ),
    );
  }
}
