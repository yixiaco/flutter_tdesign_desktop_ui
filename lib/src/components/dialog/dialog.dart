import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 对话框
class TDialog extends StatelessWidget {
  const TDialog({
    Key? key,
    required this.body,
    this.cancelBtn,
    this.cancelText,
    this.cancel = false,
    this.closeBtn,
    this.closeText,
    this.close = true,
    this.closeOnEscKeyDown = false,
    this.closeOnOverlayClick = false,
    this.confirmBtn,
    this.confirmText,
    this.confirm = false,
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
    return Container();
  }
}
