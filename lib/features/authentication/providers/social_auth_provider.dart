import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/view_models/social_auth_view_model.dart';

final socialAuthProvider = AsyncNotifierProvider<SocialAuthViewModel, void>(
  () => SocialAuthViewModel(),
);
