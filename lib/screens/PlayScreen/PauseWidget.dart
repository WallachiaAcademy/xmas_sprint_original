import 'dart:ui';

import 'package:flutter/src/gestures/tap.dart';
import 'package:xmas_sprint/Constants.dart';
import 'package:xmas_sprint/utils/BaseWidget.dart';
import 'package:xmas_sprint/utils/StaticEntity.dart';

class PauseWidget extends BaseWidget {
  StaticEntity _frame;
  StaticEntity _resume;
  StaticEntity _quit;

  final Function _onResume;
  final Function _onQuit;

  PauseWidget(this._onResume, this._onQuit) {
    _frame = StaticEntity('pause/frame.png');
    _resume = StaticEntity('pause/resume.png');
    _quit = StaticEntity('pause/quit.png');
  }

  @override
  void onTapDown(TapDownDetails detail, Function fn) {
    _resume.onTapDown(detail, _onResume);
    _quit.onTapDown(detail, _onQuit);
  }

  @override
  void render(Canvas canvas) {
    _frame.render(canvas);
    _resume.render(canvas);
    _quit.render(canvas);
  }

  @override
  void resize() {
    _frame.resize(
        wR: kPauseFrameWidthRatio,
        hR: kPauseFrameHeightRatio,
        xR: kPauseFrameXRatio,
        yR: kPauseFrameYRatio);

    _resume.resize(
        wR: kPauseResumeWidthRatio,
        hR: kPauseResumeHeightRatio,
        xR: kPauseResumeXRatio,
        yR: kPauseResumeYRatio);

    _quit.resize(
        wR: kPauseQuitWidthRatio,
        hR: kPauseQuitHeightRatio,
        xR: kPauseQuitXRatio,
        yR: kPauseQuitYRatio);
  }

  @override
  void update(double t) {}
}
