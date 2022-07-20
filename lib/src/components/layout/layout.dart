import 'package:flutter/widgets.dart';

/// 布局
/// 用于组织网页的框架结构
class TLayout extends StatelessWidget {
  const TLayout({
    Key? key,
    this.aside,
    this.header,
    this.content,
    this.footer,
  }) : super(key: key);

  /// 侧边栏，一般是一个[TAside]
  final Widget? aside;

  /// 顶栏，一般是一个[THeader]
  final Widget? header;

  /// 内容区域，一般是一个[TContent]
  final Widget? content;

  /// 底栏，一般是一个[TFooter]
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];
    if (header != null) {
      children.add(header!);
    }
    if (content != null) {
      children.add(Expanded(child: content!));
    }
    if (footer != null) {
      children.add(footer!);
    }

    Widget child = Column(
      children: children,
    );

    if (aside != null) {
      child = Row(
        children: [
          aside!,
          Expanded(child: child),
        ],
      );
    }
    return FractionallySizedBox(
      widthFactor: 1,
      heightFactor: 1,
      child: child,
    );
  }
}

/// layout布局侧边栏
class TAside extends StatelessWidget {
  const TAside({
    Key? key,
    required this.child,
    this.width = 232,
    this.color,
  }) : super(key: key);

  final Widget child;

  final double width;

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: SizedBox(
        width: width,
        height: double.infinity,
        child: child,
      ),
    );
  }
}

/// layout布局顶栏
class THeader extends StatelessWidget {
  const THeader({
    Key? key,
    required this.child,
    this.height = 64,
  }) : super(key: key);

  final Widget child;

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: child,
    );
  }
}

/// layout布局底栏
class TFooter extends StatelessWidget {
  const TFooter({
    Key? key,
    required this.child,
    this.height = 24,
  }) : super(key: key);

  final Widget child;

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: child,
    );
  }
}

/// layout布局内容区域
class TContent extends StatelessWidget {
  const TContent({
    Key? key,
    this.alignment = Alignment.topLeft,
    required this.child,
  }) : super(key: key);

  final Alignment alignment;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Align(alignment: alignment, child: child);
  }
}
