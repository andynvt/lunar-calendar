import 'package:flutter/material.dart';
import '../module.dart';

class LunarCalendarApp extends StatelessWidget {
  const LunarCalendarApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: createHome(),
    );
  }
}
