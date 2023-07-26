import 'dart:ui';

import 'package:app_ui/app_ui.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('theme data', () {
    test('primary is of color', () {
      expect(
        const AppTheme().themeData.primaryColor,
        const Color(0xff1d2228),
      );
    });

    test('primary dark is of color', () {
      expect(
        const AppDarkTheme().themeData.primaryColor,
        const Color(0xff777a7e),
      );
    });
  });
}
