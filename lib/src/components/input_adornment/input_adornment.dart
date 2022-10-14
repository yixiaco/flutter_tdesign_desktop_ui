import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/src/components/common/fixed_flex.dart';
import 'package:tdesign_desktop_ui/src/components/input/input_theme.dart';
import 'package:tdesign_desktop_ui/src/theme/theme.dart';
import 'package:tdesign_desktop_ui/src/theme/theme_data.dart';

/// 输入装饰器
/// 用于装饰输入类组件的装饰器
class TInputAdornment extends StatelessWidget {
  const TInputAdornment({
    Key? key,
    this.prepend,
    this.append,
    required this.child,
  }) : super(key: key);

  /// 前缀装饰
  final Widget? prepend;

  /// 后缀装饰
  final Widget? append;

  /// 主体
  final Widget child;

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;
    var left = Radius.circular(TVar.borderRadiusDefault);
    var right = Radius.circular(TVar.borderRadiusDefault);
    if (prepend != null) {
      left = Radius.zero;
    }
    if (append != null) {
      right = Radius.zero;
    }
    var padding = EdgeInsets.symmetric(horizontal: TVar.spacer3 / 2);
    var borderSide = BorderSide(width: 1.0, color: colorScheme.borderLevel2Color);
    return DefaultTextStyle(
      style: theme.fontData.fontBodyMedium.merge(TextStyle(
        color: colorScheme.textColorPrimary,
      )),
      child: FixedCrossFlex(
        direction: Axis.horizontal,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (prepend != null)
            ClipRRect(
              borderRadius: BorderRadius.horizontal(left: Radius.circular(TVar.borderRadiusDefault)),
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme.bgColorSecondaryContainerHover,
                  border: Border(left: borderSide, top: borderSide, bottom: borderSide),
                ),
                padding: padding,
                alignment: Alignment.center,
                child: prepend!,
              ),
            ),
          Flexible(
            child: TInputTheme(
              data: TInputThemeData(
                borderRadius: BorderRadius.horizontal(left: left, right: right),
              ),
              child: child,
            ),
          ),
          if (append != null)
            ClipRRect(
              borderRadius: BorderRadius.horizontal(right: Radius.circular(TVar.borderRadiusDefault)),
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme.bgColorSecondaryContainerHover,
                  border: Border(right: borderSide, top: borderSide, bottom: borderSide),
                ),
                padding: padding,
                alignment: Alignment.center,
                child: append!,
              ),
            ),
        ],
      ),
    );
  }
}
