import 'dart:ui';

import 'package:flutter/src/gestures/tap.dart';

abstract class BaseEntity {
  void onTapDown(TapDownDetails detail);

  void render(Canvas canvas);

  void resize();

  void update(double t, double speedRatio);

  bool isDead();

  bool isOnTheScreen();

  bool exceededScreen();
}
