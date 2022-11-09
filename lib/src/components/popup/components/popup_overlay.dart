part of '../popup.dart';

/// 浮层内容对象
class _PopupOverlay extends StatefulWidget {
  const _PopupOverlay({
    super.key,
    required this.animation,
    this.onEnter,
    required this.popupState,
    required this.onRemove,
    required this.focusScopeNode,
  });

  final Animation<double> animation;
  final PointerEnterEventListener? onEnter;
  final TPopupState popupState;
  final VoidCallback onRemove;
  final FocusScopeNode focusScopeNode;

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
    _updateShow();
    widget.animation.addListener(_updateShow);
  }

  @override
  void didUpdateWidget(covariant _PopupOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animation != oldWidget.animation) {
      oldWidget.animation.removeListener(_updateShow);
      widget.animation.addListener(_updateShow);
    }
  }

  @override
  void dispose() {
    levelNotifier.dispose();
    widget.animation.removeListener(_updateShow);
    _visible.dispose();
    _isReverse.dispose();
    widget.onRemove();
    super.dispose();
  }

  /// 在动画值大于0时显示页面
  void _updateShow() {
    if(widget.animation.isCompleted) {
      if (widget.popupState.widget.trigger != TPopupTrigger.focus && !widget.popupState._node.hasFocus) {
        widget.focusScopeNode.requestFocus();
      }
    }
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

    // 获取定位
    var box = widget.popupState.context.findRenderObject() as RenderBox;
    var target = box.localToGlobal(
      box.size.topLeft(Offset.zero),
      ancestor: Overlay.of(widget.popupState.context)?.context.findRenderObject(),
    );

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
            child: FocusScope(
              node: widget.focusScopeNode,
              skipTraversal: true,
              child: FocusTrap(
                focusScopeNode: widget.focusScopeNode,
                child: RepaintBoundary(child: child!),
              ),
            ),
          ),
        );
      },
      valueListenable: _visible,
      child: FadeTransition(
        opacity: widget.animation,
        child: ValueListenableBuilder(
          valueListenable: _isReverse,
          builder: (BuildContext context, bool value, Widget? child) {
            var boxConstraints = style?.constraints;
            if (style?.followBoxWidth == true) {
              if (boxConstraints == null) {
                boxConstraints = BoxConstraints(minWidth: box.size.width);
              } else {
                boxConstraints = boxConstraints.copyWith(minWidth: boxConstraints.constrainWidth(box.size.width));
              }
            }
            var placement = currentPopupWidget.showArrow
                ? currentPopupWidget.placement.sides(
                    top: value ? BubbleDirection.top : BubbleDirection.bottom,
                    left: value ? BubbleDirection.left : BubbleDirection.right,
                    right: value ? BubbleDirection.right : BubbleDirection.left,
                    bottom: value ? BubbleDirection.bottom : BubbleDirection.top,
                  )
                : BubbleDirection.none;
            return Container(
              key: _containerKey,
              margin: style?.margin,
              clipBehavior: Clip.antiAlias,
              width: style?.width,
              height: style?.height,
              constraints: boxConstraints,
              transform: style?.transform,
              transformAlignment: style?.transformAlignment,
              decoration: ShapeDecoration(
                color: bgColorContainer,
                shadows: style?.shadows ?? [
                  ...popupShadow,
                  if (placement == BubbleDirection.top) ...popupTopArrowShadow,
                  if (placement == BubbleDirection.right) ...popupRightArrowShadow,
                  if (placement == BubbleDirection.bottom) ...popupBottomArrowShadow,
                  if (placement == BubbleDirection.left) ...popupLeftArrowShadow
                ],
                shape: BubbleShapeBorder(
                  smooth: 1,
                  arrowQuadraticBezierLength: 0,
                  arrowAngle: 5,
                  arrowHeight: 5,
                  direction: placement,
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
          child: currentPopupWidget.content,
        ),
      ),
    );
    if (widget.onEnter != null) {
      result = MouseRegion(
        onEnter: widget.onEnter,
        child: result,
      );
    }

    return Positioned.fill(
      child: CustomSingleChildLayout(
        delegate: _PopupPositionDelegate(
          offset: _defaultVerticalOffset,
          placement: currentPopupWidget.placement,
          margin: 5.0,
          target: _PopupOffset.of(box.size, target),
          callback: (isReverse) {
            SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
              if (mounted) {
                _isReverse.value = isReverse;
              }
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
