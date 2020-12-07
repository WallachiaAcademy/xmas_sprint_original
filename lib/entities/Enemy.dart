import 'package:xmas_sprint/entities/AnimatedEntity.dart';

class Enemy extends AnimatedEntity {
  Enemy(String aniPath, double _yOffset, Function onComplete, Function onHit,
      Function onDie)
      : super(
          aniPath,
          9,
          0.1,
          9,
          0.1,
          _yOffset,
          onComplete,
          onHit,
          onDie,
        );

  @override
  void die() {
    // TODO: implement die
  }

  @override
  void completed() {
    // TODO: implement completed
  }
}
