import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/configures/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/providers/video_timeline_provider.dart';
import 'package:tiktok_clone/features/videos/views/widgets/video_post.dart';

class VideoTimelineScreen extends ConsumerStatefulWidget {
  const VideoTimelineScreen({
    super.key,
  });

  @override
  VideoTimelineScreenState createState() => VideoTimelineScreenState();
}

class VideoTimelineScreenState extends ConsumerState<VideoTimelineScreen> {
  final PageController _pageController = PageController();
  final Duration _scrollDuration = const Duration(
    milliseconds: 250,
  );
  final Curve _scrollCurve = Curves.linear;

  int _itemCount = 0;

  void _onPageChanged(int page) {
    setState(
      () {
        _pageController.animateToPage(
          page,
          duration: _scrollDuration,
          curve: _scrollCurve,
        );
        if (page == _itemCount - 1) {
          ref.watch(timelineProvider.notifier).fetchNextPage();
        }
      },
    );
  }

  void _onVideoFinished() {
    return;
  }

  Future<void> _onRefresh() {
    return ref.watch(timelineProvider.notifier).refresh();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // async notifier provider 이기 때문에 when으로 분기처리
    return ref.watch(timelineProvider).when(
          loading: () => const Center(
            child: CupertinoActivityIndicator(
              radius: Sizes.size20,
            ),
          ),
          error: (error, stackTrace) => Center(
            child: Text(
              "Could not load videos $error",
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          data: (videos) {
            _itemCount = videos.length;

            return RefreshIndicator(
              // onRefresh는 반드시 Future를 반환해야함
              onRefresh: _onRefresh,
              // RefreshIndicator가 위치하는 지점
              displacement: 50,
              // RefreshIndicator가 시작하는 지점
              edgeOffset: 20,
              color: Theme.of(context).primaryColor,
              // builder: build는 하지만 모두를 동시에 render하지는 않음
              child: PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.vertical,
                onPageChanged: _onPageChanged,
                itemCount: videos.length,
                itemBuilder: (context, index) {
                  final videoData = videos[index];
                  return VideoPost(
                    onVideoFinished: _onVideoFinished,
                    index: index,
                    videoData: videoData,
                  );
                },
              ),
            );
          },
        );
  }
}
