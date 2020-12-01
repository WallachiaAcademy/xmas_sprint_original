import 'dart:ui';

import 'package:flutter/painting.dart';
import 'package:flutter/src/gestures/tap.dart';
import 'package:xmas_sprint/common/ScreenSize.dart';

enum WidgetAlign {
  OnPoint,
  XCentered,
  YCentered,
  Centered,
}

class StaticText {
  TextPainter _painter;
  TextStyle _textStyle;
  Offset _position;

  final Color _textColor;
  final Color _shadowColor;
  final double _fontRatio;
  final double _xRatio;
  final double _yRatio;
  final WidgetAlign align;

  StaticText(
    this._textColor,
    this._shadowColor,
    this._fontRatio,
    this._xRatio,
    this._yRatio, {
    this.align = WidgetAlign.OnPoint,
  }) {
    _painter = TextPainter(
        textAlign: TextAlign.center, textDirection: TextDirection.ltr);

    _textStyle = TextStyle(
      color: _textColor,
      fontSize: screenSize.width * _fontRatio,
      fontFamily: "CevicheOne",
      shadows: <Shadow>[
        Shadow(
          blurRadius: 7,
          color: _shadowColor,
          offset: Offset(3, 3),
        )
      ],
    );

    _painter.text = TextSpan(text: '', style: _textStyle);

    _painter.layout();

    _position = Offset.zero;
  }

  void onTapDown(TapDownDetails detail, Function fn) {
    // TODO: implement onTapDown
  }

  void render(Canvas canvas) {
    _painter.paint(canvas, _position);
  }

  void resize() {
    _textStyle = TextStyle(
      color: _textColor,
      fontSize: screenSize.width * _fontRatio,
      fontFamily: "CevicheOne",
      shadows: <Shadow>[
        Shadow(
          blurRadius: 7,
          color: _shadowColor,
          offset: Offset(3, 3),
        )
      ],
    );
  }

  void update(String text) {
    _painter.text = TextSpan(text: text, style: _textStyle);

    _painter.layout();

    switch (align) {
      case WidgetAlign.OnPoint:
        _position = Offset(
          screenSize.width * _xRatio,
          screenSize.height * _yRatio,
        );
        break;
      case WidgetAlign.XCentered:
        _position = Offset(
          screenSize.width * _xRatio - _painter.width / 2,
          screenSize.height * _yRatio,
        );
        break;
      case WidgetAlign.YCentered:
        _position = Offset(
          screenSize.width * _xRatio,
          screenSize.height * _yRatio - _painter.height / 2,
        );
        break;
      case WidgetAlign.Centered:
        _position = Offset(
          screenSize.width * _xRatio - _painter.width / 2,
          screenSize.height * _yRatio - _painter.height / 2,
        );
        break;
    }
  }
}
