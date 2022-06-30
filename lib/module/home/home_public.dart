library home;

import 'dart:async';
import 'dart:io';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart' hide MenuItem;
import 'package:provider/provider.dart';
import 'package:system_tray/system_tray.dart';

import '../../res/icon.p.dart';
import '../../widget/widget.dart';

part 'home_model.dart';
part 'home_state.dart';
part 'home_view.dart';

ChangeNotifierProvider<_HomeModel> createHome() {
  return ChangeNotifierProvider<_HomeModel>(
    create: (_) => _HomeModel(),
    child: _HomeView(),
  );
}
