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
      // state를 바꾸지 않아(mutate하지 않음) 새 state로 기존의 state를 대체하는 것임. 이때 화면들이 새로고침 됨.
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
  // build 메서드는 화면이 보기를 원하는 데이터의 초기 상태를 반환함.
  // PlaybackConfgiViewModel이 build 되면(처음으로 초기화 되면) 아래의 상태를 갖게 되는 것임.

  PlaybackConfigModel build() {
    return PlaybackConfigModel(
      muted: _repository.isMuted(),
      autoplay: _repository.isAutoplay(),
    );
  }
}

final playbackConfigProvider =
// 왼쪽은 우리가 expose하고 싶은 type, 오른쪽은 provider가 expose할 데이터(모델)
// 왼쪽에서 ConfigViewModel의 데이터 변화를 통지, 그래서 노출될 데이터는 오른쪽의 PlaybackConfigModel
    NotifierProvider<PlaybackConfigModelViewModel, PlaybackConfigModel>(
  () => throw UnimplementedError(),
  //이렇게 코드 쓰면 안되는데, 이 파일 내에서는 ConfigViewModel을 초기화 할 수 없어서 어쩔 수 없음. SharedPreference에 일단 접근하려고 이번만 이렇게 함.
);
