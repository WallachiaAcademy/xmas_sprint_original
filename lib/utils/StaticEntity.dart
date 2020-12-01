import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/src/gestures/tap.dart';
import 'package:xmas_sprint/common/ScreenSize.dart';
import 'package:xmas_sprint/utils/BaseWidget.dart';

class StaticEntity extends BaseWidget {
  SpriteComponent _component;
  StaticEntity(String src) {
    _component = new SpriteComponent.fromSprite(0, 0, Sprite(src));
  }

  @override
  void onTapDown(TapDownDetails detail, Function fn) {
    if (fn != null) {
      var pos = detail.globalPosition;
      if (pos.dx >= _component.x && pos.dx <= _component.x + _component.width) {
        if (pos.dy >= _component.y &&
            pos.dy <= _component.y + _component.height) {
          fn();
        }
      }
    }
  }

  @override
  void render(Canvas canvas) {
    canvas.save();
    _component.render(canvas);
    canvas.restore();
  }

  @override
  void resize({double wR = 1, double hR = 1, double xR = 0, double yR = 0}) {
    _component.width = screenSize.width * wR;
    _component.height = screenSize.height * hR;
    _component.x = screenSize.width * xR;
    _component.y = screenSize.height * yR;
  }

  @override
  void update(double t) {
    // TODO: implement update
  }
}
