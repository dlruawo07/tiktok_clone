import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/videos/view_models/playback_config_view_model.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({
    super.key,
  });

  // ref - ConsumerWidget 사용 시 build 메소드에 추가되는 인자
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref -
    return Localizations.override(
      context: context,
      locale: const Locale("es"),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
        ),
        body: ListView(
          children: [
            SwitchListTile.adaptive(
              value: ref.watch(playbackConfigProvider).muted,
              onChanged: (value) =>
                  // .notifier를 붙여야 데이터 뿐만 아니라 다른 클래스 메소드에도 접근할 수 있다
                  ref.read(playbackConfigProvider.notifier).setMuted(value),
              title: const Text("Mute videos"),
              subtitle: const Text("Videos will be muted by default."),
            ),
            SwitchListTile.adaptive(
              value: ref.watch(playbackConfigProvider).autoplay,
              onChanged: (value) =>
                  ref.read(playbackConfigProvider.notifier).setAutoplay(value),
              title: const Text("Autoplay videos"),
              subtitle:
                  const Text("Videos will be played automatically by default."),
            ),
            ListTile(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1980),
                  lastDate: DateTime(2030),
                );
                if (kDebugMode) {
                  print(date);
                }
                final time = await showTimePicker(
                  // ignore: use_build_context_synchronously
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (kDebugMode) {
                  print(time);
                }
                final booking = await showDateRangePicker(
                  // ignore: use_build_context_synchronously
                  context: context,
                  firstDate: DateTime(1980),
                  lastDate: DateTime(2030),
                  builder: (context, child) {
                    return Theme(
                      data: ThemeData(
                        appBarTheme: const AppBarTheme(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.black,
                        ),
                      ),
                      child: child!,
                    );
                  },
                );
                if (kDebugMode) {
                  print(booking);
                }
                return;
              },
              title: const Text("When is your birthday?"),
            ),
            ListTile(
              onTap: () {
                showCupertinoDialog(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                    title: const Text("Are you sure?"),
                    content: const Text("Please don't go"),
                    actions: [
                      CupertinoDialogAction(
                        onPressed: () => context.pop(),
                        child: const Text("No"),
                      ),
                      CupertinoDialogAction(
                        onPressed: () => context.pop(),
                        isDestructiveAction: true,
                        child: const Text("Yes"),
                      ),
                    ],
                  ),
                );
              },
              title: const Text("Log out (iOS)"),
              textColor: Colors.red,
            ),
            ListTile(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    icon: const FaIcon(FontAwesomeIcons.skull),
                    title: const Text("Are you sure?"),
                    content: const Text("Please don't go"),
                    actions: [
                      TextButton(
                        onPressed: () => context.pop(),
                        child: const Text("No"),
                      ),
                      TextButton(
                        onPressed: () => context.pop(),
                        child: const Text("Yes"),
                      ),
                    ],
                  ),
                );
              },
              title: const Text("Log out (Android)"),
              textColor: Colors.red,
            ),
            ListTile(
              onTap: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) => CupertinoActionSheet(
                    title: const Text("Are you sure?"),
                    message: const Text("Please don't go."),
                    actions: [
                      CupertinoActionSheetAction(
                        isDefaultAction: true,
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text("Not log out"),
                      ),
                      CupertinoActionSheetAction(
                        onPressed: () => Navigator.of(context).pop(),
                        isDestructiveAction: true,
                        child: const Text("Yes please"),
                      ),
                    ],
                  ),
                );
              },
              title: const Text("Log out (iOS / Bottom)"),
              textColor: Colors.red,
            ),
            // 위와 같음 (자동으로 앱 정보 등 보여줌)
            const AboutListTile(),
          ],
        ),
      ),
    );
  }
}
