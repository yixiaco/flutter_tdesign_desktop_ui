import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

enum TDecorationSlot {
  prefix,
  suffix,
  input,
  tips,
  placeholder,
  container;
}

class TDecorator extends RenderObjectWidget with SlottedMultiChildRenderObjectWidgetMixin<TDecorationSlot> {
  const TDecorator({
    super.key,
    this.prefix,
    this.suffix,
    required this.input,
    this.tips,
    this.placeholder,
    this.container,
    this.padding,
    required this.textAlign,
    required this.direction,
    required this.textBaseline,
  });

  /// 前缀
  final Widget? prefix;

  /// 后缀
  final Widget? suffix;

  /// 输入框
  final Widget input;

  /// 提示
  final Widget? tips;

  /// 占位符
  final Widget? placeholder;

  /// 装饰器
  final Widget? container;

  /// 内容边距
  final EdgeInsetsGeometry? padding;

  /// 文本框定位
  final TextAlign textAlign;

  /// 文本方向
  final TextDirection direction;

  /// 文本基线
  final TextBaseline textBaseline;

  @override
  Widget? childForSlot(TDecorationSlot slot) {
    switch (slot) {
      case TDecorationSlot.prefix:
        return prefix;
      case TDecorationSlot.suffix:
        return suffix;
      case TDecorationSlot.input:
        return input;
      case TDecorationSlot.tips:
        return tips;
      case TDecorationSlot.placeholder:
        return placeholder;
      case TDecorationSlot.container:
        return container;
    }
  }

  @override
  TRenderDecoration createRenderObject(BuildContext context) {
    return TRenderDecoration(
      textAlign: textAlign,
      textBaseline: textBaseline,
      direction: direction,
      padding: padding,
    );
  }

  @override
  void updateRenderObject(BuildContext context, TRenderDecoration renderObject) {
    renderObject
      ..direction = direction
      ..textBaseline = textBaseline
      ..textAlign = textAlign
      ..padding = padding;
  }

  @override
  Iterable<TDecorationSlot> get slots => TDecorationSlot.values;
}

class TRenderDecoration extends RenderBox with SlottedContainerRenderObjectMixin<TDecorationSlot> {
  TRenderDecoration({
    EdgeInsetsGeometry? padding,
    required TextAlign textAlign,
    required TextDirection direction,
    required TextBaseline textBaseline,
  })  : _padding = padding,
        _textAlign = textAlign,
        _direction = direction,
        _textBaseline = textBaseline;

  RenderBox? get input => childForSlot(TDecorationSlot.input);

  RenderBox? get tips => childForSlot(TDecorationSlot.tips);

  RenderBox? get placeholder => childForSlot(TDecorationSlot.placeholder);

  RenderBox? get prefix => childForSlot(TDecorationSlot.prefix);

  RenderBox? get suffix => childForSlot(TDecorationSlot.suffix);

  RenderBox? get container => childForSlot(TDecorationSlot.container);

  // The returned list is ordered for hit testing.
  @override
  Iterable<RenderBox> get children {
    return <RenderBox>[
      if (input != null) input!,
      if (prefix != null) prefix!,
      if (suffix != null) suffix!,
      if (placeholder != null) placeholder!,
      if (container != null) container!,
    ];
  }

  /// 内容边距
  EdgeInsetsGeometry? get padding => _padding;
  EdgeInsetsGeometry? _padding;

  set padding(EdgeInsetsGeometry? value) {
    if (_padding == value) {
      return;
    }
    _padding = value;
    markNeedsLayout();
  }

  /// 文本框定位
  TextAlign get textAlign => _textAlign;
  TextAlign _textAlign;

  set textAlign(TextAlign value) {
    if (_textAlign == value) {
      return;
    }
    _textAlign = value;
    markNeedsLayout();
  }

  /// 文本方向
  TextDirection get direction => _direction;
  TextDirection _direction;

  set direction(TextDirection value) {
    if (_direction == value) {
      return;
    }
    _direction = value;
    markNeedsLayout();
  }

  /// 文本基线
  TextBaseline get textBaseline => _textBaseline;
  TextBaseline _textBaseline;

  set textBaseline(TextBaseline value) {
    if (_textBaseline == value) {
      return;
    }
    _textBaseline = value;
    markNeedsLayout();
  }

  @override
  void visitChildrenForSemantics(RenderObjectVisitor visitor) {
    if (prefix != null) {
      visitor(prefix!);
    }

    if (placeholder != null) {
      visitor(placeholder!);
    }

    if (input != null) {
      visitor(input!);
    }
    if (suffix != null) {
      visitor(suffix!);
    }
    if (container != null) {
      visitor(container!);
    }
  }

  @override
  bool get sizedByParent => false;
}
