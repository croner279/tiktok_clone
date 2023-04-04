import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/features/videos/widgets/video_button.dart';
import 'package:tiktok/features/videos/widgets/video_comments.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../constants/sizes.dart';

class VideoPost extends StatefulWidget {
  final Function onVideoFinished;

  final int index;

  const VideoPost({
    super.key,
    required this.onVideoFinished,
    required this.index,
  });

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost>
    with SingleTickerProviderStateMixin {
  //with는 그 클래스의 메서드와 속성 전부 가져오는 것(클래스 복사하기)
  late final VideoPlayerController _videoPlayerController;
  // =    VideoPlayerController.asset("assets/videos/video.mp4");
  final Duration _animationDuration = const Duration(milliseconds: 200);

  late final AnimationController _animationController;

  bool _isPaused = false;

  void _onVideoChange() {
    if (_videoPlayerController.value.isInitialized) {
      if (_videoPlayerController.value.duration ==
          _videoPlayerController.value.position) {
        widget.onVideoFinished();
      }
    }
  }

  void _initVideoPlayer() async {
    _videoPlayerController =
        VideoPlayerController.asset("assets/videos/video.mp4");
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true); // 영상 끝나면 반복시켜버림
    _videoPlayerController.addListener(_onVideoChange);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();

    _animationController = AnimationController(
      vsync:
          this, //vsync "prevents offscreen animation from consuming unnecessary resources"
      //this는 이 클래스 자체. 위의 Mixin에는 ticker가 있는데 이 ticekr는 controller function을 애니메이션 프레임마다 실행함(vsync에 의해).
      // resource를 많이 잡아먹긴 하지만 Single..Mixin은 화면이 enable 될때만 동영상 작동시키므로 괜찮음.
      lowerBound: 1.0,
      upperBound: 1.5,
      value: 1.5,
      duration: _animationDuration,
    );
    _animationController.addListener(() {
      //addListener를 해줘야 계속 build메소드 호출. 이거 없으면 1.0에서 1.5로 중간부분 없이 바로 점프해버림
      setState(
          () {}); //AnimationController에서 숫자가 바뀔때 마다 setState 해줌. setState는 build메소드를 호출하고, 메소드는 가장 최신 값으로 rebuild 해줌
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction == 1 &&
        !_videoPlayerController.value.isPlaying &&
        !_isPaused) {
      // 영상이 100% visible(화면이 100% 틀어져 있을 때) + video가 재생이 안되고 있다면 video를 플레이.
      // 새로고침하고 놔두면 다시 재생이 됨...
      _videoPlayerController.play();
    }
    if (_videoPlayerController.value.isPlaying && info.visibleFraction == 0) {
      _onTogglePause(); // 동영상이 재생되고 있는 상태 + 화면에서 보이지 않게 되면 Pause를 한다.
    }
  }

  void _onTogglePause() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      _animationController.reverse();
    } else {
      _videoPlayerController.play();
      _animationController.forward();
    }
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  void _onCommentsTap(BuildContext context) async {
    if (_videoPlayerController.value.isPlaying) {
      _onTogglePause();
    }
    await showModalBottomSheet(
      isScrollControlled:
          true, //설명에 나와있음. 니가 bottomSheet로 Listview 를 쓸거면 이거 true로 해놔라
      backgroundColor: Colors
          .transparent, // 이걸 해놔야 이제 Scaffold의 색을 보는 것임. 이제 Scaffold에 borderRadius 적용 가능
      context: context,
      builder: (context) => const VideoComments(),
    );
    _onTogglePause();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key("${widget.index}"),
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
        children: [
          Positioned.fill(
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
                : Container(
                    color: Colors.black,
                  ),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: _onTogglePause,
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              //아이콘에 보내는 클릭은 무시. 위의 GestureDetector만 받도록 함
              child: Center(
                child: AnimatedBuilder(
                  animation:
                      _animationController, //_animationController의 값이 변할때마다 실행됨
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animationController.value,
                      child: child,
                    );
                  }, //animate 할 것과 리스너를 분리해놔서 더 편함.
                  child: AnimatedOpacity(
                    duration: _animationDuration,
                    opacity: _isPaused ? 1 : 0,
                    child: const FaIcon(
                      FontAwesomeIcons.play,
                      color: Colors.white,
                      size: Sizes.size52,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Positioned(
            bottom: 30,
            left: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "@울쨩",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Sizes.size16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v10,
                Text("울쨩몬!! 꽃 향기가 나는 사람이 되자~",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Sizes.size12,
                      fontWeight: FontWeight.w500,
                    ))
              ],
            ),
          ),
          Positioned(
              bottom: 20,
              right: 10,
              child: Column(
                children: [
                  Gaps.v24,
                  const VideoButtion(
                    icon: FontAwesomeIcons.solidHeart,
                    text: "2.9M",
                  ),
                  Gaps.v24,
                  GestureDetector(
                    onTap: () => _onCommentsTap(
                        context), //context를 안넣으면 아이콘을 Tap해도 아무런 반응이 없다. 그 이유는? 왜 context가 꼭 필요함?
                    child: const VideoButtion(
                      icon: FontAwesomeIcons.solidComment,
                      text: "3.3k",
                    ),
                  ),
                  Gaps.v24,
                  const VideoButtion(
                    icon: FontAwesomeIcons.share,
                    text: "Share",
                  ),
                  Gaps.v36,
                  const CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    //foregroundImage: NetworkImage(url), 사진 url 넣으면 됨
                    child: Text('울쨩'),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
