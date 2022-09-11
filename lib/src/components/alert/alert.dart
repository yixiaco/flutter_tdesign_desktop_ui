import 'package:flutter/material.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 警告
/// 警告条用于承载需要用户注意的信息。
class TAlert extends StatefulWidget {
  const TAlert({
    Key? key,
    this.closeIcon,
    this.showClose = false,
    this.icon,
    this.maxLine = 0,
    this.message,
    this.operation,
    this.theme = TAlertTheme.info,
    this.title,
    this.onClose,
    this.onClosed,
    this.maxSize = false,
  }) : super(key: key);

  /// 关闭icon
  final Widget? closeIcon;

  /// 是否显示关闭icon
  final bool showClose;

  /// 图标
  final Widget? icon;

  /// 内容显示最大行数，超出的内容会折叠收起，用户点击后再展开。值为 0 表示不折叠
  final int maxLine;

  /// 内容（子元素）
  final Widget? message;

  /// 跟在告警内容后面的操作区。
  final Widget? operation;

  /// 组件风格
  final TAlertTheme theme;

  /// 标题
  final Widget? title;

  /// 关闭按钮点击时触发
  final VoidCallback? onClose;

  /// 告警提示框关闭动画结束后触发
  final VoidCallback? onClosed;

  /// 是否占满一整行
  final bool maxSize;

  @override
  State<TAlert> createState() => _TAlertState();
}

class _TAlertState extends State<TAlert> {
  late double _opacity;

  @override
  void initState() {
    _opacity = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;

    Color backgroundColor;
    Color iconColor;
    MaterialStateProperty<Color> operationColor = MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.focused) || states.contains(MaterialState.pressed)) {
        return colorScheme.brandColorActive;
      }
      if (states.contains(MaterialState.hovered)) {
        return colorScheme.brandColorHover;
      }
      return colorScheme.brandColor;
    });
    Widget? icon = widget.icon;
    Widget? title;
    Widget? message;
    Widget? closeIcon = widget.closeIcon;
    Widget? operation;

    switch (widget.theme) {
      case TAlertTheme.success:
        backgroundColor = colorScheme.successColor2;
        iconColor = colorScheme.successColor;
        icon ??= const Icon(TIcons.checkCircleFilled);
        break;
      case TAlertTheme.info:
        backgroundColor = colorScheme.brandColorFocus;
        iconColor = colorScheme.brandColor;
        icon ??= const Icon(TIcons.infoCircleFilled);
        break;
      case TAlertTheme.warning:
        backgroundColor = colorScheme.warningColor2;
        iconColor = colorScheme.warningColor;
        icon ??= const Icon(TIcons.errorCircleFilled);
        break;
      case TAlertTheme.error:
        backgroundColor = colorScheme.errorColor2;
        iconColor = colorScheme.errorColor;
        icon ??= const Icon(TIcons.errorCircleFilled);
        break;
    }
    // 操作按钮
    if (widget.operation != null) {
      operation = Padding(
        padding: EdgeInsets.symmetric(horizontal: TVar.spacer),
        child: TMaterialStateBuilder(
          builder: (context, states) {
            return DefaultTextStyle.merge(
              style: TextStyle(
                color: operationColor.resolve(states),
              ),
              child: widget.operation!,
            );
          },
        ),
      );
    }
    // icon
    icon = IconTheme(
      data: IconThemeData(color: iconColor, size: 18),
      child: icon,
    );
    // 标题
    if (widget.title != null) {
      title = DefaultTextStyle.merge(
        style: TextStyle(
          color: colorScheme.textColorPrimary,
          fontWeight: FontWeight.bold,
        ),
        child: widget.title!,
      );
    }
    //消息
    if (widget.message != null) {
      message = DefaultTextStyle.merge(
        style: TextStyle(
          color: colorScheme.textColorSecondary,
        ),
        child: widget.message!,
      );
      if (widget.title != null) {
        message = Padding(
          padding: EdgeInsets.only(top: TVar.spacer),
          child: message,
        );
      }
    }
    if(message != null || operation != null){
      message = Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if(message != null) message,
          if(operation != null) operation,
        ],
      );
    }
    // 关闭按钮
    closeIcon ??= const Icon(TIcons.close);
    closeIcon = Container(
      height: 18,
      alignment: Alignment.center,
      child: IconTheme.merge(
        data: IconThemeData(
          color: colorScheme.textColorSecondary,
        ),
        child: closeIcon,
      ),
    );

    return AnimatedOpacity(
      opacity: _opacity,
      duration: const Duration(milliseconds: 200),
      onEnd: widget.onClosed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(TVar.borderRadiusMedium),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            icon,
            Flexible(
              fit: widget.maxSize ? FlexFit.tight : FlexFit.loose,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: DefaultTextStyle(
                  style: theme.fontData.fontBodyMedium,
                  child: IconTheme(
                    data: IconThemeData(
                      size: theme.fontData.fontBodyMedium.fontSize,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (title != null) title,
                        if (message != null) message,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (widget.showClose && _opacity == 1)
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    widget.onClose?.call();
                    setState(() {
                      _opacity = 0;
                    });
                  },
                  child: closeIcon,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
