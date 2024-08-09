import 'package:flutter/material.dart';
import 'package:tiktok_clone/features/videos/widgets/video_post.dart';

class VideoTimelineScreen extends StatefulWidget {
  const VideoTimelineScreen({
    super.key,
  });

  @override
  State<VideoTimelineScreen> createState() => _VideoTimelineScreenState();
}

class _VideoTimelineScreenState extends State<VideoTimelineScreen> {
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
    _pageController.nextPage(
      duration: _scrollDuration,
      curve: _scrollCurve,
    );
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
    return RefreshIndicator(
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
        itemBuilder: (context, index) => VideoPost(
          onVideoFinished: _onVideoFinished,
          index: index,
        ),
        itemCount: _itemCount,
      ),
    );
  }
}
