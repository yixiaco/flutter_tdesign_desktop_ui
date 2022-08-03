import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

final themeProvider = StateNotifierProvider<_Theme, TThemeData>((ref) {
  return _Theme(TThemeData.light());
});

class _Theme extends StateNotifier<TThemeData> {
  _Theme(super.state);

  void setBrightness(Brightness brightness) {
    state = brightness == Brightness.light ? TThemeData.light() : TThemeData.dark();
  }

  void toggle() {
    setBrightness(state.brightness == Brightness.light ? Brightness.dark : Brightness.light);
  }
}
