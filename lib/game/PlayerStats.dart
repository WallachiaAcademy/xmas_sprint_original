import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart' as STL;
import 'package:flutter/src/gestures/tap.dart';
import 'package:xmas_sprint/Constants.dart';
import 'package:xmas_sprint/common/ScreenSize.dart';
import 'package:xmas_sprint/data/UserData.dart';
import 'package:xmas_sprint/utils/BaseWidget.dart';
import 'package:xmas_sprint/utils/StaticText.dart';

class PlayerStats extends BaseWidget {
  SpriteComponent _hp;
  int _hpCount;
  int _score;
  StaticText _staticText;

  PlayerStats() {
    _hpCount = 3;
    _score = 0;

    _hp = SpriteComponent.fromSprite(0, 0, Sprite('playground/hp.png'));
    _staticText = StaticText(
      STL.Colors.red,
      STL.Colors.black,
      kPlaygroundScoreFontRatio,
      kPlaygroundScoreXRatio,
      kPlaygroundScoreCenterYRatio,
      align: WidgetAlign.YCentered,
    );
  }

  @override
  void onTapDown(TapDownDetails detail, Function fn) {
    // TODO: implement onTapDown
  }

  @override
  void render(Canvas canvas) {
    for (int i = 1; i <= _hpCount; i++) {
      canvas.save();
      _hp.x = screenSize.width * kPlaygroundHpXRatio -
          (screenSize.width * kPlaygroundHpWidthRatio) *
              i *
              kPlaygroundHpGapRatio;
      _hp.render(canvas);
      canvas.restore();
    }
    _staticText.render(canvas);
  }

  @override
  void resize() {
    _hp.y = screenSize.height * kPlaygroundHpYRatio;
    _hp.width = screenSize.width * kPlaygroundHpWidthRatio;
    _hp.height = screenSize.height * kPlaygroundHpHeightRatio;

    _staticText.resize();
    _staticText.update(_score.toString());
  }

  @override
  void update(double t) {}

  void increaseHp() {
    if (_hpCount < 5)
      _hpCount++;
    else
      _score += 15;
  }

  void increaseScore() {
    _score += 1;
    _staticText.update(_score.toString());
  }

  void decreaseHp() {
    //if (_hpCount > 0) _hpCount--;

    if (_hpCount <= 0) {
      _dumpData();
    }
  }

  bool isGameOver() {
    return _hpCount <= 0;
  }

  void die() {
    // TODO: pass here the score
    _hpCount = 0;
    _dumpData();
  }

  void _dumpData() {
    userData.setScore(_score);
  }

  int getScore() {
    return _score;
  }
}
