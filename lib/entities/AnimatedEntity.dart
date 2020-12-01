import 'dart:ui';

import 'package:flame/animation.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/src/gestures/tap.dart';
import 'package:xmas_sprint/Constants.dart';
import 'package:xmas_sprint/common/ScreenSize.dart';
import 'package:xmas_sprint/entities/EntityState.dart';

import 'BaseEntity.dart';

abstract class AnimatedEntity extends BaseEntity {
  AnimationComponent _normal;
  AnimationComponent _die;
  EntityState _state;
  double _x;

  final double _yOffset;
  final Function onComplete;
  final Function onDie;

  AnimatedEntity(
    String aniPath,
    int firstAnyCount,
    double firstAnySpeed,
    int secondAnyCount,
    double secondAnySpeed,
    this._yOffset,
    this.onComplete,
    this.onDie,
  ) {
    _state = EntityState.Normal;

    List<Sprite> _sprites = List<Sprite>();
    for (int i = 0; i < firstAnyCount; i++) {
      _sprites.add(Sprite('$aniPath/w$i.png'));
    }
    _normal = AnimationComponent(
        0, 0, Animation.spriteList(_sprites, stepTime: firstAnySpeed));

    for (int i = 0; i < secondAnyCount; i++) {
      _sprites.add(Sprite('$aniPath/d$i.png'));
    }
    _die = AnimationComponent(0, 0,
        Animation.spriteList(_sprites, stepTime: secondAnySpeed, loop: false));

    _x = 0;
  }

  bool isDead() {
    return _state == EntityState.Dead;
  }

  @override
  void onTapDown(TapDownDetails detail) {
    if (_state == EntityState.Normal) {
      var pos = detail.globalPosition;
      if (pos.dx >= _normal.x && pos.dx <= _normal.x + _normal.width) {
        if (pos.dy >= _normal.y && pos.dy <= _normal.y + _normal.height) {
          _state = EntityState.Dying;
          onDie();
        }
      }
    }
  }

  @override
  void render(Canvas canvas) {
    canvas.save();

    if (_state == EntityState.Normal) {
      _normal.x = _x;
      _normal.render(canvas);
    } else {
      _die.x = _x;
      _die.render(canvas);
    }
    canvas.restore();
  }

  @override
  void resize() {
    _normal.y = screenSize.height * _yOffset;
    _normal.width = screenSize.width * kEnemyWidthRatio;
    _normal.height = screenSize.height * kEnemyHeightRatio;

    _die.y = screenSize.height * _yOffset;
    _die.width = screenSize.width * kEnemyWidthRatio;
    _die.height = screenSize.height * kEnemyHeightRatio;

    _x = -_normal.width;
  }

  @override
  void update(double t, double speedRatio) {
    if (_state == EntityState.Normal) {
      _x += t * screenSize.width / speedRatio;
      _normal.update(t);
      if (_x > screenSize.width) {
        _state = EntityState.Dead;
        onComplete();
      }
    } else {
      _x += t * screenSize.width / speedRatio / 2;
      _die.update(t);
      if (_die.animation.done()) {
        _state = EntityState.Dead;
      }
    }
  }

  bool isOnTheScreen() {
    return _x > 0;
  }

  bool exceededScreen() {
    return _x > screenSize.width;
  }
}
