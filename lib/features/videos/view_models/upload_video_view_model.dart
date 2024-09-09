import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/authentication/repositories/authentication_repository.dart';
import 'package:tiktok_clone/features/users/view_models/users_view_model.dart';
import 'package:tiktok_clone/features/videos/models/video_model.dart';
import 'package:tiktok_clone/features/videos/repositories/videos_repository.dart';

class UploadVideoViewModel extends AsyncNotifier<void> {
  late final VideosRepository _repository;

  @override
  FutureOr build() {
    _repository = ref.read(videosProvider);
  }

  Future<void> uploadVideo(BuildContext context, File video) async {
    final user = ref.read(authRepositoryProvider).user;
    final userProfile = ref.read(usersProvider).value;
    if (userProfile != null) {
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(
        () async {
          final task = await _repository.uploadVideoFile(
            video,
            user!.uid,
          );
          if (task.metadata != null) {
            await _repository.saveVideo(
              VideoModel(
                id: "",
                title: "From Flutter!",
                description: "Hell yeah!",
                fileURL: await task.ref.getDownloadURL(),
                thumbnailURL: "",
                creatorUid: user.uid,
                creator: userProfile.username,
                likes: 0,
                comments: 0,
                createdAt: DateTime.now().millisecondsSinceEpoch,
              ),
            );
          }
        },
      );
      context.pop();
      context.pop();
    }
  }
}

final uploadVideoProvider = AsyncNotifierProvider<UploadVideoViewModel, void>(
  () => UploadVideoViewModel(),
);
