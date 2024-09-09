import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/models/video_model.dart';
import 'package:tiktok_clone/features/videos/view_models/playback_config_view_model.dart';
import 'package:tiktok_clone/features/videos/view_models/video_post_view_model.dart';
import 'package:tiktok_clone/features/videos/views/widgets/video_button.dart';
import 'package:tiktok_clone/features/videos/views/widgets/video_comments.dart';
import 'package:tiktok_clone/generated/l10n.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends ConsumerStatefulWidget {
  final Function onVideoFinished;
  final VideoModel videoData;
  final int index;

  const VideoPost({
    super.key,
    required this.onVideoFinished,
    required this.videoData,
    required this.index,
  });

  @override
  VideoPostState createState() => VideoPostState();
}

// with - class 복사
// ticker - 애니메이션 프레임마다 호출되는 시계
//       SingleTickerProviderStateMixin - 위젯이 위젯트리에 없을 때 자원을 낭비하지 않도록 함 (위젯이 활성화되어있을 때만 티커 동작)
class VideoPostState extends ConsumerState<VideoPost>
    with SingleTickerProviderStateMixin {
  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset("assets/videos/video.mp4");
  final Duration _animationDuration = const Duration(
    milliseconds: 200,
  );

  late final AnimationController _animationController;

  bool _isPaused = false;
  // ignore: unused_field
  bool _isExpanded = false;
  bool _isLiked = false;
  late int likeCount = 0;

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
    _animationController = AnimationController(
      // vsync - prevents offscreen animations from consuming unnecessary resources
      // stop animation when widget is unseen
      // SingleTickerProviderStateMixin required.
      vsync: this,
      lowerBound: 1.0,
      upperBound: 1.5,
      value: 1.5,
      duration: _animationDuration,
    );

// TODO: CODE_CHALLENGE: volume icon must unmute only the current video

    // // ChangeNotifier를 듣는 또다른 방법
    // videoConfig.addListener(() {
    //   setState(() {
    //     _autoMute = videoConfig.value;
    //   });
    // });

    // play/pause 시 lowerBound <-> upperBound 값의 변경이 일어나는데
    // build는 1.0과 1.5 사이의 값들은 알지 못한다.
    // 따라서 setState()로 build를 계속해서 재호출 해야 한다.
    // // _animatedController.value의 변화를 감지하는 방법 1
    // _animationController.addListener(() {
    //   setState(() {});
    // });
  }

  void _onToggleHeart() async {
    ref.read(videoPostProvider(widget.videoData.id).notifier).likeVideo();
    if (!_isLiked) {
      likeCount += 1;
    } else {
      likeCount -= 1;
    }
    setState(() {
      _isLiked = !_isLiked;
    });
  }

  void _onPlaybackConfigChanged() {
    if (!mounted) {
      return;
    }

    if (ref.read(playbackConfigProvider).muted) {
      ref.read(playbackConfigProvider.notifier).setMuted(false);
      _videoPlayerController.setVolume(1);
    } else {
      ref.read(playbackConfigProvider.notifier).setMuted(true);
      _videoPlayerController.setVolume(0);
    }
  }

  void _onVideoChange() async {
    // 영상이 초기화되었으면서
    if (_videoPlayerController.value.isInitialized) {
      // 현재 시점이 전체 길이와 같다면 (종료)
      if (_videoPlayerController.value.position ==
          _videoPlayerController.value.duration) {
        // 영상 종료 시 호출되는 함수 호출
        widget.onVideoFinished();
      }
    }
  }

  Future<void> _initVideoPlayer() async {
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    likeCount = widget.videoData.likes;
    _isLiked = await ref
        .read(videoPostProvider(widget.videoData.id).notifier)
        .isLikedVideo();
    // 영상 컨트롤러는 영상의 종료를 항상 기다림
    _videoPlayerController.addListener(_onVideoChange);
    setState(() {});
  }

// 화면을 위로 스와이프 했을 때 영상이 100% 보여야 재생되게 하기 위함
// 영상이 재생 중이나 영상 화면이 사라졌을 때 일시정지
  void _onVisibilityChanged(VisibilityInfo info) async {
    // 모든 StatefulWidget은 mounted 옵션이 있음
    // 위젯이 mount 되었는 지(위젯 트리에 있는 지) 확인
    if (!mounted) {
      return;
    }
    // if (Provider.of<VideoConfig>(context, listen: false).isMuted) {
    //   await _videoPlayerController.setVolume(0);
    // } else {
    //   await _videoPlayerController.setVolume(100);
    // }
    if (info.visibleFraction == 1 &&
        !_isPaused &&
        !_videoPlayerController.value.isPlaying) {
      if (ref.read(playbackConfigProvider).muted) {
        _videoPlayerController.setVolume(0);
      }
      if (ref.read(playbackConfigProvider).autoplay) {
        _videoPlayerController.play();
      }
    } else if (_videoPlayerController.value.isPlaying &&
        info.visibleFraction == 0) {
      _onTogglePause();
    }
  }

  // 화면 클릭 시 재생/일시정지
  void _onTogglePause() async {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      // reverse - lowerBound, upperBound를 반전시킨다
      // reverse와 forward 시 value가 조금씩 바뀐다
      _animationController.reverse();
    } else {
      _videoPlayerController.play();
      // forward - lowerBound, upperBound를 복구시킨다
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

  void _onCommentsTap(BuildContext context) async {
    if (_videoPlayerController.value.isPlaying) {
      _onTogglePause();
    }
    await showModalBottomSheet(
      // BottomSheet의 사이즈 수정 가능하게 하는 옵션. ListView 사용 시 true.
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => const VideoComments(),
    );
    _onTogglePause();
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
                : Image.network(
                    widget.videoData.thumbnailURL,
                    fit: BoxFit.cover,
                  ),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: _onTogglePause,
            ),
          ),
          Positioned.fill(
            // Event가 Icon으로 가는 것을 무시함
            child: IgnorePointer(
              // 사이즈 변화
              // _animationController의 변화를 감지하는 방법 2
              child: AnimatedBuilder(
                animation: _animationController,
                // animation의 변화를 감지하고 무언가를 수행하는 함수
                builder: (context, child) {
                  return Transform.scale(
                    scale: _animationController.value,
                    // child = 아래의 AnimatedOpacity 위젯
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
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "@${widget.videoData.creator}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: Sizes.size16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v6,
                Text(
                  widget.videoData.description,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: Sizes.size12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 10,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  foregroundImage: NetworkImage(
                    "https://firebasestorage.googleapis.com/v0/b/tik-tok-52296.appspot.com/o/avatars%2F${widget.videoData.creatorUid}?alt=media&token=b79558d3-bf90-4773-a0ff-247ef62e2b31&nocaching=${DateTime.now().toString()}",
                  ),
                  child: Text(
                    widget.videoData.creator,
                    style: const TextStyle(
                      fontSize: Sizes.size8,
                    ),
                  ),
                ),
                Gaps.v44,
                GestureDetector(
                  onTap: _onToggleHeart,
                  child: VideoButton(
                    icon: FontAwesomeIcons.solidHeart,
                    color: _isLiked ? Colors.red : null,
                    text: S.of(context).likeCount(likeCount),
                  ),
                ),
                Gaps.v44,
                GestureDetector(
                  onTap: () => _onCommentsTap(context),
                  child: VideoButton(
                    icon: FontAwesomeIcons.solidComment,
                    text: S.of(context).commentCount(widget.videoData.comments),
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
          Positioned(
            right: 10,
            child: SafeArea(
              child: IconButton(
                icon: FaIcon(
                  ref.watch(playbackConfigProvider).muted
                      ? FontAwesomeIcons.volumeXmark
                      : FontAwesomeIcons.volumeHigh,
                  color: Colors.white,
                ),
                onPressed: _onPlaybackConfigChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
