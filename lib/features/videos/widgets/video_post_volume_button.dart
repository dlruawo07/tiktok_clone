import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/features/videos/providers/playback_config_provider.dart';

class VideoPostVolumeButton extends ConsumerWidget {
  const VideoPostVolumeButton({
    super.key,
    required this.onPlaybackConfigChanged,
  });

  final Function() onPlaybackConfigChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Positioned(
      right: 10,
      child: SafeArea(
        child: IconButton(
          icon: FaIcon(
            ref.watch(playbackConfigProvider).muted
                ? FontAwesomeIcons.volumeXmark
                : FontAwesomeIcons.volumeHigh,
            color: Colors.white,
          ),
          onPressed: onPlaybackConfigChanged,
        ),
      ),
    );
  }
}
