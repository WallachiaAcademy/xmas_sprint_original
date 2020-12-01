import 'dart:ui';

import 'package:flame/palette.dart';
import 'package:flutter/material.dart' as STL;
import 'package:flutter/src/gestures/tap.dart';
import 'package:xmas_sprint/Constants.dart';
import 'package:xmas_sprint/common/ScreenSize.dart';
import 'package:xmas_sprint/utils/BaseWidget.dart';
import 'package:xmas_sprint/utils/StaticText.dart';

class LoadingScreen extends BaseWidget {
  static const white = PaletteEntry(STL.Colors.white);

  StaticText _loadingText;
  LoadingScreen() {
    _loadingText = StaticText(
      STL.Colors.red,
      STL.Colors.white,
      kLoadingFontRatio,
      0.5,
      0.5,
      align: WidgetAlign.Centered,
    );
  }
  @override
  void onTapDown(TapDownDetails detail, Function fn) {
    // TODO: implement onTapDown
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(
      Rect.fromLTWH(
        0,
        0,
        screenSize.width,
        screenSize.height,
      ),
      white.paint,
    );
    _loadingText.render(canvas);
  }

  @override
  void resize() {
    _loadingText.resize();
    _loadingText.update("Loading...");
  }

  @override
  void update(double t) {}
}
