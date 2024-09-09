import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repositories/authentication_repository.dart';

final authenticationRepositoryProvider = Provider(
  (ref) => AuthenticationRepository(),
);

final authStateChangesProvider = StreamProvider<User?>(
  (ref) {
    final authRepo = ref.read(authenticationRepositoryProvider);
    return authRepo.authStateChanges();
  },
);
