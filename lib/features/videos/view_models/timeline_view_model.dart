import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/models/video_model.dart';

class TimelineViewModel extends AsyncNotifier<List<VideoModel>> {
  List<VideoModel> _list = [
    VideoModel(
      title: "First video",
    )
  ];

  void uploadVideo() async {
    state = const AsyncValue.loading();
    await Future.delayed(
      const Duration(
        seconds: 2,
      ),
    );
    final newVideo = VideoModel(title: "${DateTime.now()}");
    _list = [..._list, newVideo];
    state = AsyncValue.data(_list);
  }

  // FutureOr: Future or list of videos
  @override
  FutureOr<List<VideoModel>> build() async {
    await Future.delayed(
      const Duration(
        seconds: 5,
      ),
    );
    // initial data that screen is going to receive
    return _list;
  }
}

// Creating a new TimelineViewModel with a list of videos
final timelineProvider =
    AsyncNotifierProvider<TimelineViewModel, List<VideoModel>>(
  () => TimelineViewModel(),
);
