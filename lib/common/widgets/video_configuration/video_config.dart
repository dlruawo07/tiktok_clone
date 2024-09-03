import 'package:flutter/widgets.dart';

class VideoConfig extends ChangeNotifier {
  bool isMuted = false;
  bool isAutoplay = false;

  void toggleIsMuted() {
    isMuted = !isMuted;
    notifyListeners();
  }

  void toggleAutoplay() {
    isAutoplay = !isAutoplay;
    notifyListeners();
  }
}

// // ValueNotifier (Lecture 20.10)
// final videoConfig = ValueNotifier(false);

// // ChangeNotifier (Lecture 20.9)

// class VideoConfig extends ChangeNotifier {
//   bool autoMute = false;

//   void toggleMute() {
//     autoMute = !autoMute;
//     notifyListeners();
//   }
// }

// final videoConfig = VideoConfig();

// // InheritedWidget (Lecture 20.6~20.8)

// class VideoConfigData extends InheritedWidget {
//   final bool autoMute;
//   final void Function() toggleMute;

//   const VideoConfigData({
//     super.key,
//     required super.child,
//     required this.autoMute,
//     required this.toggleMute,
//   });

//   static VideoConfigData of(BuildContext context) =>
//       context.dependOnInheritedWidgetOfExactType<VideoConfigData>()!;

//   // updateShouldNotify - 위젯을 리빌드 할 지 말 지 정할 수 있게 해줌
//   // 위젯의 구버전이 있을 수도 있기 때문
//   // oldWidget: 구버전 위젯의 state
//   @override
//   bool updateShouldNotify(covariant InheritedWidget oldWidget) {
//     return true;
//   }
// }

// class VideoConfig extends StatefulWidget {
//   final Widget child;

//   const VideoConfig({
//     super.key,
//     required this.child,
//   });

//   @override
//   State<VideoConfig> createState() => _VideoConfigState();
// }

// class _VideoConfigState extends State<VideoConfig> {
//   bool autoMute = false;

//   void toggleMute() {
//     setState(() {
//       autoMute = !autoMute;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return VideoConfigData(
//       autoMute: autoMute,
//       toggleMute: toggleMute,
//       child: widget.child,
//     );
//   }
// }
