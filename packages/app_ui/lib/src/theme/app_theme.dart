import 'package:app_ui/app_ui.dart';

import 'package:flutter/material.dart';

/// {@template app_theme}
/// The Default App [ThemeData].
/// {@endtemplate}
class AppTheme {
  /// {@macro app_theme}
  const AppTheme();

  /// Default `ThemeData` for App UI.
  ThemeData get themeData => ThemeData(
        colorScheme: _colorScheme,
        useMaterial3: true,
        textTheme: uiTextTheme,
        primaryColor: _colorScheme.primary,
        brightness: _colorScheme.brightness,
        inputDecorationTheme: _inputTheme,
      );

  /// The UI text theme based on [UITextStyle].
  static final uiTextTheme = TextTheme(
    displayLarge: UITextStyle.headline1,
    displayMedium: UITextStyle.headline2,
    displaySmall: UITextStyle.headline3,
    headlineMedium: UITextStyle.headline4,
    headlineSmall: UITextStyle.headline5,
    titleLarge: UITextStyle.headline6,
    titleMedium: UITextStyle.subtitle1,
    titleSmall: UITextStyle.subtitle2,
    bodyLarge: UITextStyle.bodyText1,
    bodyMedium: UITextStyle.bodyText2,
    labelLarge: UITextStyle.button,
    bodySmall: UITextStyle.caption,
    labelSmall: UITextStyle.overline,
  );

  ColorScheme get _colorScheme => const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xff1d2228),
        onPrimary: Color(0xffffffff),
        primaryContainer: Color(0xffb0b2c0),
        onPrimaryContainer: Color(0xff0f0f10),
        secondary: Color(0xffea9654),
        onSecondary: Color(0xff000000),
        secondaryContainer: Color(0xffe9cbab),
        onSecondaryContainer: Color(0xff13110e),
        tertiary: Color(0xfffb8122),
        onTertiary: Color(0xff000000),
        tertiaryContainer: Color(0xffffb680),
        onTertiaryContainer: Color(0xff140f0b),
        error: Color(0xffb00020),
        onError: Color(0xffffffff),
        errorContainer: Color(0xfffcd8df),
        onErrorContainer: Color(0xff141213),
        background: Color(0xfff8f8f9),
        onBackground: Color(0xff090909),
        surface: Color(0xfff8f8f9),
        onSurface: Color(0xff090909),
        surfaceVariant: Color(0xffe2e2e3),
        onSurfaceVariant: Color(0xff111111),
        outline: Color(0xff7c7c7c),
        outlineVariant: Color(0xffc8c8c8),
        shadow: Color(0xff000000),
        scrim: Color(0xff000000),
        inverseSurface: Color(0xff111111),
        onInverseSurface: Color(0xfff5f5f5),
        inversePrimary: Color(0xff9ea2a6),
        surfaceTint: Color(0xff1d2228),
      );

  /// Input decoration theme for App UI.
  InputDecorationTheme get _inputTheme => InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.all(10),
      );
}

/// {@template app_dark_theme}
/// Dark Mode App [ThemeData].
/// {@endtemplate}
class AppDarkTheme extends AppTheme {
  /// {@macro app_dark_theme}
  const AppDarkTheme();

  @override
  ColorScheme get _colorScheme => const ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xff777a7e),
        onPrimary: Color(0xfff8f8f8),
        primaryContainer: Color(0xff313c42),
        onPrimaryContainer: Color(0xffe7e9ea),
        secondary: Color(0xffefb383),
        onSecondary: Color(0xff14120e),
        secondaryContainer: Color(0xffa75f27),
        onSecondaryContainer: Color(0xfff9eee5),
        tertiary: Color(0xfffcb075),
        onTertiary: Color(0xff14110d),
        tertiaryContainer: Color(0xffd97b18),
        onTertiaryContainer: Color(0xfffff3e3),
        error: Color(0xffcf6679),
        onError: Color(0xff140c0d),
        errorContainer: Color(0xffb1384e),
        onErrorContainer: Color(0xfffbe8ec),
        background: Color(0xff161616),
        onBackground: Color(0xffececec),
        surface: Color(0xff161616),
        onSurface: Color(0xffececec),
        surfaceVariant: Color(0xff393939),
        onSurfaceVariant: Color(0xffdfdfdf),
        outline: Color(0xff797979),
        outlineVariant: Color(0xff2d2d2d),
        shadow: Color(0xff000000),
        scrim: Color(0xff000000),
        inverseSurface: Color(0xfff8f8f8),
        onInverseSurface: Color(0xff131313),
        inversePrimary: Color(0xff424344),
        surfaceTint: Color(0xff777a7e),
      );
}
