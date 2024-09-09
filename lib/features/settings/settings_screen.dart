import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/settings/widgets/aos_logout.dart';
import 'package:tiktok_clone/features/settings/widgets/ios_bottom_logout.dart';
import 'package:tiktok_clone/features/settings/widgets/ios_logout.dart';
import 'package:tiktok_clone/features/settings/widgets/setting_tile.dart';
import 'package:tiktok_clone/features/videos/view_models/playback_config_view_model.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({
    super.key,
  });

  // ref - ConsumerWidget 사용 시 build 메소드에 추가되는 인자
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref -
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
        children: [
          const VideoSettingListTile(type: "mute"),
          const VideoSettingListTile(type: "autoplay"),
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
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (kDebugMode) {
                print(time);
              }
              final booking = await showDateRangePicker(
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
          const LogoutIOS(),
          const LogoutAOS(),
          const LogoutBottomIOS(),
          // 위와 같음 (자동으로 앱 정보 등 보여줌)
          const AboutListTile(),
        ],
      ),
    );
  }
}
