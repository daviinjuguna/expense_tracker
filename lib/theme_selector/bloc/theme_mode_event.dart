part of 'theme_mode_bloc.dart';

@immutable
abstract class ThemeModeEvent {
  const ThemeModeEvent();
}

/// The app's [ThemeMode] has been changed
class ThemeModeChanged extends ThemeModeEvent {
  const ThemeModeChanged(this.themeMode);

  /// The new [ThemeMode]
  final ThemeMode? themeMode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ThemeModeChanged && other.themeMode == themeMode;
  }

  @override
  int get hashCode => themeMode.hashCode;
}
