import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/repositories/videos_repository.dart';

final videosProvider = Provider(
  (ref) => VideosRepository(),
);
