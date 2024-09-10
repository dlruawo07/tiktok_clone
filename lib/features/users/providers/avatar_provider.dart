import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/users/view_models/avatar_view_model.dart';

final avatarProvider = AsyncNotifierProvider<AvatarViewModel, void>(
  () => AvatarViewModel(),
);
