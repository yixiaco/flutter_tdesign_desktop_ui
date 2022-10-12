import 'package:flutter/widgets.dart';

/// 输入装饰器
/// 用于装饰输入类组件的装饰器
class TInputAdornment extends StatefulWidget {
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
  State<TInputAdornment> createState() => _TInputAdornmentState();
}

class _TInputAdornmentState extends State<TInputAdornment> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class TInputAdornmentScope extends InheritedWidget {
  const TInputAdornmentScope({
    super.key,
    required super.child,
    required this.version,
  });

  final int version;

  @override
  bool updateShouldNotify(TInputAdornmentScope oldWidget) => version != oldWidget.version;
}
