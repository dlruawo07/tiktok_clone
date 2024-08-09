import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/widgets/video_button.dart';
import 'package:tiktok_clone/features/videos/widgets/video_comments.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends StatefulWidget {
  const VideoPost({
    super.key,
    required this.onVideoFinished,
    required this.index,
  });

  final Function onVideoFinished;
  final int index;

  @override
  State<VideoPost> createState() => _VideoPostState();
}

// NOTE: with - class 복사
class _VideoPostState extends State<VideoPost>
    with SingleTickerProviderStateMixin {
  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset("assets/videos/video.mp4");
  final Duration _animationDuration = const Duration(
    milliseconds: 200,
  );
  late final AnimationController _animationController;
  bool _isPaused = false;
  bool _isExpanded = false;

  final List<String> tags = [
    'Tag1',
    'Tag2',
    'Tag3',
    'Tag4',
    'Tag5',
    'Tag6',
    'Tag7',
    'Tag8',
    'Tag9',
    'Tag10',
  ];

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
    _animationController = AnimationController(
      // NOTE: vsync - prevents offscreen animations from consuming unnecessary resources
      // NOTE: stop animation when widget is unseen
      // NOTE: SingleTickerProviderStateMixin required.
      vsync: this,
      lowerBound: 1.0,
      upperBound: 1.5,
      value: 1.5,
      duration: _animationDuration,
    );
    // NOTE: play/pause 시 lowerBound <-> upperBound 값의 변경이 일어나는데
    // build는 1.0과 1.5 사이의 값들은 알지 못한다.
    // 따라서 setState()로 build를 계속해서 재호출 해야 한다.
    // // NOTE: _animatedController.value의 변화를 감지하는 방법 1
    // _animationController.addListener(() {
    //   setState(() {});
    // });
  }

  void _onVideoChange() {
    // NOTE: 영상이 초기화되었으면서
    if (_videoPlayerController.value.isInitialized) {
      // NOTE: 현재 시점이 전체 길이와 같다면 (종료)
      if (_videoPlayerController.value.position ==
          _videoPlayerController.value.duration) {
        // NOTE: 영상 종료 시 호출되는 함수 호출
        widget.onVideoFinished();
      }
    }
  }

  void _initVideoPlayer() async {
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    setState(() {});
    // NOTE: 영상 컨트롤러는 영상의 종료를 항상 기다림
    _videoPlayerController.addListener(_onVideoChange);
  }

// NOTE: 화면을 위로 스와이프 했을 때 영상이 100% 보여야 재생되게 하기 위함
// NOTE: 영상이 재생 중이나 영상 화면이 사라졌을 때 일시정지
  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction == 1 &&
        !_isPaused &&
        !_videoPlayerController.value.isPlaying) {
      _videoPlayerController.play();
    } else if (_videoPlayerController.value.isPlaying &&
        info.visibleFraction == 0) {
      onTogglePause();
    }
  }

  // NOTE: 화면 클릭 시 재생/일시정지
  void onTogglePause() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      // NOTE: reverse - lowerBound, upperBound를 반전시킨다
      // NOTE: reverse와 forward 시 value가 조금씩 바뀐다
      _animationController.reverse();
    } else {
      _videoPlayerController.play();
      // NOTE: forward - lowerBound, upperBound를 복구시킨다
      _animationController.forward();
    }
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  void onSeeMoreTap() {
    setState(() {
      _isExpanded = true;
    });
  }

  void onCommentsTap(BuildContext context) async {
    if (_videoPlayerController.value.isPlaying) {
      onTogglePause();
    }
    await showModalBottomSheet(
      // NOTE: BottomSheet의 사이즈 수정 가능하게 하는 옵션. ListView 사용 시 true.
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => const VideoComments(),
    );
    onTogglePause();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _animationController.dispose();
    super.dispose();
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
              onTap: onTogglePause,
            ),
          ),
          Positioned.fill(
            // NOTE: Event가 Icon으로 가는 것을 무시함
            child: IgnorePointer(
              // NOTE: 사이즈 변화
              // NOTE: _animationController의 변화를 감지하는 방법 2
              child: AnimatedBuilder(
                animation: _animationController,
                // NOTE: animation의 변화를 감지하고 무언가를 수행하는 함수
                builder: (context, child) {
                  return Transform.scale(
                    scale: _animationController.value,
                    // NOTE: child = 아래의 AnimatedOpacity 위젯
                    child: AnimatedOpacity(
                      opacity: _isPaused ? 1 : 0,
                      duration: _animationDuration,
                      child: const Center(
                        child: FaIcon(
                          FontAwesomeIcons.play,
                          color: Colors.white,
                          size: Sizes.size52,
                        ),
                      ),
                    ),
                  );
                },
                // // NOTE: _animatedController.value의 변화를 감지하는 방법 1
                // child: Transform.scale(
                //   // NOTE: 위의 _animationController.addLister에서
                //   // value가 바뀔 때마다 build 되기 때문에 부드러운 렌더링 가능
                //   scale: _animationController.value,
                //   child: AnimatedOpacity(
                //     opacity: _isPaused ? 1 : 0,
                //     duration: _animationDuration,
                //     child: const Center(
                //       child: FaIcon(
                //         FontAwesomeIcons.play,
                //         color: Colors.white,
                //         size: Sizes.size52,
                //       ),
                //     ),
                //   ),
                // ),
              ),
            ),
          ),
          const Positioned(
            bottom: 20,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "@니꼬",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Sizes.size16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v6,
                Text(
                  "This is the baby",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Sizes.size12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // TODO: hashtags (... See more)
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 10,
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  foregroundImage: NetworkImage(
                    "https://avatars.githubusercontent.com/u/59638614?v=4",
                  ),
                  child: Text("니꼬"),
                ),
                Gaps.v44,
                const VideoButton(
                  icon: FontAwesomeIcons.solidHeart,
                  text: "2.9M",
                ),
                Gaps.v44,
                GestureDetector(
                  onTap: () => onCommentsTap(context),
                  child: const VideoButton(
                    icon: FontAwesomeIcons.solidComment,
                    text: "33K",
                  ),
                ),
                Gaps.v44,
                const VideoButton(
                  icon: FontAwesomeIcons.share,
                  text: "Share",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
