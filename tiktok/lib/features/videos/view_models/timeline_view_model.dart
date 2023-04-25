import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/videos/models/video_model.dart';

class TimelineViewModel extends AsyncNotifier<List<VideoModel>> {
  List<VideoModel> _list = [];

  void uploadVideo() async {
    //timeline View Model이 다시 loading state가 되도록 만들어 줌.
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(seconds: 2));
    final newVideo = VideoModel(title: "${DateTime.now()}");
    _list = [..._list, newVideo];
    // AsyncNotifier 안에는 loading, error, data 같은 async값이 있어서  state가 새로운 데이터를 갖게 하려면 AsyncValue를 써야 함. state=_list 처럼 될 수 없음
    state = AsyncValue.data(_list);
  }

  @override
  FutureOr<List<VideoModel>> build() async {
    // build 메소드에서는 원하는 API를 호출하고  그 다음 데이터 반환 시, 데이터는 우리의 Provider에 의해 expose될 것.
    await Future.delayed(const Duration(seconds: 5));
    return _list;
  }
}

final timelineProvider =
    // expose할 View Model은 무엇인지, 그 View Model의 데이터가 뭔지 알려줌
    AsyncNotifierProvider<TimelineViewModel, List<VideoModel>>(
  // 그리고 화살표 함수로 class를 초기화 해줌
  () => TimelineViewModel(),
);
