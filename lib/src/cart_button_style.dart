import 'package:flutter/material.dart';

/// Theme extension for CartButtonStyle
class CartButtonTheme extends ThemeExtension<CartButtonTheme> {
  final CartButtonStyle? style;

  CartButtonTheme({this.style});

  static CartButtonStyle of(BuildContext context) {
    final theme = Theme.of(context);
    return theme.extension<CartButtonTheme>()?.style ??
        CartButtonStyle.fromColorScheme(theme.colorScheme);
  }

  @override
  ThemeExtension<CartButtonTheme> copyWith({
    CartButtonStyle? style,
  }) {
    return CartButtonTheme(style: style ?? this.style?.copyWith());
  }

  @override
  ThemeExtension<CartButtonTheme> lerp(
      ThemeExtension<CartButtonTheme>? other, double t) {
    if (other == null) return this;
    return t > 0.5 ? other : this;
  }
}

/// CartButton Style
class CartButtonStyle {
  final Color activeForegroundColor;
  final Color activeBackgroundColor;
  final Color foregroundColor;
  final Color backgroundColor;
  final BoxShape shape;
  final Radius? radius;
  final BoxBorder? border;
  final Color? shadowColor;
  final TextStyle? textStyle;
  final IconThemeData iconTheme;
  final IconData? iconPlus;
  final IconData? iconMinus;
  final double buttonAspectRatio;
  final double elevation;

  const CartButtonStyle({
    this.activeForegroundColor = Colors.white,
    this.activeBackgroundColor = Colors.blue,
    this.foregroundColor = Colors.black54,
    this.backgroundColor = Colors.white,
    this.shape = BoxShape.rectangle,
    this.radius,
    this.border,
    this.shadowColor,
    this.textStyle,
    this.iconTheme = const IconThemeData(),
    this.iconPlus,
    this.iconMinus,
    this.buttonAspectRatio = 1,
    this.elevation = 2,
  });

  factory CartButtonStyle.fromTheme(
    ThemeData theme, {
    BoxShape shape = BoxShape.rectangle,
    Radius? radius,
    BoxBorder? border,
    IconThemeData? iconTheme,
    IconData? iconPlus,
    IconData? iconMinus,
    double? buttonAspectRatio,
    double? elevation,
  }) {
    return CartButtonStyle(
      activeForegroundColor: theme.colorScheme.onPrimary,
      activeBackgroundColor: theme.colorScheme.primary,
      foregroundColor: theme.colorScheme.onSurface,
      backgroundColor: theme.colorScheme.surface,
      shadowColor: theme.colorScheme.shadow,
      shape: shape,
      radius: radius,
      border: border,
      textStyle: theme.textTheme.bodyMedium,
      iconTheme: iconTheme ?? const IconThemeData(),
      iconPlus: iconPlus,
      iconMinus: iconMinus,
      buttonAspectRatio: buttonAspectRatio ?? 1,
      elevation: elevation ?? 2,
    );
  }

  factory CartButtonStyle.fromColorScheme(
    ColorScheme colorScheme, {
    BoxShape shape = BoxShape.rectangle,
    Radius? radius,
    BoxBorder? border,
    TextStyle? textStyle,
    IconThemeData? iconTheme,
    IconData? iconPlus,
    IconData? iconMinus,
    double? buttonAspectRatio,
    double? elevation,
  }) {
    return CartButtonStyle(
      activeForegroundColor: colorScheme.onPrimary,
      activeBackgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onSurface,
      backgroundColor: colorScheme.surface,
      shadowColor: colorScheme.shadow,
      shape: shape,
      radius: radius,
      border: border,
      textStyle: textStyle,
      iconTheme: iconTheme ?? const IconThemeData(),
      iconPlus: iconPlus,
      iconMinus: iconMinus,
      elevation: elevation ?? 2,
    );
  }

  CartButtonStyle copyWith({
    Color? activeForegroundColor,
    Color? activeBackgroundColor,
    Color? foregroundColor,
    Color? backgroundColor,
    BoxShape? shape,
    Radius? radius,
    BoxBorder? border,
    bool noBorder = false,
    Color? shadowColor,
    TextStyle? textStyle,
    IconThemeData? iconTheme,
    IconData? iconPlus,
    IconData? iconMinus,
    double? buttonAspectRatio,
    double? elevation,
  }) {
    return CartButtonStyle(
      activeForegroundColor:
          activeForegroundColor ?? this.activeForegroundColor,
      activeBackgroundColor:
          activeBackgroundColor ?? this.activeBackgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      shape: shape ?? this.shape,
      radius: radius ?? this.radius,
      border: noBorder ? null : (border ?? this.border),
      shadowColor: shadowColor ?? this.shadowColor,
      textStyle: textStyle ?? this.textStyle,
      iconTheme: iconTheme ?? this.iconTheme,
      iconPlus: iconPlus ?? this.iconPlus,
      iconMinus: iconMinus ?? this.iconMinus,
      buttonAspectRatio: buttonAspectRatio ?? this.buttonAspectRatio,
      elevation: elevation ?? this.elevation,
    );
  }
}
