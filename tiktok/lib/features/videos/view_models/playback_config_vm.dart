import 'package:flutter/cupertino.dart';
import 'package:tiktok/features/videos/models/playback_config_model.dart';
import 'package:tiktok/features/videos/repos/video_playback_config_repo.dart';

class PlaybackConfigModelViewModel extends ChangeNotifier {
  final PlaybackConfigRepository _repository;

  late final PlaybackConfigModel _model = PlaybackConfigModel(
    muted: _repository.isMuted(),
    autoplay: _repository.isAutoplay(),
  );

  PlaybackConfigModelViewModel(this._repository);

  bool get muted => _model.muted;
  bool get autoplay => _model.autoplay;

//view 가 viewModel에게 새로운 요청을 한다(새로운 value로 setMuted 메소드 호출함으로써).
  void setMuted(bool value) {
    _repository.setMuted(value);
    //ViewModel은 repository에게 value를 디스크에 persist하라고 요청
    _model.muted = value;
    // model을 수정한다
    notifyListeners(); // listen 하고 있는 모두에게 notify
  }

  void setAutoplay(bool value) {
    _repository.setAutoplay(value);
    //ViewModel은 repository에게 value를 디스크에 persist하라고 요청
    _model.autoplay = value; // model을 수정한다
    notifyListeners(); // listen 하고 있는 모두에게 notify
  }
}
