import 'dart:ui';

import 'package:flutter/src/gestures/tap.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xmas_sprint/utils/Background.dart';
import 'package:xmas_sprint/utils/BaseWidget.dart';
import 'package:xmas_sprint/utils/StaticEntity.dart';

import '../../Constants.dart';
import '../ScreenManager.dart';
import '../ScreenState.dart';

class InfoScreen extends BaseWidget {
  Background _bg;

  StaticEntity _homeButton;
  StaticEntity _backButton;
  StaticEntity _nextButton;

  List<StaticEntity> _info;
  int _infoIdx;

  StaticEntity _facebook;
  StaticEntity _insta;
  StaticEntity _yt;

  InfoScreen() {
    _bg = Background('info/bg.png');
    _homeButton = StaticEntity('info/home.png');
    _backButton = StaticEntity('info/back.png');
    _nextButton = StaticEntity('info/next.png');

    _info = List<StaticEntity>();

    _info.add(StaticEntity('info/1_intro.png'));
    _info.add(StaticEntity('info/2_santa.png'));
    _info.add(StaticEntity('info/3_candy.png'));
    _info.add(StaticEntity('info/4_final.png'));

    _infoIdx = 0;

    _facebook = StaticEntity('info/1_fb.png');
    _insta = StaticEntity('info/2_insta.png');
    _yt = StaticEntity('info/3_yt.png');
  }
  @override
  void onTapDown(TapDownDetails detail, Function fn) {
    _homeButton.onTapDown(detail, () {
      screenManager.switchScreen(ScreenState.kMenuScreen);
    });

    _backButton.onTapDown(
      detail,
      () {
        _infoIdx--;
        if (_infoIdx < 0) {
          _infoIdx = 0;
        }
      },
    );
    _nextButton.onTapDown(
      detail,
      () {
        _infoIdx++;
        if (_infoIdx >= _info.length - 1) {
          _infoIdx = _info.length - 1;
        }
      },
    );

    _facebook.onTapDown(detail, () {
      _launchURL("https://www.facebook.com/Wallachia.Academy");
    });
    _insta.onTapDown(detail, () {
      _launchURL("https://www.instagram.com/wallachia.academy");
    });
    _insta.onTapDown(detail, () {
      _launchURL("https://www.instagram.com/wallachia.academy");
    });
    _yt.onTapDown(detail, () {
      _launchURL("https://www.youtube.com/channel/UCb0cBrQUG2jOLL6mq8x55Yw");
    });
  }

  @override
  void render(Canvas canvas) {
    _bg.render(canvas);
    _homeButton.render(canvas);

    if (_infoIdx > 0) {
      _backButton.render(canvas);
    }
    if (_infoIdx < _info.length - 1) {
      _nextButton.render(canvas);
    }

    _info[_infoIdx].render(canvas);
    if (_infoIdx == _info.length - 1) {
      _facebook.render(canvas);
      _insta.render(canvas);
      _yt.render(canvas);
    }
  }

  @override
  void resize() {
    _bg.resize();

    _homeButton.resize(
      wR: kInfoHomeButtonWidthRatio,
      hR: kInfoHomeButtonHeightRatio,
      xR: kInfoHomeButtonXRatio,
      yR: kInfoHomeButtonYRatio,
    );

    _backButton.resize(
      wR: kInfoSwapButtonWidthRatio,
      hR: kInfoSwapButtonHeightRatio,
      xR: kInfoLeftButtonXRatio,
      yR: kInfoLeftButtonYRatio,
    );

    _nextButton.resize(
      wR: kInfoSwapButtonWidthRatio,
      hR: kInfoSwapButtonHeightRatio,
      xR: kInfoRightButtonXRatio,
      yR: kInfoRightButtonYRatio,
    );

    for (var i in _info)
      i.resize(
        wR: kInfoLayerWidthRatio,
        hR: kInfoLayerHeightRatio,
        xR: kInfoLayerXRatio,
        yR: kInfoLayerYRatio,
      );

    _facebook.resize(
      wR: kInfoMediaWidthRatio,
      hR: kInfoMediaHeightRatio,
      xR: kInfoMediaFbXRatio,
      yR: kInfoMediaFbYRatio,
    );
  }

  @override
  void update(double t) {
    _facebook.resize(
      wR: kInfoMediaWidthRatio,
      hR: kInfoMediaHeightRatio,
      xR: kInfoMediaFbXRatio,
      yR: kInfoMediaFbYRatio,
    );
    _insta.resize(
      wR: kInfoMediaWidthRatio,
      hR: kInfoMediaHeightRatio,
      xR: kInfoMediaInstaXRatio,
      yR: kInfoMediaInstaYRatio,
    );
    _yt.resize(
      wR: kInfoMediaWidthRatio,
      hR: kInfoMediaHeightRatio,
      xR: kInfoMediaYtXRatio,
      yR: kInfoMediaYtYRatio,
    );
  }

  void _launchURL(String url) async {
    try {
      if (await canLaunch(url)) {
        launch(url);
      }
    } catch (Exception) {}
  }
}
