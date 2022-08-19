import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

class TScrollBehavior extends ScrollBehavior {
  const TScrollBehavior({
    this.thickness,
    this.mainAxisMargin,
    this.crossAxisMargin,
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

  @override
  Widget buildScrollbar(BuildContext context, Widget child, ScrollableDetails details) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;

    var thickness = this.thickness ?? 4;
    switch (getPlatform(context)) {
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return RawScrollbar(
          radius: Radius.circular(thickness / 2),
          thickness: thickness,
          thumbVisibility: true,
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
