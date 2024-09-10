import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/users/models/user_profile_model.dart';
import 'package:tiktok_clone/features/users/repositories/user_repository.dart';
import 'package:tiktok_clone/features/users/view_models/users_view_model.dart';

final userRepositoryProvider = Provider(
  (ref) => UserRepository(),
);

final usersProvider = AsyncNotifierProvider<UsersViewModel, UserProfileModel>(
  () => UsersViewModel(),
);
