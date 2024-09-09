import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/configures/router.dart';
import 'package:tiktok_clone/features/authentication/providers/auth_provider.dart';
import 'package:tiktok_clone/features/authentication/repositories/authentication_repository.dart';
import 'package:tiktok_clone/utils/error_snackbar.dart';

class LoginViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepository;

  @override
  FutureOr<void> build() {
    _authRepository = ref.read(authenticationRepositoryProvider);
  }

  Future<void> login(
    String email,
    String password,
    BuildContext context,
  ) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async => await _authRepository.emailSignIn(
        email,
        password,
      ),
    );

    if (state.hasError) {
      showFirebaseErrorSnack(context, state.error);
    } else {
      context.go(CustomRouter.homePath);
    }
  }
}
