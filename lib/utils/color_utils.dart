import 'package:flutter/material.dart';
import 'package:fuodz/utils/utils.dart';

class ColorUtils extends Utils {
  //
  static Color shuffleColorByMode(
    BuildContext context, {
    required Color lightMode,
    required Color darkMode,
  }) {
    //check if the current theme is dark or light
    return View.of(context).platformDispatcher.platformBrightness ==
            Brightness.dark
        ? darkMode
        : lightMode;
  }
}
