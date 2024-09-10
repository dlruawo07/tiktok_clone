import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/configures/router.dart';
import 'package:tiktok_clone/features/authentication/providers/auth_provider.dart';
import 'package:tiktok_clone/features/authentication/repositories/authentication_repository.dart';
import 'package:tiktok_clone/utils/error_snackbar.dart';

class SocialAuthViewModel extends AsyncNotifier<void> {
  late final AuthRepository _repository;
  @override
  FutureOr<void> build() {
    _repository = ref.read(authRepositoryProvider);
  }

  Future<void> githubSignIn(BuildContext context) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(
      () async => await _repository.githubSignIn(),
    );

    if (!context.mounted) return;

    if (state.hasError) {
      showFirebaseErrorSnack(context, state.error);
    } else {
      context.go(CustomRouter.homePath);
    }
  }
}
