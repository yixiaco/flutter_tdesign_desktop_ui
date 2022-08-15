import 'package:flutter/foundation.dart';

/// 字体相关
class TFontData with Diagnosticable {
  const TFontData({
    required this.fontSizeLinkSmall,
    required this.fontSizeLinkMedium,
    required this.fontSizeLinkLarge,
    required this.fontSizeMarkSmall,
    required this.fontSizeMarkMedium,
    required this.fontSizeBodySmall,
    required this.fontSizeBodyMedium,
    required this.fontSizeBodyLarge,
    required this.fontSizeTitleSmall,
    required this.fontSizeTitleMedium,
    required this.fontSizeTitleLarge,
    required this.fontSizeHeadlineSmall,
    required this.fontSizeHeadlineMedium,
    required this.fontSizeHeadlineLarge,
    required this.fontSizeDisplayMedium,
    required this.fontSizeDisplayLarge,
  });

  /// font size link small
  final double fontSizeLinkSmall;

  /// font size link medium
  final double fontSizeLinkMedium;

  /// font size link large
  final double fontSizeLinkLarge;

  /// font size mark small
  final double fontSizeMarkSmall;

  /// font size mark medium
  final double fontSizeMarkMedium;

  /// font size body small
  final double fontSizeBodySmall;

  /// font size body medium
  final double fontSizeBodyMedium;

  /// font size body large
  final double fontSizeBodyLarge;

  /// font size title small
  final double fontSizeTitleSmall;

  /// font size title medium
  final double fontSizeTitleMedium;

  /// font size title large
  final double fontSizeTitleLarge;

  /// font size headline small
  final double fontSizeHeadlineSmall;

  /// font size headline medium
  final double fontSizeHeadlineMedium;

  /// font size headline large
  final double fontSizeHeadlineLarge;

  /// font size display medium
  final double fontSizeDisplayMedium;

  /// font size display large
  final double fontSizeDisplayLarge;

  factory TFontData.defaultFontData() {
    return const TFontData(
      fontSizeLinkSmall: 12,
      fontSizeLinkMedium: 14,
      fontSizeLinkLarge: 16,
      fontSizeMarkSmall: 12,
      fontSizeMarkMedium: 14,
      fontSizeBodySmall: 12,
      fontSizeBodyMedium: 14,
      fontSizeBodyLarge: 16,
      fontSizeTitleSmall: 14,
      fontSizeTitleMedium: 16,
      fontSizeTitleLarge: 20,
      fontSizeHeadlineSmall: 24,
      fontSizeHeadlineMedium: 28,
      fontSizeHeadlineLarge: 36,
      fontSizeDisplayMedium: 48,
      fontSizeDisplayLarge: 64,
    );
  }

  TFontData copyWith({
    double? fontSizeLinkSmall,
    double? fontSizeLinkMedium,
    double? fontSizeLinkLarge,
    double? fontSizeMarkSmall,
    double? fontSizeMarkMedium,
    double? fontSizeBodySmall,
    double? fontSizeBodyMedium,
    double? fontSizeBodyLarge,
    double? fontSizeTitleSmall,
    double? fontSizeTitleMedium,
    double? fontSizeTitleLarge,
    double? fontSizeHeadlineSmall,
    double? fontSizeHeadlineMedium,
    double? fontSizeHeadlineLarge,
    double? fontSizeDisplayMedium,
    double? fontSizeDisplayLarge,
  }) {
    return TFontData(
      fontSizeLinkSmall: fontSizeLinkSmall ?? this.fontSizeLinkSmall,
      fontSizeLinkMedium: fontSizeLinkMedium ?? this.fontSizeLinkMedium,
      fontSizeLinkLarge: fontSizeLinkLarge ?? this.fontSizeLinkLarge,
      fontSizeMarkSmall: fontSizeMarkSmall ?? this.fontSizeMarkSmall,
      fontSizeMarkMedium: fontSizeMarkMedium ?? this.fontSizeMarkMedium,
      fontSizeBodySmall: fontSizeBodySmall ?? this.fontSizeBodySmall,
      fontSizeBodyMedium: fontSizeBodyMedium ?? this.fontSizeBodyMedium,
      fontSizeBodyLarge: fontSizeBodyLarge ?? this.fontSizeBodyLarge,
      fontSizeTitleSmall: fontSizeTitleSmall ?? this.fontSizeTitleSmall,
      fontSizeTitleMedium: fontSizeTitleMedium ?? this.fontSizeTitleMedium,
      fontSizeTitleLarge: fontSizeTitleLarge ?? this.fontSizeTitleLarge,
      fontSizeHeadlineSmall: fontSizeHeadlineSmall ?? this.fontSizeHeadlineSmall,
      fontSizeHeadlineMedium: fontSizeHeadlineMedium ?? this.fontSizeHeadlineMedium,
      fontSizeHeadlineLarge: fontSizeHeadlineLarge ?? this.fontSizeHeadlineLarge,
      fontSizeDisplayMedium: fontSizeDisplayMedium ?? this.fontSizeDisplayMedium,
      fontSizeDisplayLarge: fontSizeDisplayLarge ?? this.fontSizeDisplayLarge,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TFontData &&
          runtimeType == other.runtimeType &&
          fontSizeLinkSmall == other.fontSizeLinkSmall &&
          fontSizeLinkMedium == other.fontSizeLinkMedium &&
          fontSizeLinkLarge == other.fontSizeLinkLarge &&
          fontSizeMarkSmall == other.fontSizeMarkSmall &&
          fontSizeMarkMedium == other.fontSizeMarkMedium &&
          fontSizeBodySmall == other.fontSizeBodySmall &&
          fontSizeBodyMedium == other.fontSizeBodyMedium &&
          fontSizeBodyLarge == other.fontSizeBodyLarge &&
          fontSizeTitleSmall == other.fontSizeTitleSmall &&
          fontSizeTitleMedium == other.fontSizeTitleMedium &&
          fontSizeTitleLarge == other.fontSizeTitleLarge &&
          fontSizeHeadlineSmall == other.fontSizeHeadlineSmall &&
          fontSizeHeadlineMedium == other.fontSizeHeadlineMedium &&
          fontSizeHeadlineLarge == other.fontSizeHeadlineLarge &&
          fontSizeDisplayMedium == other.fontSizeDisplayMedium &&
          fontSizeDisplayLarge == other.fontSizeDisplayLarge;

  @override
  int get hashCode =>
      fontSizeLinkSmall.hashCode ^
      fontSizeLinkMedium.hashCode ^
      fontSizeLinkLarge.hashCode ^
      fontSizeMarkSmall.hashCode ^
      fontSizeMarkMedium.hashCode ^
      fontSizeBodySmall.hashCode ^
      fontSizeBodyMedium.hashCode ^
      fontSizeBodyLarge.hashCode ^
      fontSizeTitleSmall.hashCode ^
      fontSizeTitleMedium.hashCode ^
      fontSizeTitleLarge.hashCode ^
      fontSizeHeadlineSmall.hashCode ^
      fontSizeHeadlineMedium.hashCode ^
      fontSizeHeadlineLarge.hashCode ^
      fontSizeDisplayMedium.hashCode ^
      fontSizeDisplayLarge.hashCode;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<double>('fontSizeLinkSmall', fontSizeLinkSmall, defaultValue: null));
    properties.add(DiagnosticsProperty<double>('fontSizeLinkMedium', fontSizeLinkMedium, defaultValue: null));
    properties.add(DiagnosticsProperty<double>('fontSizeLinkLarge', fontSizeLinkLarge, defaultValue: null));
    properties.add(DiagnosticsProperty<double>('fontSizeMarkSmall', fontSizeMarkSmall, defaultValue: null));
    properties.add(DiagnosticsProperty<double>('fontSizeMarkMedium', fontSizeMarkMedium, defaultValue: null));
    properties.add(DiagnosticsProperty<double>('fontSizeBodySmall', fontSizeBodySmall, defaultValue: null));
    properties.add(DiagnosticsProperty<double>('fontSizeBodyMedium', fontSizeBodyMedium, defaultValue: null));
    properties.add(DiagnosticsProperty<double>('fontSizeBodyLarge', fontSizeBodyLarge, defaultValue: null));
    properties.add(DiagnosticsProperty<double>('fontSizeTitleSmall', fontSizeTitleSmall, defaultValue: null));
    properties.add(DiagnosticsProperty<double>('fontSizeTitleMedium', fontSizeTitleMedium, defaultValue: null));
    properties.add(DiagnosticsProperty<double>('fontSizeTitleLarge', fontSizeTitleLarge, defaultValue: null));
    properties.add(DiagnosticsProperty<double>('fontSizeHeadlineSmall', fontSizeHeadlineSmall, defaultValue: null));
    properties.add(DiagnosticsProperty<double>('fontSizeHeadlineMedium', fontSizeHeadlineMedium, defaultValue: null));
    properties.add(DiagnosticsProperty<double>('fontSizeHeadlineLarge', fontSizeHeadlineLarge, defaultValue: null));
    properties.add(DiagnosticsProperty<double>('fontSizeDisplayMedium', fontSizeDisplayMedium, defaultValue: null));
    properties.add(DiagnosticsProperty<double>('fontSizeDisplayLarge', fontSizeDisplayLarge, defaultValue: null));
  }
}
