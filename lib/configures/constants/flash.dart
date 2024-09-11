import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class Flash {
  static final icons = [
    Icons.flash_off_rounded,
    Icons.flash_on_rounded,
    Icons.flash_auto_rounded,
    Icons.flashlight_on_rounded,
  ];
  static final List<FlashMode> modes = [
    FlashMode.off,
    FlashMode.always,
    FlashMode.auto,
    FlashMode.torch
  ];
}
