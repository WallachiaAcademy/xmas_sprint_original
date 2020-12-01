import 'dart:ui';

import 'package:flutter/src/gestures/tap.dart';
import 'package:xmas_sprint/Constants.dart';
import 'package:xmas_sprint/game/GameMaster.dart';
import 'package:xmas_sprint/screens/ScreenManager.dart';
import 'package:xmas_sprint/screens/ScreenState.dart';
import 'package:xmas_sprint/utils/Background.dart';
import 'package:xmas_sprint/utils/BaseWidget.dart';
import 'package:xmas_sprint/utils/StaticEntity.dart';

import 'file:///E:/Projects/xmas_sprint_original/lib/screens/PlayScreen/PauseWidget.dart';

class PlayGround extends BaseWidget {
  Background _bg;
  GameMaster _gameMaster;
  PauseWidget _pauseWidget;
  StaticEntity _pauseButton;

  bool _gameOver = false;
  bool _pause = false;

  PlayGround() {
    _bg = Background('playground/bg.png');
    _pauseButton = StaticEntity('playground/pause.png');

    _gameMaster = GameMaster();
    _pauseWidget = PauseWidget(() {
      _pause = false;
    }, () {
      _gameMaster.die();
      screenManager.switchScreen(ScreenState.kEndScreen);
    });
  }
  @override
  void onTapDown(TapDownDetails detail, Function fn) {
    if (!_gameOver) {
      if (_pause) {
        _pauseWidget.onTapDown(detail, null);
      } else {
        _gameMaster.onTapDown(detail, null);
        _pauseButton.onTapDown(detail, () {
          _pause = true;
        });
      }
    }
  }

  @override
  void render(Canvas canvas) {
    _bg.render(canvas);
    _gameMaster.render(canvas);
    _pauseButton.render(canvas);

    if (_pause) {
      _pauseWidget.render(canvas);
    }
  }

  @override
  void resize() {
    _bg.resize();
    _pauseButton.resize(
      wR: kPlaygroundPauseWidthRatio,
      hR: kPlaygroundPauseHeightRatio,
      xR: kPlaygroundPauseButtonXRatio,
      yR: kPlaygroundPauseButtonYRatio,
    );

    _gameMaster.resize();
    _pauseWidget.resize();
  }

  @override
  void update(double t) {
    if (_pause) {
      _pauseWidget.update(t);
    } else {
      if (!_gameOver) {
        _gameMaster.update(t);
        if (_gameMaster.isGameOver()) {
          _gameOver = true;
          screenManager.switchScreen(ScreenState.kEndScreen);
        }
      }
    }
  }
}
