import 'package:xmas_sprint/entities/AnimatedEntity.dart';

class Santa extends AnimatedEntity {
  Santa(
    String aniPath,
    double yOffset,
    Function onComplete,
    Function onDie,
  ) : super(
          aniPath,
          15,
          0.05,
          15,
          0.05,
          yOffset,
          onComplete,
          onDie,
        );

  @override
  void completed() {
    // TODO: implement completed
  }

  @override
  void die() {
    // TODO: implement die
  }
}
