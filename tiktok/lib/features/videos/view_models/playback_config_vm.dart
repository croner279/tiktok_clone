import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/videos/models/playback_config_model.dart';
import 'package:tiktok/features/videos/repos/video_playback_config_repo.dart';

class PlaybackConfigModelViewModel extends Notifier<PlaybackConfigModel> {
  //Notifier에게 이 데이터를 expose하게 될 거라고 알려줌.
  final PlaybackConfigRepository _repository;

  PlaybackConfigModelViewModel(this._repository);

//view 가 viewModel에게 새로운 요청을 한다(새로운 value로 setMuted 메소드 호출함으로써).
  void setMuted(bool value) {
    _repository.setMuted(value);
    state = PlaybackConfigModel(
      muted: value,
      autoplay: state.autoplay,
    );
  }

  void setAutoplay(bool value) {
    _repository.setAutoplay(value);
    state = PlaybackConfigModel(
      muted: state.muted,
      autoplay: value,
    ); // model을 수정한다
  }

  @override
  PlaybackConfigModel build() {
    return PlaybackConfigModel(
      muted: _repository.isMuted(),
      autoplay: _repository.isAutoplay(),
    );
  }
}

final playbackConfigProvider =
    NotifierProvider<PlaybackConfigModelViewModel, PlaybackConfigModel>(
  () => throw UnimplementedError(),
);
