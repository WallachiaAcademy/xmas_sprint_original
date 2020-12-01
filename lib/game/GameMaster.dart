import 'dart:math';
import 'dart:ui';

import 'package:flutter/src/gestures/tap.dart';
import 'package:xmas_sprint/entities/BaseEntity.dart';
import 'package:xmas_sprint/entities/Enemy.dart';
import 'package:xmas_sprint/entities/Santa.dart';
import 'package:xmas_sprint/game/PlayerStats.dart';
import 'package:xmas_sprint/utils/BaseWidget.dart';

class GameMaster extends BaseWidget {
  List<BaseEntity> _entities;
  int _santaCount;
  double _speed;
  PlayerStats _playerStats;

  GameMaster() {
    _entities = List<BaseEntity>();
    _speed = 60;

    _santaCount = 15;
    _playerStats = PlayerStats();
  }
  @override
  void onTapDown(TapDownDetails detail, Function fn) {
    for (var e in _entities) {
      e.onTapDown(detail);
    }
  }

  @override
  void render(Canvas canvas) {
    for (var e in _entities) {
      e.render(canvas);
    }
    _playerStats.render(canvas);
  }

  @override
  void resize() {
    for (var e in _entities) e.resize();
    _playerStats.resize();
  }

  @override
  void update(double t) {
    _cleanupEntities();
    _spawnNewEntities();
    _updateEntities(t);
  }

  void _cleanupEntities() {
    for (int i = _entities.length - 1; i >= 0; i--) {
      if (_entities.elementAt(i).isDead()) {
        _entities.removeAt(i);
      }
    }
  }

  void _spawnNewEntities() {
    if (_entities.length == 0 || _entities.last.isOnTheScreen()) {
      Random random = new Random();
      // at least 1 maximum 4
      var nrOfEntities = 1;

      // 5 seconds => 1 speed
      if (_speed < 50) {
        nrOfEntities += random.nextInt(2);
      } else if (_speed < 40) {
        nrOfEntities += random.nextInt(3);
      } else if (_speed < 20) {
        nrOfEntities += random.nextInt(4);
      }
      List<int> _offsets = [0, 1, 2, 3];
      _offsets.shuffle();

      for (int i = 0; i < nrOfEntities; i++) {
        if (_santaCount == 0) {
          _santaCount = 15;
          //var assetIdx = random.nextInt(1);
          var e = Santa(
            'santas/0',
            _offsets[i] / 5,
            _playerStats.increaseHp,
            _playerStats.decreaseHp,
          );

          e.resize();
          _entities.add(e);
        } else {
          var assetIdx = random.nextInt(3);
          var e = Enemy(
            'enemies/$assetIdx',
            _offsets[i] / 5,
            _playerStats.decreaseHp,
            _playerStats.increaseScore,
          );
          e.resize();
          _entities.add(e);
          _santaCount--;
        }
      }
    }
  }

  void _updateEntities(double t) {
    _speed -= t;
    if (_speed < 15) _speed = 15;

    for (var e in _entities) {
      e.update(t, _speed / 4);
    }
  }

  bool isGameOver() {
    return _playerStats.isGameOver();
  }

  void die() {
    _playerStats.die();
  }
}
