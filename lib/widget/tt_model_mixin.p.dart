import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class TTStatefulWidget extends StatefulWidget {
  const TTStatefulWidget({Key? key}) : super(key: key);

  bool get isMobile => Platform.isIOS || Platform.isAndroid;
}

abstract class TTState<V extends ChangeNotifier, T extends StatefulWidget> extends State<T> with StateMixin<V, T> {
  @override
  Widget build(BuildContext context) {
    final model = getModel(context);
    return buildWithModel(context, model);
  }

  Widget buildWithModel(BuildContext context, V model);
}

class TTChangeNotifier<T extends StatefulWidget> extends ChangeNotifier with ModelMixin<T> {}

mixin StateMixin<V extends ChangeNotifier, T extends StatefulWidget> on State<T> {
  V get model => Provider.of<V>(context, listen: false);
  T get view => widget;

  MediaQueryData get device => MediaQuery.of(context);

  bool get isMobile => Platform.isIOS || Platform.isAndroid;

  V getModel(BuildContext contex) => context.watch<V>();

  bool get isPhone => device.size.width < 600;

  double get keyboardHeight => EdgeInsets.fromWindowPadding(
          WidgetsBinding.instance.window.viewInsets, WidgetsBinding.instance.window.devicePixelRatio)
      .bottom;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (model is ModelMixin) {
        (model as ModelMixin)._buildContext = () => context;
        (model as ModelMixin)._buildWidget = () => widget;
        (model as ModelMixin).onReady();
      }
      didInitState();
    });
    super.initState();
  }

  void didInitState() {}
}

mixin ModelMixin<T extends StatefulWidget> on ChangeNotifier {
  BuildContext Function()? _buildContext;
  T Function()? _buildWidget;
  bool _mount = true;

  BuildContext? get context => _buildContext?.call();
  T? get view => _buildWidget?.call();
  bool get mount => _mount;

  MediaQueryData get device => () {
        return MediaQuery.of(context!);
      }();

  bool get isMobile => Platform.isIOS || Platform.isAndroid;

  bool get isPhone => device.size.width < 600;

  void runOnUI(Function(BuildContext) onCallback, {VoidCallback? onError}) {
    final ctx = context;
    if (ctx == null) {
      onError?.call();
      return;
    }
    onCallback.call(ctx);
  }

  void onReady() {}

  @override
  void dispose() {
    _buildContext = null;
    _mount = false;
    super.dispose();
  }
}
