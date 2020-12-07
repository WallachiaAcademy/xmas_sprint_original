import 'dart:ui';

import 'package:flutter/material.dart' as STL;
import 'package:flutter/src/gestures/tap.dart';
import 'package:xmas_sprint/Constants.dart';
import 'package:xmas_sprint/ads/AdsManager.dart';
import 'package:xmas_sprint/data/UserData.dart';
import 'package:xmas_sprint/screens/ScreenManager.dart';
import 'package:xmas_sprint/screens/ScreenState.dart';
import 'package:xmas_sprint/utils/Background.dart';
import 'package:xmas_sprint/utils/BaseWidget.dart';
import 'package:xmas_sprint/utils/StaticEntity.dart';
import 'package:xmas_sprint/utils/StaticText.dart';

class EndScreen extends BaseWidget {
  Background _bg;
  StaticEntity _frame;
  StaticText _curScore;
  StaticText _bestScore;

  StaticEntity _play;
  StaticEntity _home;

  EndScreen() {
    _bg = Background('common/common_bg.png');
    _frame = StaticEntity('end/frame.png');
    _curScore = StaticText(
      STL.Colors.red,
      STL.Colors.black,
      kEndCurScoreFontRatio,
      kEndCurScoreCenterXRatio,
      kEndCurScoreCenterYRatio,
      align: WidgetAlign.Centered,
    );

    _bestScore = StaticText(
      STL.Colors.red,
      STL.Colors.black,
      kEndBestScoreFontRatio,
      kEndBestScoreCenterXRatio,
      kEndBestScoreCenterYRatio,
      align: WidgetAlign.Centered,
    );

    _play = StaticEntity('end/start.png');
    _home = StaticEntity('end/home.png');
  }
  @override
  void onTapDown(TapDownDetails detail, Function fn) {
    _play.onTapDown(detail, () {
      AdsManager.instance.playNewAd(() {
        screenManager.switchScreen(ScreenState.kPlayScreen);
      });
    });
    _home.onTapDown(detail, () {
      AdsManager.instance.playNewAd(() {
        screenManager.switchScreen(ScreenState.kMenuScreen);
      });
    });
  }

  @override
  void render(Canvas canvas) {
    _bg.render(canvas);
    _frame.render(canvas);
    _curScore.render(canvas);
    _bestScore.render(canvas);

    _play.render(canvas);
    _home.render(canvas);
  }

  @override
  void resize() {
    _bg.resize();
    _frame.resize(
      wR: kEndFrameWidthRatio,
      hR: kEndFrameHeightRatio,
      xR: kEndFrameXRatio,
      yR: kEndFrameYRatio,
    );

    _curScore.resize();
    _bestScore.resize();

    _play.resize(
      wR: kEndButtonWidthRatio,
      hR: kEndButtonHeightRatio,
      xR: kEndPlayButtonXRatio,
      yR: kEndPlayButtonYRatio,
    );
    _home.resize(
      wR: kEndButtonWidthRatio,
      hR: kEndButtonHeightRatio,
      xR: kEndHomeButtonXRatio,
      yR: kEndHomeButtonYRatio,
    );

    _curScore.update("CURRENT: " + userData.getCurrentScore().toString());
    _bestScore.update("BEST: " + userData.getBestScore().toString());
  }

  @override
  void update(double t) {}
}
