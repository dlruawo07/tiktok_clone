import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/authentication/providers/auth_provider.dart';
import 'package:tiktok_clone/features/authentication/providers/signup_provider.dart';
import 'package:tiktok_clone/features/authentication/repositories/authentication_repository.dart';
import 'package:tiktok_clone/features/users/providers/users_provider.dart';
import 'package:tiktok_clone/configures/router.dart';
import 'package:tiktok_clone/utils/error_snackbar.dart';

class SignupViewModel extends AsyncNotifier<void> {
  late final AuthRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(authRepositoryProvider);
  }

  Future<void> signup(BuildContext context) async {
    state = const AsyncValue.loading();
    final form = ref.read(signupFormProvider);
    final users = ref.read(usersProvider.notifier);
    state = await AsyncValue.guard(
      () async {
        final userCredential = await _repository.emailSignup(
          form["email"],
          form["password"],
        );
        await users.createProfile(
          userCredential,
          username: form["username"],
          birthday: form["birthday"],
        );
      },
    );

    if (!context.mounted) return;

    if (state.hasError) {
      showFirebaseErrorSnack(context, state.error);
    } else {
      context.goNamed(CustomRouter.interestsName);
    }
  }

  Future<void> signOut() async {
    state = await AsyncValue.guard(
      () async => await _repository.signOut(),
    );
  }
}
