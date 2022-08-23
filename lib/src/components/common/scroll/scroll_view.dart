import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 滚动条组件
class TSingleChildScrollView extends StatefulWidget {
  const TSingleChildScrollView({
    Key? key,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.padding,
    this.primary,
    this.physics,
    this.controller,
    this.child,
    this.dragStartBehavior = DragStartBehavior.start,
    this.clipBehavior = Clip.hardEdge,
    this.restorationId,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.thickness,
    this.mainAxisMargin,
    this.crossAxisMargin,
    this.showScroll = true,
    this.thumbVisibility = true,
    this.onShowScroll,
  }) : super(key: key);

  /// The axis along which the scroll view scrolls.
  ///
  /// Defaults to [Axis.vertical].
  final Axis scrollDirection;

  /// Whether the scroll view scrolls in the reading direction.
  ///
  /// For example, if the reading direction is left-to-right and
  /// [scrollDirection] is [Axis.horizontal], then the scroll view scrolls from
  /// left to right when [reverse] is false and from right to left when
  /// [reverse] is true.
  ///
  /// Similarly, if [scrollDirection] is [Axis.vertical], then the scroll view
  /// scrolls from top to bottom when [reverse] is false and from bottom to top
  /// when [reverse] is true.
  ///
  /// Defaults to false.
  final bool reverse;

  /// The amount of space by which to inset the child.
  final EdgeInsetsGeometry? padding;

  /// An object that can be used to control the position to which this scroll
  /// view is scrolled.
  ///
  /// Must be null if [primary] is true.
  ///
  /// A [ScrollController] serves several purposes. It can be used to control
  /// the initial scroll position (see [ScrollController.initialScrollOffset]).
  /// It can be used to control whether the scroll view should automatically
  /// save and restore its scroll position in the [PageStorage] (see
  /// [ScrollController.keepScrollOffset]). It can be used to read the current
  /// scroll position (see [ScrollController.offset]), or change it (see
  /// [ScrollController.animateTo]).
  final ScrollController? controller;

  /// Whether this is the primary scroll view associated with the parent
  /// [PrimaryScrollController].
  ///
  /// When true, the scroll view is used for default [ScrollAction]s. If a
  /// ScrollAction is not handled by an otherwise focused part of the application,
  /// the ScrollAction will be evaluated using this scroll view, for example,
  /// when executing [Shortcuts] key events like page up and down.
  ///
  /// On iOS, this identifies the scroll view that will scroll to top in
  /// response to a tap in the status bar.
  ///
  /// Defaults to true when [scrollDirection] is vertical and [controller] is
  /// not specified.
  final bool? primary;

  /// How the scroll view should respond to user input.
  ///
  /// For example, determines how the scroll view continues to animate after the
  /// user stops dragging the scroll view.
  ///
  /// Defaults to matching platform conventions.
  final ScrollPhysics? physics;

  /// The widget that scrolls.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget? child;

  /// {@macro flutter.widgets.scrollable.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.hardEdge].
  final Clip clipBehavior;

  /// {@macro flutter.widgets.scrollable.restorationId}
  final String? restorationId;

  /// {@macro flutter.widgets.scroll_view.keyboardDismissBehavior}
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  /// The thickness of the scrollbar in the cross axis of the scrollable.
  ///
  /// If null, will default to 4.0 pixels.
  final double? thickness;

  /// Distance from the scrollbar's start and end to the edge of the viewport
  /// in logical pixels. It affects the amount of available paint area.
  ///
  /// Mustn't be null and defaults to 0.
  final double? mainAxisMargin;

  /// Distance from the scrollbar thumb side to the nearest cross axis edge
  /// in logical pixels.
  ///
  /// Must not be null and defaults to 0.
  final double? crossAxisMargin;

  /// 是否显示滚动条
  final bool showScroll;

  /// 当为false时，滚动条将在滚动时显示，否则将淡出。
  /// 当为true时，滚动条将始终可见且永不淡出。
  final bool thumbVisibility;

  /// 显示滚动条事件
  final void Function(bool showScroll)? onShowScroll;

  @override
  State<TSingleChildScrollView> createState() => _TSingleChildScrollViewState();
}

class _TSingleChildScrollViewState extends State<TSingleChildScrollView> {
  late bool _showPadding;
  late bool _showScroll;

  @override
  void initState() {
    _showPadding = false;
    _showScroll = false;
    super.initState();
  }

  void _handleShowScroll(bool show) {
    if (_showScroll != show) {
      _showScroll = show;
      widget.onShowScroll?.call(show);
    }
  }

  void _handleShowPadding(bool show) {
    // 如果不显示滚动条，则不加padding
    if (!widget.showScroll) {
      return;
    }
    if (_showPadding != show) {
      setState(() {
        _showPadding = show;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var thickness = widget.thickness ?? 4;

    var crossAxisMargin = widget.crossAxisMargin;
    var mainAxisMargin = widget.mainAxisMargin;
    var padding = widget.padding;
    if (widget.scrollDirection == Axis.horizontal) {
      if (isDesktop) {
        mainAxisMargin ??= 2;
        padding ??= EdgeInsets.only(bottom: thickness + mainAxisMargin);
      }
    } else {
      if (isDesktop) {
        crossAxisMargin ??= 2;
        padding ??= EdgeInsets.only(right: thickness + crossAxisMargin);
      }
    }

    return ScrollConfiguration(
      behavior: TScrollBehavior(
        thickness: thickness,
        crossAxisMargin: crossAxisMargin,
        mainAxisMargin: mainAxisMargin,
        showScroll: widget.showScroll,
        thumbVisibility: widget.thumbVisibility,
      ),
      child: NotificationListener<ScrollMetricsNotification>(
        onNotification: (notification) {
          // 显示滚动条
          var maxScrollExtent = notification.metrics.maxScrollExtent > 0;
          _handleShowPadding(maxScrollExtent);
          _handleShowScroll(maxScrollExtent);
          return false;
        },
        child: SingleChildScrollView(
          controller: widget.controller,
          primary: widget.primary,
          clipBehavior: widget.clipBehavior,
          dragStartBehavior: widget.dragStartBehavior,
          restorationId: widget.restorationId,
          keyboardDismissBehavior: widget.keyboardDismissBehavior,
          physics: widget.physics,
          reverse: widget.reverse,
          scrollDirection: widget.scrollDirection,
          padding: _showPadding ? padding : null,
          child: widget.child,
        ),
      ),
    );
  }

  bool get isDesktop {
    switch (defaultTargetPlatform) {
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return true;
      default:
        return false;
    }
  }
}
