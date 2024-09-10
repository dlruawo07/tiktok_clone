import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/view_models/signup_view_model.dart';

final signupFormProvider = StateProvider(
  (ref) => {},
);

final signupProvider = AsyncNotifierProvider<SignupViewModel, void>(
  () => SignupViewModel(),
);
