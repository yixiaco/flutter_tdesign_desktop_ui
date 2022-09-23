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
    this.closeOnEscKeyDown = false,
    this.closeOnOverlayClick = false,
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

class _TDialogState extends State<TDialog> {
  /// 浮层对象
  OverlayEntry? _entry;
  final GlobalKey<_TRawDialogState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateListener);
    _updateListener();
  }

  @override
  void didUpdateWidget(covariant TDialog oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller.removeListener(_updateListener);
      widget.controller.addListener(_updateListener);
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller.removeListener(_updateListener);
    _entry?.remove();
  }

  /// 浮层显示状态事件
  void _updateListener() {
    if (widget.controller.visible) {
      if (_entry == null) {
        _createEntry();
      } else {
        _key.currentState?.show();
      }
    } else {
      _key.currentState?.hide();
    }
  }

  /// 关闭浮层时，执行的动作
  void _closed() {
    if (widget.destroyOnClose) {
      /// 销毁
      _entry?.remove();
      _entry = null;
    }
    widget.controller._visible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  /// 创建浮层对象，以及立即插入浮层.不应该直接使用这个方法，而是使用[_showPopup]
  void _createEntry() {
    final OverlayState overlayState = Overlay.of(
      context,
      debugRequiredFor: widget,
    )!;

    _entry = OverlayEntry(
      builder: (BuildContext context) {
        return TRawDialog(
          key: _key,
          body: widget.body,
          cancelBtn: widget.cancelBtn,
          cancelText: widget.cancelText,
          cancel: widget.cancel,
          closeBtn: widget.closeBtn,
          closeText: widget.closeText,
          close: widget.close,
          closeOnEscKeyDown: widget.closeOnEscKeyDown,
          closeOnOverlayClick: widget.closeOnOverlayClick,
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
          showOverlay: widget.showOverlay,
          theme: widget.theme,
          width: widget.width,
          mode: widget.mode,
          onCancel: widget.onCancel,
          onClose: widget.onClose,
          onCloseBtnClick: widget.onCloseBtnClick,
          onClosed: () {
            _closed();
            widget.onClosed?.call();
          },
          onConfirm: widget.onConfirm,
          onEscKeyDown: widget.onEscKeyDown,
          onOpened: widget.onOpened,
          onOverlayClick: widget.onOverlayClick,
        );
      },
    );
    overlayState.insert(_entry!);
  }
}

/// 对话框
class TRawDialog extends StatefulWidget {
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
    this.closeOnOverlayClick = false,
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
    this.mode = TDialogMode.normal,
    this.onCancel,
    this.onClose,
    this.onCloseBtnClick,
    this.onClosed,
    this.onConfirm,
    this.onEscKeyDown,
    this.onOpened,
    this.onOverlayClick,
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
  State<TRawDialog> createState() => _TRawDialogState();
}

class _TRawDialogState extends State<TRawDialog> with SingleTickerProviderStateMixin {
  /// 动画控制器
  late AnimationController _controller;

  /// 默认淡入持续时间
  static const Duration _duration = Duration(milliseconds: 200);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: _duration,
      vsync: this,
    )..addStatusListener(_handleStatusChanged);
    show();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleStatusChanged(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      widget.onOpened?.call();
    } else if (status == AnimationStatus.dismissed) {
      widget.onClosed?.call();
    }
  }

  /// 执行显示动画
  void show() {
    _controller.forward();
  }

  /// 执行关闭动画
  void hide() {
    _controller.reverse();
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
    double width = widget.width ?? 480;
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
    Widget? header = widget.header ?? (widget.headerText != null ? Text(widget.headerText!) : null);
    Widget? cancelBtn = widget.cancelBtn ??
        TButton(
          onPressed: () {
            hide();
            widget.onCancel?.call();
          },
          child: Text(widget.cancelText ?? GlobalTDesignLocalizations.of(context).dialogCancel),
        );
    Widget? confirmBtn = widget.confirmBtn ??
        TButton(
          themeStyle: TButtonThemeStyle.primary,
          onPressed: widget.onConfirm,
          child: Text(widget.confirmText ?? GlobalTDesignLocalizations.of(context).dialogConfirm),
        );
    Widget closeIcon = TMaterialStateBuilder(
      onTap: () {
        hide();
        widget.onCloseBtnClick?.call();
      },
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
              child: widget.closeBtn ?? (widget.closeText != null ? Text(widget.closeText!) : const Icon(TIcons.close)),
            ),
          ),
        );
      },
    );

    Color backgroundColor = colorScheme.bgColorContainer;

    switch (widget.theme) {
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

    Widget child = Container(
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
          if (widget.showHeader)
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
              child: widget.body,
            ),
          ),
          if (widget.showFooter)
            Padding(
              padding: footerPadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (widget.cancel) cancelBtn,
                  if (widget.confirm)
                    Padding(
                      padding: EdgeInsets.only(left: TVar.spacer),
                      child: confirmBtn,
                    ),
                ],
              ),
            ),
        ],
      ),
    );

    child = Stack(
      children: [
        if (widget.mode == TDialogMode.modal) Positioned.fill(child: _buildBarrier(colorScheme)),
        child,
        if (widget.close)
          Positioned(
            top: TVar.spacer3,
            right: TVar.spacer3,
            child: closeIcon,
          ),
      ],
    );

    child = Align(
      alignment: widget.alignment,
      child: child,
    );

    return buildTransition(child, _controller);
  }

  Widget _buildBarrier(TColorScheme colorScheme) {
    return ModalBarrier(
      color: colorScheme.maskActive,
      barrierSemanticsDismissible: widget.showOverlay,
      dismissible: widget.closeOnOverlayClick,
      onDismiss: () {
        hide();
        widget.onOverlayClick?.call();
      },
    );
  }

  Widget buildTransition(Widget child, Animation<double> animation) {
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
  }
}
