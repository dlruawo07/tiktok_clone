import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/view_models/timeline_view_model.dart';
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

  int _itemCount = 4;

  void _onPageChanged(int page) {
    setState(() {
      _pageController.animateToPage(
        page,
        duration: _scrollDuration,
        curve: _scrollCurve,
      );
    });
    if (page == _itemCount - 1) {
      _itemCount = _itemCount + 4;
    }
  }

  void _onVideoFinished() {
    return;
  }

  Future<void> _onRefreshed() {
    return Future.delayed(
      const Duration(
        seconds: 5,
      ),
    );
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
            child: CircularProgressIndicator(),
          ),
          error: (error, stackTrace) => Center(
            child: Text(
              "Could not load videos $error",
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          data: (videos) => RefreshIndicator(
            // NOTE: onRefresh는 반드시 Future를 반환해야함
            onRefresh: _onRefreshed,
            // NOTE: RefreshIndicator가 위치하는 지점
            displacement: 50,
            // NOTE: RefreshIndicator가 시작하는 지점
            edgeOffset: 20,
            color: Theme.of(context).primaryColor,
            // NOTE: builder: build는 하지만 모두를 동시에 render하지는 않음
            child: PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              onPageChanged: _onPageChanged,
              itemCount: videos.length,
              itemBuilder: (context, index) => VideoPost(
                onVideoFinished: _onVideoFinished,
                index: index,
              ),
            ),
          ),
        );
  }
}
