import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/providers/auth_provider.dart';
import 'package:tiktok_clone/features/videos/repositories/videos_repository.dart';

// FamilyAsyncNotifier allows to send parameters to build method
class VideoPostViewModel extends FamilyAsyncNotifier<void, String> {
  late final VideosRepository _repository;
  late final _videoId;

  Future<void> likeVideo() async {
    final user = ref.read(authenticationRepositoryProvider).user;
    await _repository.likeVideo(_videoId, user!.uid);
  }

  Future<bool> isLikedVideo() async {
    final user = ref.read(authenticationRepositoryProvider).user;
    return _repository.isLikedVideo(_videoId, user!.uid);
  }

  @override
  FutureOr build(String arg) {
    _videoId = arg;
    _repository = ref.read(videosProvider);
  }
}

final videoPostProvider =
    AsyncNotifierProvider.family<VideoPostViewModel, void, String>(
  () => VideoPostViewModel(),
);
