import 'package:shared_preferences/shared_preferences.dart';

UserData userData = UserData();

class UserData {
  int _curScore = 0;
  int _bestScore = 0;
  bool _playMusic = false;

  int getCurrentScore() => _curScore;
  int getBestScore() => _bestScore;
  bool shallPlayMusic() => _playMusic;

  void setScore(int curScore) {
    _curScore = curScore;
    if (_curScore > _bestScore) {
      _bestScore = curScore;
      saveData();
    }
  }

  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    _bestScore = (prefs.getInt('__xmas_sprint_best_score_') ?? 0);
    _playMusic = (prefs.getBool('__xmas_sprint_best_play_music_') ?? true);
  }

  void saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setInt('__xmas_sprint_best_score_', _bestScore);
    await prefs.setBool('__xmas_sprint_best_play_music_', _playMusic);
  }

  void toggleMusic() {
    _playMusic = !_playMusic;
    saveData();
  }
}
