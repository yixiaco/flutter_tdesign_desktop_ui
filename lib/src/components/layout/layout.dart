import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 布局
/// 用于组织框架结构
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
      mainAxisSize: MainAxisSize.min,
      children: children,
    );

    if (aside != null) {
      child = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          aside!,
          Expanded(child: child),
        ],
      );
    }
    var theme = TTheme.of(context);
    return DefaultTextStyle(
      style: TextStyle(
        fontFamily: theme.fontFamily,
        color: theme.colorScheme.textColorPrimary,
        fontSize: theme.fontSize,
      ),
      child: child,
    );
  }
}

/// layout布局侧边栏
class TAside extends StatelessWidget {
  const TAside({
    Key? key,
    this.child,
    this.width = 232,
    this.color,
  }) : super(key: key);

  final Widget? child;

  final double width;

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Semantics(
          container: true,
          child: Container(
            color: color,
            child: SizedBox(
              width: width,
              height: constraints.maxHeight,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: width, maxHeight: constraints.maxHeight),
                child: child,
              ),
            ),
          ),
        );
      },
    );
  }
}

/// layout布局顶栏
class THeader extends StatelessWidget {
  const THeader({
    Key? key,
    this.child,
    this.height = 64,
  }) : super(key: key);

  final Widget? child;

  final double height;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Semantics(
          container: true,
          child: SizedBox(
            height: height,
            width: constraints.maxWidth,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: constraints.maxWidth, maxHeight: height),
              child: child,
            ),
          ),
        );
      },
    );
  }
}

/// layout布局底栏
class TFooter extends StatelessWidget {
  const TFooter({
    Key? key,
    this.child,
    this.height = 24,
  }) : super(key: key);

  final Widget? child;

  final double height;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Semantics(
          container: true,
          child: SizedBox(
            height: height,
            width: constraints.maxWidth,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: constraints.maxWidth, maxHeight: height),
              child: child,
            ),
          ),
        );
      },
    );
  }
}

/// layout布局内容区域
class TContent extends StatelessWidget {
  const TContent({
    Key? key,
    this.alignment = Alignment.topLeft,
    this.child,
  }) : super(key: key);

  final Alignment alignment;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Semantics(
          container: true,
          child: Align(
            alignment: alignment,
            child: ConstrainedBox(
              constraints: constraints,
              child: child,
            ),
          ),
        );
      },
    );
  }
}
