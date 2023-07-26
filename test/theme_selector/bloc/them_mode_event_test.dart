import 'package:expense_tracker/theme_selector/theme_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ThemeModeEvent', () {
    final themeModeEvent = ThemeModeChanged(ThemeMode.dark);
    expect(themeModeEvent, isInstanceOf<ThemeModeEvent>());
    // expect(themeModeEvent.props, []);
  });

  test("Equality works", () {
    final dark = ThemeModeChanged(ThemeMode.dark);
    final light = ThemeModeChanged(ThemeMode.light);
    expect(dark, ThemeModeChanged(ThemeMode.dark));
    //false
    expect(dark == light, isFalse);
  });

  //test for hashcode
  test("Hashcode works", () {
    final dark = ThemeModeChanged(ThemeMode.dark);
    final light = ThemeModeChanged(ThemeMode.light);
    expect(dark.hashCode, ThemeModeChanged(ThemeMode.dark).hashCode);
    //false
    expect(dark.hashCode == light.hashCode, isFalse);
  });
}
