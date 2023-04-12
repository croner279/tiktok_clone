// 오직 한 가지 일만 하는 파일. 바로 데이터를 디스크에 persist(데이터를 프로그램보다 오래 살리는 것)하고
// 데이터를 읽는 것. (Data Persistence(데이터 유지), Data read)

import 'package:shared_preferences/shared_preferences.dart';

class PlaybackConfigRepository {
  static const String _autoplay = "autoplay";
  static const String _muted = "muted";

  final SharedPreferences _preferences;

  PlaybackConfigRepository(this._preferences);

  Future<void> setMuted(bool value) async {
    _preferences.setBool(_muted, value);
  }

  Future<void> setAutoplay(bool value) async {
    _preferences.setBool(_autoplay, value);
  }
  //여기까지가 데이터를 저장하는 함수

  bool isMuted() {
    // 디스크에 저장이 안되어 있으면 null일 수 있으니, 디스크에 없으면 false로 간주해야 함
    return _preferences.getBool(_muted) ?? false;
  }

  bool isAutoplay() {
    // 디스크에 저장이 안되어 있으면 null일 수 있으니, 디스크에 없으면 false로 간주해야 함
    return _preferences.getBool(_autoplay) ?? false;
  }
}
