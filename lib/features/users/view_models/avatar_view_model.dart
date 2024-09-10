import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/providers/auth_provider.dart';
import 'package:tiktok_clone/features/users/providers/users_provider.dart';
import 'package:tiktok_clone/features/users/repositories/user_repository.dart';

class AvatarViewModel extends AsyncNotifier {
  late final UserRepository _repository;

  @override
  FutureOr build() {
    Future.delayed(
      const Duration(
        seconds: 5,
      ),
    );
    _repository = ref.read(userRepositoryProvider);
  }

  Future<void> uploadAvatar(File file) async {
    state = const AsyncValue.loading();
    final filename = ref.read(authRepositoryProvider).user!.uid;
    state = await AsyncValue.guard(
      () async {
        await _repository.uploadAvatar(file, filename);
        await ref.read(usersProvider.notifier).onAvatarUpload();
      },
    );
  }

  Future<void> getAvatarFullPath(String uid) async {
    _repository.getAvatarFullPath(uid);
  }
}
