import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/providers/auth_provider.dart';
import 'package:tiktok_clone/features/users/models/user_profile_model.dart';
import 'package:tiktok_clone/features/users/repositories/user_repository.dart';
import 'package:tiktok_clone/features/users/view_models/users_view_model.dart';

final userRepositoryProvider = Provider(
  (ref) => UserRepository(),
);

final usersProvider = AsyncNotifierProvider<UsersViewModel, UserProfileModel>(
  () => UsersViewModel(),
);

final userOnlineStatusProvider = StreamProvider.family<bool, String>(
  (ref, userId) {
    final authRepo = ref.read(authRepositoryProvider);
    return authRepo.getUserOnlineStatus(userId);
  },
);

final userProfileStreamProvider =
    StreamProvider.family<UserProfileModel, String>((ref, userId) {
  final userRepo = ref.read(userRepositoryProvider);

  return userRepo.watchUserProfile(userId);
});
