import 'dart:ui';

import 'package:flutter/cupertino.dart';

abstract class BaseWidget {
  void render(Canvas canvas);

  void resize();

  void update(double t);

  void onTapDown(TapDownDetails detail, Function fn);
}
