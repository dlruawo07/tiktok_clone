import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/providers/auth_provider.dart';
import 'package:tiktok_clone/features/authentication/repositories/authentication_repository.dart';
import 'package:tiktok_clone/features/users/models/user_profile_model.dart';
import 'package:tiktok_clone/features/users/repositories/user_repository.dart';

class UsersViewModel extends AsyncNotifier<UserProfileModel> {
  late final UserRepository _usersRepository;
  late final AuthenticationRepository _authRepository;

  @override
  FutureOr<UserProfileModel> build() async {
    _usersRepository = ref.read(userRepositoryProvider);
    _authRepository = ref.read(authenticationRepositoryProvider);
    // fetch user profile
    if (_authRepository.isLoggedIn) {
      final profile = await _usersRepository.findProfile(
        _authRepository.user!.uid,
      );
      if (profile != null) {
        return UserProfileModel.fromJson(profile);
      }
    }

    return UserProfileModel.empty();
  }

  Future<void> createProfile(
    UserCredential credential, {
    required String username,
    required String birthday,
  }) async {
    state = const AsyncValue.loading();

    if (credential.user == null) {
      throw Exception("Account not created");
    }

    final profile = UserProfileModel(
      uid: credential.user!.uid,
      email: credential.user!.email ?? "anonymous@example.com",
      name: credential.user!.displayName ?? "Anonymous",
      bio: "undefined",
      link: "undefined",
      username: username,
      birthday: birthday,
      hasAvatar: false,
    );

    await _usersRepository.createProfile(profile);

    state = AsyncValue.data(profile);
  }

  Future<void> onAvatarUpload() async {
    if (state.value == null) {
      return;
    }

    state = AsyncValue.data(
      state.value!.copyWith(hasAvatar: true),
    );

    await _usersRepository.updateProfile(
      state.value!.uid,
      {
        "hasAvatar": true,
      },
    );
  }

  Future<void> updateBio(String bio) async {
    if (state.value == null || bio == "") {
      return;
    }

    state = AsyncValue.data(
      state.value!.copyWith(
        bio: bio,
      ),
    );

    await _usersRepository.updateProfile(
      state.value!.uid,
      {
        "bio": bio,
      },
    );
  }

  Future<void> updateLink(String link) async {
    if (state.value == null || link == "") {
      return;
    }

    state = AsyncValue.data(
      state.value!.copyWith(
        link: link,
      ),
    );

    await _usersRepository.updateProfile(
      state.value!.uid,
      {
        "link": link,
      },
    );
  }
}

final usersProvider = AsyncNotifierProvider<UsersViewModel, UserProfileModel>(
  () => UsersViewModel(),
);
