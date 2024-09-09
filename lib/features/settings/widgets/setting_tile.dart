import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/view_models/playback_config_view_model.dart';

class VideoSettingListTile extends ConsumerWidget {
  final String type;
  const VideoSettingListTile({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchListTile.adaptive(
      value: type == "mute"
          ? ref.watch(playbackConfigProvider).muted
          : ref.watch(playbackConfigProvider).autoplay,
      onChanged: (value) =>
          // .notifier를 붙여야 데이터 뿐만 아니라 다른 클래스 메소드에도 접근할 수 있다
          type == "mute"
              ? ref.read(playbackConfigProvider.notifier).setMuted(value)
              : ref.read(playbackConfigProvider.notifier).setAutoplay(value),
      title: Text(type == "mute" ? "Mute videos" : "Autoplay videos"),
      subtitle: Text(
        type == "mute"
            ? "Videos will be muted by default."
            : "Videos will be played automatically by default.",
      ),
    );
  }
}
