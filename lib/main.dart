import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart' hide MenuItem;
import 'module/app/app.dart';

void main() {
  runApp(const LunarCalendarApp());

  doWhenWindowReady(() {
    final win = appWindow;
    const initialSize = Size(600, 450);
    win
      ..minSize = initialSize
      ..size = initialSize
      ..alignment = Alignment.center
      ..title = 'exxxxample'
      ..show();
  });
}
