import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

const double _kFontSizeLinkSmall = 12;
const double _kFontSizeLinkMedium = 14;
const double _kFontSizeLinkLarge = 16;
const double _kFontSizeMarkSmall = 12;
const double _kFontSizeMarkMedium = 14;
const double _kFontSizeBodySmall = 12;
const double _kFontSizeBodyMedium = 14;
const double _kFontSizeBodyLarge = 16;
const double _kFontSizeTitleSmall = 14;
const double _kFontSizeTitleMedium = 16;
const double _kFontSizeTitleLarge = 20;
const double _kFontSizeHeadlineSmall = 24;
const double _kFontSizeHeadlineMedium = 28;
const double _kFontSizeHeadlineLarge = 36;
const double _kFontSizeDisplayMedium = 48;
const double _kFontSizeDisplayLarge = 64;

/// 字体相关
class TFontData with Diagnosticable {
  const TFontData({
    required this.fontSize,
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
    required this.fontLinkSmall,
    required this.fontLinkMedium,
    required this.fontLinkLarge,
    required this.fontMarkSmall,
    required this.fontMarkMedium,
    required this.fontBodySmall,
    required this.fontBodyMedium,
    required this.fontBodyLarge,
    required this.fontTitleSmall,
    required this.fontTitleMedium,
    required this.fontTitleLarge,
    required this.fontHeadlineSmall,
    required this.fontHeadlineMedium,
    required this.fontHeadlineLarge,
    required this.fontDisplayMedium,
    required this.fontDisplayLarge,
  });

  /// font size
  final double fontSize;

  /// font size s
  double get fontSizeS => fontSizeBodySmall;

  /// font size base
  double get fontSizeBase => fontSizeBodyMedium;

  /// font size l
  double get fontSizeL => fontSizeBodyLarge;

  /// font size xl
  double get fontSizeXL => fontSizeTitleLarge;

  /// font size xxl
  double get fontSizeXXL => fontSizeHeadlineLarge;

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

  /// Font Link Small
  final TextStyle fontLinkSmall;

  /// Font Link Medium
  final TextStyle fontLinkMedium;

  /// Font Link Large
  final TextStyle fontLinkLarge;

  /// Font Mark Small
  final TextStyle fontMarkSmall;

  /// Font Mark Medium
  final TextStyle fontMarkMedium;

  /// Font Body Small
  final TextStyle fontBodySmall;

  /// Font Body Medium
  final TextStyle fontBodyMedium;

  /// Font Body Large
  final TextStyle fontBodyLarge;

  /// Font Title Small
  final TextStyle fontTitleSmall;

  /// Font Title Medium
  final TextStyle fontTitleMedium;

  /// Font Title Large
  final TextStyle fontTitleLarge;

  /// Font Headline Small
  final TextStyle fontHeadlineSmall;

  /// Font Headline Medium
  final TextStyle fontHeadlineMedium;

  /// Font Headline Large
  final TextStyle fontHeadlineLarge;

  /// Font Display Medium
  final TextStyle fontDisplayMedium;

  /// Font Display Large
  final TextStyle fontDisplayLarge;

  factory TFontData.defaultFontData(String fontFamily) {
    return TFontData(
      fontSize: 10,
      fontSizeLinkSmall: _kFontSizeLinkSmall,
      fontSizeLinkMedium: _kFontSizeLinkMedium,
      fontSizeLinkLarge: _kFontSizeLinkLarge,
      fontSizeMarkSmall: _kFontSizeMarkSmall,
      fontSizeMarkMedium: _kFontSizeMarkMedium,
      fontSizeBodySmall: _kFontSizeBodySmall,
      fontSizeBodyMedium: _kFontSizeBodyMedium,
      fontSizeBodyLarge: _kFontSizeBodyLarge,
      fontSizeTitleSmall: _kFontSizeTitleSmall,
      fontSizeTitleMedium: _kFontSizeTitleMedium,
      fontSizeTitleLarge: _kFontSizeTitleLarge,
      fontSizeHeadlineSmall: _kFontSizeHeadlineSmall,
      fontSizeHeadlineMedium: _kFontSizeHeadlineMedium,
      fontSizeHeadlineLarge: _kFontSizeHeadlineLarge,
      fontSizeDisplayMedium: _kFontSizeDisplayMedium,
      fontSizeDisplayLarge: _kFontSizeDisplayLarge,
      fontLinkSmall: TextStyle(fontSize: _kFontSizeLinkSmall, fontFamily: fontFamily),
      fontLinkMedium: TextStyle(fontSize: _kFontSizeLinkMedium, fontFamily: fontFamily),
      fontLinkLarge: TextStyle(fontSize: _kFontSizeLinkLarge, fontFamily: fontFamily),
      fontMarkSmall: TextStyle(fontSize: _kFontSizeMarkSmall, fontFamily: fontFamily, fontWeight: FontWeight.w600),
      fontMarkMedium: TextStyle(fontSize: _kFontSizeMarkMedium, fontFamily: fontFamily, fontWeight: FontWeight.w600),
      fontBodySmall: TextStyle(fontSize: _kFontSizeBodySmall, fontFamily: fontFamily),
      fontBodyMedium: TextStyle(fontSize: _kFontSizeBodyMedium, fontFamily: fontFamily),
      fontBodyLarge: TextStyle(fontSize: _kFontSizeBodyLarge, fontFamily: fontFamily),
      fontTitleSmall: TextStyle(fontSize: _kFontSizeTitleSmall, fontFamily: fontFamily, fontWeight: FontWeight.w600),
      fontTitleMedium: TextStyle(fontSize: _kFontSizeTitleMedium, fontFamily: fontFamily, fontWeight: FontWeight.w600),
      fontTitleLarge: TextStyle(fontSize: _kFontSizeTitleLarge, fontFamily: fontFamily, fontWeight: FontWeight.w600),
      fontHeadlineSmall: TextStyle(fontSize: _kFontSizeHeadlineSmall, fontFamily: fontFamily, fontWeight: FontWeight.w600),
      fontHeadlineMedium: TextStyle(fontSize: _kFontSizeHeadlineMedium, fontFamily: fontFamily, fontWeight: FontWeight.w600),
      fontHeadlineLarge: TextStyle(fontSize: _kFontSizeHeadlineLarge, fontFamily: fontFamily, fontWeight: FontWeight.w600),
      fontDisplayMedium: TextStyle(fontSize: _kFontSizeDisplayMedium, fontFamily: fontFamily, fontWeight: FontWeight.w600),
      fontDisplayLarge: TextStyle(fontSize: _kFontSizeDisplayLarge, fontFamily: fontFamily, fontWeight: FontWeight.w600),
    );
  }

  TFontData copyWith({
    double? fontSize,
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
    TextStyle? fontLinkSmall,
    TextStyle? fontLinkMedium,
    TextStyle? fontLinkLarge,
    TextStyle? fontMarkSmall,
    TextStyle? fontMarkMedium,
    TextStyle? fontBodySmall,
    TextStyle? fontBodyMedium,
    TextStyle? fontBodyLarge,
    TextStyle? fontTitleSmall,
    TextStyle? fontTitleMedium,
    TextStyle? fontTitleLarge,
    TextStyle? fontHeadlineSmall,
    TextStyle? fontHeadlineMedium,
    TextStyle? fontHeadlineLarge,
    TextStyle? fontDisplayMedium,
    TextStyle? fontDisplayLarge,
  }) {
    return TFontData(
      fontSize: fontSize ?? this.fontSize,
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
      fontLinkSmall: fontLinkSmall ?? this.fontLinkSmall,
      fontLinkMedium: fontLinkMedium ?? this.fontLinkMedium,
      fontLinkLarge: fontLinkLarge ?? this.fontLinkLarge,
      fontMarkSmall: fontMarkSmall ?? this.fontMarkSmall,
      fontMarkMedium: fontMarkMedium ?? this.fontMarkMedium,
      fontBodySmall: fontBodySmall ?? this.fontBodySmall,
      fontBodyMedium: fontBodyMedium ?? this.fontBodyMedium,
      fontBodyLarge: fontBodyLarge ?? this.fontBodyLarge,
      fontTitleSmall: fontTitleSmall ?? this.fontTitleSmall,
      fontTitleMedium: fontTitleMedium ?? this.fontTitleMedium,
      fontTitleLarge: fontTitleLarge ?? this.fontTitleLarge,
      fontHeadlineSmall: fontHeadlineSmall ?? this.fontHeadlineSmall,
      fontHeadlineMedium: fontHeadlineMedium ?? this.fontHeadlineMedium,
      fontHeadlineLarge: fontHeadlineLarge ?? this.fontHeadlineLarge,
      fontDisplayMedium: fontDisplayMedium ?? this.fontDisplayMedium,
      fontDisplayLarge: fontDisplayLarge ?? this.fontDisplayLarge,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TFontData &&
          runtimeType == other.runtimeType &&
          fontSize == other.fontSize &&
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
          fontSizeDisplayLarge == other.fontSizeDisplayLarge &&
          fontLinkSmall == other.fontLinkSmall &&
          fontLinkMedium == other.fontLinkMedium &&
          fontLinkLarge == other.fontLinkLarge &&
          fontMarkSmall == other.fontMarkSmall &&
          fontMarkMedium == other.fontMarkMedium &&
          fontBodySmall == other.fontBodySmall &&
          fontBodyMedium == other.fontBodyMedium &&
          fontBodyLarge == other.fontBodyLarge &&
          fontTitleSmall == other.fontTitleSmall &&
          fontTitleMedium == other.fontTitleMedium &&
          fontTitleLarge == other.fontTitleLarge &&
          fontHeadlineSmall == other.fontHeadlineSmall &&
          fontHeadlineMedium == other.fontHeadlineMedium &&
          fontHeadlineLarge == other.fontHeadlineLarge &&
          fontDisplayMedium == other.fontDisplayMedium &&
          fontDisplayLarge == other.fontDisplayLarge;

  @override
  int get hashCode =>
      fontSize.hashCode ^
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
      fontSizeDisplayLarge.hashCode ^
      fontLinkSmall.hashCode ^
      fontLinkMedium.hashCode ^
      fontLinkLarge.hashCode ^
      fontMarkSmall.hashCode ^
      fontMarkMedium.hashCode ^
      fontBodySmall.hashCode ^
      fontBodyMedium.hashCode ^
      fontBodyLarge.hashCode ^
      fontTitleSmall.hashCode ^
      fontTitleMedium.hashCode ^
      fontTitleLarge.hashCode ^
      fontHeadlineSmall.hashCode ^
      fontHeadlineMedium.hashCode ^
      fontHeadlineLarge.hashCode ^
      fontDisplayMedium.hashCode ^
      fontDisplayLarge.hashCode;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<double>('fontSize', fontSize, defaultValue: null));
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
    properties.add(DiagnosticsProperty<TextStyle>('fontLinkSmall', fontLinkSmall, defaultValue: null));
    properties.add(DiagnosticsProperty<TextStyle>('fontLinkMedium', fontLinkMedium, defaultValue: null));
    properties.add(DiagnosticsProperty<TextStyle>('fontLinkLarge', fontLinkLarge, defaultValue: null));
    properties.add(DiagnosticsProperty<TextStyle>('fontMarkSmall', fontMarkSmall, defaultValue: null));
    properties.add(DiagnosticsProperty<TextStyle>('fontMarkMedium', fontMarkMedium, defaultValue: null));
    properties.add(DiagnosticsProperty<TextStyle>('fontBodySmall', fontBodySmall, defaultValue: null));
    properties.add(DiagnosticsProperty<TextStyle>('fontBodyMedium', fontBodyMedium, defaultValue: null));
    properties.add(DiagnosticsProperty<TextStyle>('fontBodyLarge', fontBodyLarge, defaultValue: null));
    properties.add(DiagnosticsProperty<TextStyle>('fontTitleSmall', fontTitleSmall, defaultValue: null));
    properties.add(DiagnosticsProperty<TextStyle>('fontTitleMedium', fontTitleMedium, defaultValue: null));
    properties.add(DiagnosticsProperty<TextStyle>('fontTitleLarge', fontTitleLarge, defaultValue: null));
    properties.add(DiagnosticsProperty<TextStyle>('fontHeadlineSmall', fontHeadlineSmall, defaultValue: null));
    properties.add(DiagnosticsProperty<TextStyle>('fontHeadlineMedium', fontHeadlineMedium, defaultValue: null));
    properties.add(DiagnosticsProperty<TextStyle>('fontHeadlineLarge', fontHeadlineLarge, defaultValue: null));
    properties.add(DiagnosticsProperty<TextStyle>('fontDisplayMedium', fontDisplayMedium, defaultValue: null));
    properties.add(DiagnosticsProperty<TextStyle>('fontDisplayLarge', fontDisplayLarge, defaultValue: null));
  }
}
