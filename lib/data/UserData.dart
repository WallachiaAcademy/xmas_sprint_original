UserData userData = UserData();

class UserData {
  int _curScore = 0;
  int _bestScore = 0;

  int getCurrentScore() => _curScore;
  int getBestScore() => _bestScore;

  void setScore(int curScore) {
    _curScore = curScore;
    if (_curScore > _bestScore) {
      _bestScore = curScore;
    }
  }
}
