import 'package:flutter/material.dart';
import 'package:tdesign_desktop_ui/src/components/tooltip/tooltip.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// tips提示信息
class TJumperTips {
  TJumperTips({
    this.prev,
    this.current,
    this.next,
  });

  /// 向前
  String? prev;

  /// 当前
  String? current;

  /// 向后
  String? next;
}

/// 按钮形式
enum TJumperVariant {
  text,
  outline;
}

enum TJumperTrigger {
  /// 向前
  prev,

  /// 当前
  current,

  /// 向后
  next;
}

/// 跳转
class TJumper extends StatelessWidget {
  const TJumper({
    Key? key,
    this.disabled = false,
    this.layout = Axis.horizontal,
    this.showCurrent = true,
    this.size,
    this.tips,
    this.variant = TJumperVariant.text,
    this.onChange,
  }) : super(key: key);

  /// 按钮禁用配置
  final bool disabled;

  /// 布局方向
  final Axis layout;

  /// 是否展示当前按钮
  final bool showCurrent;

  /// 组件大小
  final TComponentSize? size;

  /// 按钮形式
  final TJumperVariant variant;

  /// 提示信息
  final TJumperTips? tips;

  /// 事件回调
  final TJumperChange? onChange;

  @override
  Widget build(BuildContext context) {
    TButtonVariant buttonVariant;
    TBorderSide? borderSide;
    BorderRadiusGeometry? radius;
    if(variant == TJumperVariant.outline) {
      buttonVariant = TButtonVariant.outline;
      borderSide = const TBorderSide(color: Colors.transparent);
      radius = BorderRadius.zero;
    } else {
      buttonVariant = TButtonVariant.text;
    }
    var children = [
      TTooltip(
        message: tips?.prev,
        child: TButton(
          disabled: disabled,
          variant: buttonVariant,
          shape: TButtonShape.square,
          side: borderSide,
          radius: radius,
          icon: layout == Axis.horizontal ? TIcons.chevronLeft : TIcons.chevronUp,
          onPressed: () => onChange?.call(TJumperTrigger.prev),
        ),
      ),
      Visibility(
        visible: showCurrent,
        child: TTooltip(
          message: tips?.current,
          child: TButton(
            disabled: disabled,
            variant: buttonVariant,
            shape: TButtonShape.square,
            side: borderSide,
            radius: radius,
            icon: TIcons.round,
            onPressed: () => onChange?.call(TJumperTrigger.current),
          ),
        ),
      ),
      TTooltip(
        message: tips?.next,
        child: TButton(
          disabled: disabled,
          variant: buttonVariant,
          shape: TButtonShape.square,
          side: borderSide,
          radius: radius,
          icon: layout == Axis.horizontal ? TIcons.chevronRight : TIcons.chevronDown,
          onPressed: () => onChange?.call(TJumperTrigger.next),
        ),
      ),
    ];

    if (variant == TJumperVariant.outline) {
      return THollow(
        children: List.generate(children.length, (index) => THollowChild(child: children[index])),
      );
    }

    return TSpace(
      spacing: 0,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }
}
