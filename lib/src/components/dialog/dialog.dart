import 'package:flutter/material.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

class TDialogController extends ChangeNotifier {
  bool _visible;

  bool get visible => _visible;

  set visible(bool visible) {
    if (_visible != visible) {
      _visible = visible;
      notifyListeners();
    }
  }

  TDialogController({
    bool visible = false,
  }) : _visible = visible;
}

/// 对话框
class TDialog extends StatefulWidget {
  const TDialog({
    Key? key,
    required this.controller,
    required this.body,
    this.cancelBtn,
    this.cancelText,
    this.cancel = true,
    this.closeBtn,
    this.closeText,
    this.close = true,
    this.closeOnEscKeyDown = true,
    this.closeOnOverlayClick = true,
    this.confirmBtn,
    this.confirmText,
    this.confirm = true,
    this.confirmOnEnter = false,
    this.draggable = false,
    this.showFooter = true,
    this.footer,
    this.headerText,
    this.header,
    this.showHeader = true,
    this.alignment = const Alignment(0, -.6),
    this.showOverlay = true,
    this.theme = TDialogTheme.defaultTheme,
    this.width,
    this.mode = TDialogMode.modal,
    this.onCancel,
    this.onClose,
    this.onCloseBtnClick,
    this.onClosed,
    this.onConfirm,
    this.onEscKeyDown,
    this.onOpened,
    this.onOverlayClick,
    this.destroyOnClose = false,
  }) : super(key: key);

  /// 控制对话框是否显示
  final TDialogController controller;

  /// 对话框内容
  final Widget body;

  /// 取消按钮，这会覆盖[cancelText]的行为
  final Widget? cancelBtn;

  /// 取消按钮文本
  final String? cancelText;

  /// 显示取消按钮
  final bool cancel;

  /// 关闭按钮，这会覆盖[closeText]的行为
  final Widget? closeBtn;

  /// 关闭按钮文本
  final String? closeText;

  /// 显示关闭按钮
  final bool close;

  /// 按下 ESC 时是否触发对话框关闭事件
  final bool closeOnEscKeyDown;

  /// 点击蒙层时是否触发关闭事件
  final bool closeOnOverlayClick;

  /// 确认按钮，这会覆盖[confirmText]的行为
  final Widget? confirmBtn;

  /// 确认按钮文本
  final String? confirmText;

  /// 显示确认按钮
  final bool confirm;

  /// 是否在按下回车键时，触发确认事件
  final bool confirmOnEnter;

  /// 对话框是否可以拖拽
  final bool draggable;

  /// 底部操作栏，默认会有“确认”和“取消”两个按钮。值为 true 显示默认操作按钮，值为 false 不显示任何内容
  final bool showFooter;

  /// 自定义底部内容，这会覆盖[confirmBtn]、[closeBtn]、[cancelBtn]的行为
  final Widget? footer;

  /// 头部内容文本
  final String? headerText;

  /// 头部内容，这会覆盖[headerText]的行为
  final Widget? header;

  /// 是否显示头部内容
  final bool showHeader;

  /// 对话框位置
  final Alignment alignment;

  /// 是否显示遮罩层
  final bool showOverlay;

  /// 对话框风格
  final TDialogTheme theme;

  /// 对话框宽度
  final double? width;

  /// 对话框模式
  final TDialogMode mode;

  /// 如果“取消”按钮存在，则点击“取消”按钮时触发，同时触发关闭事件
  final VoidCallback? onCancel;

  /// 关闭事件，点击取消按钮、点击关闭按钮、点击蒙层、按下 ESC 等场景下触发
  final VoidCallback? onClose;

  /// 点击右上角关闭按钮时触发
  final VoidCallback? onCloseBtnClick;

  /// 对话框消失动画效果结束后触发
  final VoidCallback? onClosed;

  /// 如果“确认”按钮存在，则点击“确认”按钮时触发，或者键盘按下回车键时触发
  final VoidCallback? onConfirm;

  /// 按下 ESC 时触发事件
  final VoidCallback? onEscKeyDown;

  /// 对话框弹出动画效果结束后触发
  final VoidCallback? onOpened;

  /// 如果蒙层存在，点击蒙层时触发
  final VoidCallback? onOverlayClick;

  /// 是否在关闭弹框的时候销毁子元素
  final bool destroyOnClose;

  @override
  State<TDialog> createState() => _TDialogState();
}

class _TDialogState extends State<TDialog> with SingleTickerProviderStateMixin {
  /// 动画控制器
  late AnimationController _controller;

  /// 默认淡入持续时间
  static const Duration _duration = Duration(milliseconds: 200);

  /// 浮层对象
  OverlayEntry? _entry;

  late CurvedAnimation _scaleAnimation;
  late CurvedAnimation _opacityAnimation;
  late TThemeData theme;
  final FocusScopeNode focusScopeNode = FocusScopeNode(debugLabel: '$_TDialogState Focus Scope');

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: _duration,
      vsync: this,
    )..addStatusListener(_handleStatusChanged);
    widget.controller.addListener(_updateListener);
    _updateListener();
    _opacityAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Cubic(.55, 0, .55, .2),
      reverseCurve: const Cubic(.55, 0, .55, .2).flipped,
    );
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Cubic(.55, 0, .55, .2),
      reverseCurve: const Cubic(.55, 0, .55, .2).flipped,
    );
  }

  void _handleStatusChanged(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      widget.onOpened?.call();
    } else if (status == AnimationStatus.dismissed) {
      _closed();
      widget.onClosed?.call();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theme = TTheme.of(context);
  }

  @override
  void didUpdateWidget(covariant TDialog oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller.removeListener(_updateListener);
      widget.controller.addListener(_updateListener);
    }
    if (widget.mode != oldWidget.mode) {
      _removeEntry();
    }
  }

  @override
  void dispose() {
    focusScopeNode.dispose();
    _opacityAnimation.dispose();
    _scaleAnimation.dispose();
    _controller.dispose();
    widget.controller.removeListener(_updateListener);
    _removeEntry();
    super.dispose();
  }

  /// 执行显示动画
  void show() {
    _controller.forward();
    Navigator.of(context).focusScopeNode.requestFocus(focusScopeNode);
  }

  /// 执行关闭动画
  void hide() {
    _controller.reverse();
    Navigator.of(context).focusScopeNode.unfocus();
  }

  /// 浮层显示状态事件
  void _updateListener() {
    if (widget.controller.visible) {
      if (_entry == null && widget.mode != TDialogMode.normal) {
        _createEntry();
      }
      show();
    } else if(_entry != null) {
      hide();
    }
  }

  /// 处理关闭事件
  void _handleOnClose() {
    hide();
    widget.onClose?.call();
  }

  /// 关闭浮层时，执行的动作
  void _closed() {
    if (widget.destroyOnClose) {
      /// 销毁
      _removeEntry();
    }
    widget.controller._visible = false;
  }

  void _removeEntry() {
    _entry?.remove();
    _entry = null;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.mode == TDialogMode.normal) {
      return _buildDialog();
    }
    return Container();
  }

  /// 创建浮层对象，以及立即插入浮层.不应该直接使用这个方法，而是使用[_showPopup]
  void _createEntry() {
    final OverlayState overlayState = Overlay.of(
      context,
      debugRequiredFor: widget,
    )!;
    var colorScheme = theme.colorScheme;

    _entry = OverlayEntry(
      builder: (BuildContext context) {
        Widget child = _buildDialog();

        child = Stack(
          children: [
            if (widget.mode == TDialogMode.modal) _buildBarrier(colorScheme, _controller),
            child,
          ],
        );

        return Positioned.fill(
          child: Actions(
            actions: <Type, Action<Intent>>{
              DismissIntent: _DismissModalAction(() {
                if (widget.closeOnEscKeyDown) {
                  hide();
                }
                widget.onEscKeyDown?.call();
              }),
              ActivateIntent: _ActivateIntent(widget.confirmOnEnter, () => widget.onConfirm?.call()),
            },
            child: FocusScope(
              node: focusScopeNode,
              child: FocusTrap(
                focusScopeNode: focusScopeNode,
                child: RepaintBoundary(
                  child: child,
                ),
              ),
            ),
          ),
        );
      },
    );
    overlayState.insert(_entry!);
  }

  Widget _buildDialog() {
    Widget child = TRawDialog(
      body: widget.body,
      cancelBtn: widget.cancelBtn,
      cancelText: widget.cancelText,
      cancel: widget.cancel,
      closeBtn: widget.closeBtn,
      closeText: widget.closeText,
      close: widget.close,
      closeOnEscKeyDown: widget.closeOnEscKeyDown,
      confirmBtn: widget.confirmBtn,
      confirmText: widget.confirmText,
      confirm: widget.confirm,
      confirmOnEnter: widget.confirmOnEnter,
      draggable: widget.draggable,
      showFooter: widget.showFooter,
      footer: widget.footer,
      headerText: widget.headerText,
      header: widget.header,
      showHeader: widget.showHeader,
      alignment: widget.alignment,
      theme: widget.theme,
      width: widget.width,
      onCancel: () {
        _handleOnClose();
        widget.onCancel?.call();
      },
      onCloseBtnClick: () {
        _handleOnClose();
        widget.onCloseBtnClick?.call();
      },
      onConfirm: widget.onConfirm,
      onEscKeyDown: widget.onEscKeyDown,
    );
    child = buildTransition(child, _controller);
    return child;
  }

  /// 遮罩
  Widget _buildBarrier(TColorScheme colorScheme, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Visibility(
          visible: animation.value != 0,
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: ModalBarrier(
              color: colorScheme.maskActive,
              barrierSemanticsDismissible: widget.showOverlay,
              dismissible: widget.closeOnOverlayClick,
              onDismiss: () {
                _handleOnClose();
                widget.onOverlayClick?.call();
              },
            ),
          ),
        );
      },
    );
  }

  /// 动画
  Widget buildTransition(Widget child, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: Visibility(
              maintainState: !widget.destroyOnClose,
              visible: animation.value != 0,
              child: child!,
            ),
          ),
        );
      },
      child: child,
    );
  }
}

class _DismissModalAction extends DismissAction {
  _DismissModalAction(this.callback);

  final VoidCallback callback;

  @override
  Object? invoke(DismissIntent intent) {
    callback();
    return null;
  }
}

class _ActivateIntent extends Action<ActivateIntent> {
  _ActivateIntent(this.isEnable, this.callback);

  final bool isEnable;

  final VoidCallback callback;

  @override
  bool isEnabled(ActivateIntent intent) {
    return isEnable;
  }

  @override
  Object? invoke(ActivateIntent intent) {
    callback();
    return null;
  }
}

/// 对话框
class TRawDialog extends StatelessWidget {
  const TRawDialog({
    Key? key,
    required this.body,
    this.cancelBtn,
    this.cancelText,
    this.cancel = true,
    this.closeBtn,
    this.closeText,
    this.close = true,
    this.closeOnEscKeyDown = false,
    this.confirmBtn,
    this.confirmText,
    this.confirm = true,
    this.confirmOnEnter = false,
    this.draggable = false,
    this.showFooter = true,
    this.footer,
    this.headerText,
    this.header,
    this.showHeader = true,
    this.alignment = const Alignment(0, -.6),
    this.theme = TDialogTheme.defaultTheme,
    this.width,
    this.onCancel,
    this.onCloseBtnClick,
    this.onConfirm,
    this.onEscKeyDown,
  }) : super(key: key);

  /// 对话框内容
  final Widget body;

  /// 取消按钮，这会覆盖[cancelText]的行为
  final Widget? cancelBtn;

  /// 取消按钮文本
  final String? cancelText;

  /// 显示取消按钮
  final bool cancel;

  /// 关闭按钮，这会覆盖[closeText]的行为
  final Widget? closeBtn;

  /// 关闭按钮文本
  final String? closeText;

  /// 显示关闭按钮
  final bool close;

  /// 按下 ESC 时是否触发对话框关闭事件
  final bool closeOnEscKeyDown;

  /// 确认按钮，这会覆盖[confirmText]的行为
  final Widget? confirmBtn;

  /// 确认按钮文本
  final String? confirmText;

  /// 显示确认按钮
  final bool confirm;

  /// 是否在按下回车键时，触发确认事件
  final bool confirmOnEnter;

  /// 对话框是否可以拖拽
  final bool draggable;

  /// 底部操作栏，默认会有“确认”和“取消”两个按钮。值为 true 显示默认操作按钮，值为 false 不显示任何内容
  final bool showFooter;

  /// 自定义底部内容，这会覆盖[confirmBtn]、[closeBtn]、[cancelBtn]的行为
  final Widget? footer;

  /// 头部内容文本
  final String? headerText;

  /// 头部内容，这会覆盖[headerText]的行为
  final Widget? header;

  /// 是否显示头部内容
  final bool showHeader;

  /// 对话框位置
  final Alignment alignment;

  /// 对话框风格
  final TDialogTheme theme;

  /// 对话框宽度
  final double? width;

  /// 如果“取消”按钮存在，则点击“取消”按钮时触发，同时触发关闭事件
  final VoidCallback? onCancel;

  /// 点击右上角关闭按钮时触发
  final VoidCallback? onCloseBtnClick;

  /// 如果“确认”按钮存在，则点击“确认”按钮时触发，或者键盘按下回车键时触发
  final VoidCallback? onConfirm;

  /// 按下 ESC 时触发事件
  final VoidCallback? onEscKeyDown;

  /// 显示对话框
  static Future<T?> dialog<T extends Object?>({
    required BuildContext context,
    required TRawDialog dialog,

    /// 对话框弹出动画效果结束后触发
    final VoidCallback? onOpened,

    /// 对话框消失动画效果结束后触发
    final VoidCallback? onClosed,
  }) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;

    return showGeneralDialog(
      context: context,
      transitionDuration: TVar.animDurationBase,
      pageBuilder: (context, animation, secondaryAnimation) {
        print('x,${animation.value}');
        return Center(child: dialog);
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        print(animation.value);
        if (animation.isCompleted) {
          onOpened?.call();
        } else if (animation.isDismissed) {
          onClosed?.call();
        }
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: const Cubic(.55, 0, .55, .2),
            reverseCurve: const Cubic(.55, 0, .55, .2).flipped,
          ),
          child: ScaleTransition(
            scale: CurvedAnimation(
              parent: animation,
              curve: const Cubic(.08, .82, .17, 1),
              reverseCurve: const Cubic(.6, .04, .98, .34).flipped,
            ),
            child: child,
          ),
        );
      },
      barrierColor: colorScheme.maskActive,
      barrierDismissible: true,
      barrierLabel: '',
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;

    EdgeInsetsGeometry padding = EdgeInsets.only(
      top: 28,
      right: TVar.spacer4,
      bottom: TVar.spacer4,
      left: TVar.spacer4,
    );
    EdgeInsetsGeometry bodyPadding = EdgeInsets.only(top: TVar.spacer2);
    EdgeInsetsGeometry bodyIconPadding = EdgeInsets.only(
      top: TVar.spacer2,
      bottom: TVar.spacer3,
      left: TVar.spacer4,
    );
    EdgeInsetsGeometry footerPadding = EdgeInsets.only(top: TVar.spacer2);
    double width = this.width ?? 480;
    double iconSize = 24;
    double closeIconSize = 20;
    var closeBgColor = MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.pressed) || states.contains(MaterialState.focused)) {
        return colorScheme.bgColorContainerActive;
      }
      if (states.contains(MaterialState.hovered)) {
        return colorScheme.bgColorContainerHover;
      }
    });
    Widget? icon;
    Widget? header = this.header ?? (headerText != null ? Text(headerText!) : null);
    Widget? cancelBtn = this.cancelBtn ??
        TButton(
          onPressed: onCancel,
          child: Text(cancelText ?? GlobalTDesignLocalizations.of(context).dialogCancel),
        );
    Widget? confirmBtn = this.confirmBtn ??
        TButton(
          themeStyle: TButtonThemeStyle.primary,
          onPressed: onConfirm,
          child: Text(confirmText ?? GlobalTDesignLocalizations.of(context).dialogConfirm),
        );
    Widget closeIcon = TMaterialStateBuilder(
      onTap: onCloseBtnClick,
      builder: (context, states) {
        return DefaultTextStyle(
          style: TextStyle(color: colorScheme.textColorSecondary, fontSize: closeIconSize),
          child: IconTheme(
            data: IconThemeData(color: colorScheme.textColorSecondary, size: closeIconSize),
            child: AnimatedContainer(
              duration: TVar.animDurationBase,
              decoration: BoxDecoration(
                color: closeBgColor.resolve(states),
                borderRadius: BorderRadius.circular(TVar.borderRadiusDefault),
              ),
              child: closeBtn ?? (closeText != null ? Text(closeText!) : const Icon(TIcons.close)),
            ),
          ),
        );
      },
    );

    Color backgroundColor = colorScheme.bgColorContainer;

    switch (this.theme) {
      case TDialogTheme.defaultTheme:
        break;
      case TDialogTheme.info:
        icon = Icon(TIcons.infoCircleFilled, size: iconSize, color: colorScheme.brandColor);
        break;
      case TDialogTheme.warning:
        icon = Icon(TIcons.errorCircleFilled, size: iconSize, color: colorScheme.warningColor);
        break;
      case TDialogTheme.danger:
        icon = Icon(TIcons.errorCircleFilled, size: iconSize, color: colorScheme.errorColor);
        break;
      case TDialogTheme.success:
        icon = Icon(TIcons.checkCircleFilled, size: iconSize, color: colorScheme.successColor);
        break;
    }

    Widget child = Material(
      color: Colors.transparent,
      elevation: 0,
      child: Container(
        padding: padding,
        width: width,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: colorScheme.borderLevel1Color),
          borderRadius: BorderRadius.circular(TVar.borderRadiusLarge),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showHeader)
              Row(
                children: [
                  if (icon != null)
                    Padding(
                      padding: EdgeInsets.only(right: TVar.spacer),
                      child: icon,
                    ),
                  if (header != null)
                    DefaultTextStyle(
                      style: theme.fontData.fontTitleMedium.merge(TextStyle(
                        color: colorScheme.textColorPrimary,
                      )),
                      child: header,
                    ),
                ],
              ),
            Padding(
              padding: icon != null ? bodyIconPadding : bodyPadding,
              child: DefaultTextStyle(
                style: theme.fontData.fontBodyMedium.merge(TextStyle(
                  color: icon != null ? colorScheme.textColorPrimary : colorScheme.textColorSecondary,
                )),
                child: body,
              ),
            ),
            if (showFooter)
              Padding(
                padding: footerPadding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (cancel) cancelBtn,
                    if (confirm)
                      Padding(
                        padding: EdgeInsets.only(left: TVar.spacer),
                        child: confirmBtn,
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );

    return Align(
      alignment: alignment,
      child: Stack(
        children: [
          child,
          if (close)
            Positioned(
              top: TVar.spacer3,
              right: TVar.spacer3,
              child: closeIcon,
            ),
        ],
      ),
    );
  }
}
