import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

class TScrollBehavior extends ScrollBehavior {
  const TScrollBehavior({
    this.thickness,
    this.mainAxisMargin,
    this.crossAxisMargin,
    this.showScroll = true,
    this.thumbVisibility = true,
  });

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

  @override
  Widget buildScrollbar(BuildContext context, Widget child, ScrollableDetails details) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;

    var thickness = this.thickness ?? 4;
    switch (getPlatform(context)) {
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        if (!showScroll) {
          return child;
        }
        return RawScrollbar(
          radius: Radius.circular(thickness / 2),
          thickness: thickness,
          thumbVisibility: thumbVisibility,
          thumbColor: colorScheme.scrollbarColor,
          trackColor: colorScheme.scrollTrackColor,
          minThumbLength: 6,
          minOverscrollLength: 6,
          controller: details.controller,
          crossAxisMargin: crossAxisMargin ?? 0,
          mainAxisMargin: mainAxisMargin ?? 0,
          child: child,
        );
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.iOS:
        return child;
    }
  }

  @override
  bool shouldNotify(TScrollBehavior oldDelegate) {
    return thickness != oldDelegate.thickness;
  }
}
