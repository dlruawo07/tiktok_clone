import 'package:flutter/material.dart';

double getDeviceWidth(BuildContext context) =>
    MediaQuery.of(context).size.width;

double getDeviceHeight(BuildContext context) =>
    MediaQuery.of(context).size.height;

double getDeviceAspectRatio(BuildContext context) =>
    MediaQuery.of(context).size.aspectRatio;
