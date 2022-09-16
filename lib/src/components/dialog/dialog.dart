import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 对话框
class TDialog extends StatelessWidget {
  const TDialog({
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
          child: Text(cancelText ?? '取消'),
        );
    Widget? confirmBtn = this.confirmBtn ??
        TButton(
          themeStyle: TButtonThemeStyle.primary,
          onPressed: onConfirm,
          child: Text(confirmText ?? '确定'),
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
    );

    if (close) {
      child = Stack(
        children: [
          child,
          Positioned(
            top: TVar.spacer3,
            right: TVar.spacer3,
            child: closeIcon,
          ),
        ],
      );
    }

    return child;
  }
}
