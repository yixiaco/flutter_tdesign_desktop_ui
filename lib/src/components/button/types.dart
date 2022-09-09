///按钮变体枚举
enum TButtonVariant {
  /// 填充按钮
  base,

  /// 描边按钮
  outline,

  /// 虚框按钮
  dashed,

  /// 文字按钮
  text;

  /// 判断是否包含类型
  bool contain({
    bool base = false,
    bool outline = false,
    bool dashed = false,
    bool text = false,
  }) {
    switch (this) {
      case TButtonVariant.base:
        return base;
      case TButtonVariant.outline:
        return outline;
      case TButtonVariant.dashed:
        return dashed;
      case TButtonVariant.text:
        return text;
    }
  }

  /// 根据按钮形式，返回对应的值
  T variantOf<T>({required T base, required T outline, required T dashed, required T text}) {
    switch (this) {
      case TButtonVariant.base:
        return base;
      case TButtonVariant.outline:
        return outline;
      case TButtonVariant.dashed:
        return dashed;
      case TButtonVariant.text:
        return text;
    }
  }
}

/// 预定义的一组形状
enum TButtonShape {
  /// 长方形
  rectangle,

  /// 正方形
  square,

  /// 圆角长方形
  round,

  /// 圆形
  circle;

  /// 根据按钮形状，返回对应的值
  T valueOf<T>({required T rectangle, required T square, required T round, required T circle}) {
    switch (this) {
      case TButtonShape.rectangle:
        return rectangle;
      case TButtonShape.square:
        return square;
      case TButtonShape.round:
        return round;
      case TButtonShape.circle:
        return circle;
    }
  }
}

/// 按钮组件风格
enum TButtonThemeStyle {
  /// 默认色
  defaultStyle,

  /// 品牌色
  primary,

  /// 危险色
  danger,

  /// 告警色
  warning,

  /// 成功色
  success;

  T valueOf<T>({required T defaultStyle, required T primary, required T danger, required T warning, required T success}) {
    switch (this) {
      case TButtonThemeStyle.defaultStyle:
        return defaultStyle;
      case TButtonThemeStyle.primary:
        return primary;
      case TButtonThemeStyle.danger:
        return danger;
      case TButtonThemeStyle.warning:
        return warning;
      case TButtonThemeStyle.success:
        return success;
    }
  }

  T isDefaultOf<T>({required T defaultStyle, required T other}) {
    switch (this) {
      case TButtonThemeStyle.defaultStyle:
        return defaultStyle;
      case TButtonThemeStyle.primary:
        return other;
      case TButtonThemeStyle.danger:
        return other;
      case TButtonThemeStyle.warning:
        return other;
      case TButtonThemeStyle.success:
        return other;
    }
  }
}
