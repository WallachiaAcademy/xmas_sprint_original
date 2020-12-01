import 'dart:async';
import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:xmas_sprint/audio/MusicPlayer.dart';
import 'package:xmas_sprint/common/ScreenSize.dart';
import 'package:xmas_sprint/data/UserData.dart';
import 'package:xmas_sprint/screens/LoadingScreen/LoadingScreen.dart';
import 'package:xmas_sprint/utils/BaseWidget.dart';

import 'file:///E:/Projects/xmas_sprint_original/lib/screens/EndScreeen/EndScreen.dart';
import 'file:///E:/Projects/xmas_sprint_original/lib/screens/PlayScreen/PlayGround.dart';

import 'InfoScreen/InfoScreen.dart';
import 'MenuScreen/MenuScreen.dart';
import 'ScreenState.dart';

ScreenManager screenManager = ScreenManager();

class ScreenManager extends Game with TapDetector {
  Function _fn;
  ScreenState _screenState;

  // Screens
  BaseWidget _loadingScreen;
  BaseWidget _menuScreen;
  BaseWidget _playground;
  BaseWidget _endScreen;
  BaseWidget _infoScreen;

  ScreenManager() {
    _fn = _init;

    _screenState = ScreenState.kLoadingScreen;
  }

  @override
  void resize(Size size) {
    screenSize = size;
    _loadingScreen?.resize();
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

    _loadingScreen = LoadingScreen();

    loadAssets();
  }

  Future<void> loadAssets() async {
    userData.loadData();
    await Flame.images.loadAll(<String>[
      'common/common_bg.png',
      'end/frame.png',
      'end/home.png',
      'end/start.png',
      'enemies/0/d0.png',
      'enemies/0/d1.png',
      'enemies/0/d2.png',
      'enemies/0/d3.png',
      'enemies/0/d4.png',
      'enemies/0/d5.png',
      'enemies/0/d6.png',
      'enemies/0/d7.png',
      'enemies/0/w0.png',
      'enemies/0/w1.png',
      'enemies/0/w2.png',
      'enemies/0/w3.png',
      'enemies/0/w4.png',
      'enemies/0/w5.png',
      'enemies/0/w6.png',
      'enemies/0/w7.png',
      'enemies/0/w8.png',
      'enemies/1/d0.png',
      'enemies/1/d1.png',
      'enemies/1/d2.png',
      'enemies/1/d3.png',
      'enemies/1/d4.png',
      'enemies/1/d5.png',
      'enemies/1/d6.png',
      'enemies/1/d7.png',
      'enemies/1/w0.png',
      'enemies/1/w1.png',
      'enemies/1/w2.png',
      'enemies/1/w3.png',
      'enemies/1/w4.png',
      'enemies/1/w5.png',
      'enemies/1/w6.png',
      'enemies/1/w7.png',
      'enemies/1/w8.png',
      'enemies/2/d0.png',
      'enemies/2/d1.png',
      'enemies/2/d2.png',
      'enemies/2/d3.png',
      'enemies/2/d4.png',
      'enemies/2/d5.png',
      'enemies/2/d6.png',
      'enemies/2/d7.png',
      'enemies/2/w0.png',
      'enemies/2/w1.png',
      'enemies/2/w2.png',
      'enemies/2/w3.png',
      'enemies/2/w4.png',
      'enemies/2/w5.png',
      'enemies/2/w6.png',
      'enemies/2/w7.png',
      'enemies/2/w8.png',
      'info/1_fb.png',
      'info/1_intro.png',
      'info/2_insta.png',
      'info/2_santa.png',
      'info/3_candy.png',
      'info/3_yt.png',
      'info/4_final.png',
      'info/back.png',
      'info/bg.png',
      'info/home.png',
      'info/next.png',
      'menu/1_start.png',
      'menu/2_share.png',
      'menu/3_ranking.png',
      'menu/4_info.png',
      'menu/5_settings.png',
      'menu/candy_bar.png',
      'menu/logo.png',
      'pause/frame.png',
      'pause/quit.png',
      'pause/resume.png',
      'playground/bg.png',
      'playground/hp.png',
      'playground/pause.png',
      'santas/0/d0.png',
      'santas/0/d1.png',
      'santas/0/d10.png',
      'santas/0/d11.png',
      'santas/0/d12.png',
      'santas/0/d13.png',
      'santas/0/d14.png',
      'santas/0/d2.png',
      'santas/0/d3.png',
      'santas/0/d4.png',
      'santas/0/d5.png',
      'santas/0/d6.png',
      'santas/0/d7.png',
      'santas/0/d8.png',
      'santas/0/d9.png',
      'santas/0/w0.png',
      'santas/0/w1.png',
      'santas/0/w10.png',
      'santas/0/w11.png',
      'santas/0/w12.png',
      'santas/0/w13.png',
      'santas/0/w14.png',
      'santas/0/w2.png',
      'santas/0/w3.png',
      'santas/0/w4.png',
      'santas/0/w5.png',
      'santas/0/w6.png',
      'santas/0/w7.png',
      'santas/0/w8.png',
      'santas/0/w9.png',
    ]);

    await Flame.audio.loadAll(['song.ogg']);

    musicPlayer.update();

    switchScreen(ScreenState.kMenuScreen);
  }

  void _update(double t) {
    _getActiveScreen()?.update(t);
  }

  void onTapDown(TapDownDetails details) {
    _getActiveScreen()?.onTapDown(details, () {});
  }

  BaseWidget _getActiveScreen() {
    switch (_screenState) {
      case ScreenState.kLoadingScreen:
        return _loadingScreen;
      case ScreenState.kMenuScreen:
        return _menuScreen;
      case ScreenState.kPlayScreen:
        return _playground;
      case ScreenState.kEndScreen:
        return _endScreen;
      case ScreenState.kInfoScreen:
        return _infoScreen;
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
      case ScreenState.kInfoScreen:
        _infoScreen = InfoScreen();
        _infoScreen.resize();
        Timer(Duration(milliseconds: 100), () {
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
