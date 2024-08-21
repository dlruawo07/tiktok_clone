import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = false;

  void _onNotificationsChanged(bool? value) {
    if (value == null) {
      return;
    }
    setState(() {
      _notifications = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
        children: [
          SwitchListTile.adaptive(
            value: _notifications,
            onChanged: _onNotificationsChanged,
            title: const Text("Enable notifications"),
            subtitle: const Text("Adaptive OS SwitchListTile"),
          ),
          CupertinoSwitch(
            value: _notifications,
            onChanged: _onNotificationsChanged,
          ),
          SwitchListTile(
            value: _notifications,
            onChanged: _onNotificationsChanged,
            activeColor: Colors.black,
            title: const Text("Enable notifications"),
          ),
          Checkbox(
            value: _notifications,
            onChanged: _onNotificationsChanged,
            activeColor: Colors.black,
          ),
          CheckboxListTile(
            activeColor: Colors.black,
            value: _notifications,
            onChanged: _onNotificationsChanged,
            title: const Text("Enable notifications"),
          ),
          // ListTile(
          //   onTap: () => showAboutDialog(
          //     context: context,
          //     applicationVersion: "1.0",
          //     applicationLegalese: "All rights reserved. Please don't copy me.",
          //   ),
          //   subtitle: const Text("About this app.."),
          //   title: const Text(
          //     "About",
          //     style: TextStyle(
          //       fontWeight: FontWeight.w600,
          //     ),
          //   ),
          // ),
          ListTile(
            onTap: () async {
              await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1980),
                lastDate: DateTime(2030),
              );
              await showTimePicker(
                // ignore: use_build_context_synchronously
                context: context,
                initialTime: TimeOfDay.now(),
              );
              await showDateRangePicker(
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
              return;
            },
            title: const Text("What is your birthday?"),
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
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("No"),
                    ),
                    CupertinoDialogAction(
                      onPressed: () => Navigator.of(context).pop(),
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
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("No"),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
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
          // NOTE: 위와 같음 (자동으로 앱 정보 등 보여줌)
          const AboutListTile(),
        ],
      ),

      // Column(
      //   children: [
      //     // CupertinoActivityIndicator(
      //     //   radius: 40,
      //     //   // animating: false,
      //     // ),
      //     // CircularProgressIndicator(),
      //     // NOTE: 디바이스가 어느 플랫폼인지 확인 후 실행
      //     CircularProgressIndicator.adaptive(),
      //   ],
      // )

      // ListWheelScrollView(
      //   diameterRatio: 1.5,
      //   // offAxisFraction: 10,
      //   itemExtent: 200,
      //   children: [
      //     for (var x in [1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 12])
      //       FractionallySizedBox(
      //         widthFactor: 1,
      //         child: Container(
      //           color: Colors.teal,
      //           alignment: Alignment.center,
      //           child: const Text(
      //             "Pick me",
      //             style: TextStyle(
      //               color: Colors.white,
      //               fontSize: Sizes.size36,
      //             ),
      //           ),
      //         ),
      //       ),
      //   ],
      // ),
    );
  }
}
