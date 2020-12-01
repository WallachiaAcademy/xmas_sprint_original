import 'dart:async';
import 'dart:ui';

import 'package:flame/game/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:xmas_sprint/common/ScreenSize.dart';
import 'package:xmas_sprint/utils/BaseWidget.dart';

import 'file:///E:/Projects/xmas_sprint_original/lib/screens/EndScreeen/EndScreen.dart';
import 'file:///E:/Projects/xmas_sprint_original/lib/screens/PlayScreen/PlayGround.dart';

import 'MenuScreen/MenuScreen.dart';
import 'ScreenState.dart';

ScreenManager screenManager = ScreenManager();

class ScreenManager extends Game with TapDetector {
  Function _fn;
  ScreenState _screenState;

  // Screens
  BaseWidget _menuScreen;
  BaseWidget _playground;
  BaseWidget _endScreen;

  ScreenManager() {
    _fn = _init;

    _screenState = ScreenState.kMenuScreen;
  }

  @override
  void resize(Size size) {
    screenSize = size;

    _menuScreen?.resize();
  }

  @override
  void render(Canvas canvas) {
    _getActiveScreen()?.render(canvas);
  }

  @override
  void update(double t) {
    _fn(t);
  }

  Future<void> _init(double t) async {
    _fn = _update;

    Util flameUtils = Util();
    await flameUtils.fullScreen();
    await flameUtils.setOrientation(DeviceOrientation.landscapeLeft);

    _menuScreen = MenuScreen();
  }

  void _update(double t) {
    _getActiveScreen()?.update(t);
  }

  void onTapDown(TapDownDetails details) {
    _getActiveScreen()?.onTapDown(details, () {});
  }

  BaseWidget _getActiveScreen() {
    switch (_screenState) {
      case ScreenState.kMenuScreen:
        return _menuScreen;
      case ScreenState.kPlayScreen:
        return _playground;
      case ScreenState.kEndScreen:
        return _endScreen;
      default:
        return _menuScreen;
    }
  }

  void switchScreen(ScreenState newScreen) {
    switch (newScreen) {
      case ScreenState.kMenuScreen:
        _menuScreen = MenuScreen();
        _menuScreen.resize();
        Timer(Duration(milliseconds: 100), () {
          _screenState = newScreen;
        });

        break;
      case ScreenState.kPlayScreen:
        _playground = PlayGround();
        _playground.resize();
        Timer(Duration(milliseconds: 100), () {
          _screenState = newScreen;
        });
        break;
      case ScreenState.kEndScreen:
        _endScreen = EndScreen();
        _endScreen.resize();
        Timer(Duration(milliseconds: 500), () {
          _screenState = newScreen;
        });
        break;
      default:
        _menuScreen = MenuScreen();
        _menuScreen.resize();
        Timer(Duration(milliseconds: 100), () {
          _screenState = ScreenState.kMenuScreen;
        });
        break;
    }
  }
}
