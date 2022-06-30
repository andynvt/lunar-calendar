part of home;

class _HomeViewState extends TTState<_HomeModel, _HomeView> {
  final SystemTray _systemTray = SystemTray();
  final AppWindow _appWindow = AppWindow();

  Timer? _timer;
  bool _toogleTrayIcon = true;

  @override
  void initState() {
    super.initState();
    initSystemTray();
  }

  void initSystemTray() async {
    if (Platform.isAndroid || Platform.isIOS) {
      return;
    }
    String path = Platform.isWindows ? TTIcon.iconTransIco : TTIcon.iconTrans;

    final menu = [
      MenuItem(label: 'Show', onClicked: _appWindow.show),
      MenuItem(label: 'Hide', onClicked: _appWindow.hide),
      MenuItem(
        label: 'Start flash tray icon',
        onClicked: () {
          debugPrint('Start flash tray icon');

          _timer ??= Timer.periodic(
            const Duration(milliseconds: 500),
            (timer) {
              _toogleTrayIcon = !_toogleTrayIcon;
              _systemTray.setImage(_toogleTrayIcon ? '' : path);
            },
          );
        },
      ),
      MenuItem(
        label: 'Stop flash tray icon',
        onClicked: () {
          debugPrint('Stop flash tray icon');

          _timer?.cancel();
          _timer = null;

          _systemTray.setImage(path);
        },
      ),
      MenuSeparator(),
      SubMenu(
        label: 'Test API',
        children: [
          SubMenu(
            label: 'setSystemTrayInfo',
            children: [
              MenuItem(
                label: 'setTitle',
                onClicked: () {
                  final String text = WordPair.random().asPascalCase;
                  debugPrint("click 'setTitle' : $text");
                  _systemTray.setTitle(text);
                },
              ),
              MenuItem(
                label: 'setImage',
                onClicked: () {
                  String iconName = 'icon-trans';
                  String path = Platform.isWindows ? 'assets/icons/$iconName.ico' : 'assets/icons/$iconName.png';

                  debugPrint("click 'setImage' : $path");
                  _systemTray.setImage(path);
                },
              ),
              MenuItem(
                label: 'setToolTip',
                onClicked: () {
                  final String text = WordPair.random().asPascalCase;
                  debugPrint("click 'setToolTip' : $text");
                  _systemTray.setToolTip(text);
                },
              ),
              MenuItem(
                label: 'getTitle [macOS]',
                onClicked: () async {
                  String title = await _systemTray.getTitle();
                  debugPrint("click 'getTitle' : $title");
                },
              ),
            ],
          ),
          MenuItem(label: 'disabled Item', enabled: false),
        ],
      ),
      MenuSeparator(),
      MenuItem(
        label: 'Exit',
        onClicked: _appWindow.close,
      ),
    ];

    // We first init the systray menu and then add the menu entries
    await _systemTray.initSystemTray(
      title: 'system tray',
      iconPath: path,
      toolTip: 'How to use system tray with Flutter',
    );

    await _systemTray.setContextMenu(menu);
    // _systemTray.set

    // handle system tray event
    _systemTray.registerSystemTrayEventHandler((eventName) {
      debugPrint('eventName: $eventName');
      if (eventName == 'leftMouseDown') {
      } else if (eventName == 'leftMouseUp') {
        _appWindow.show();
      } else if (eventName == 'rightMouseDown') {
      } else if (eventName == 'rightMouseUp') {
        _systemTray.popUpContextMenu();
      }
    });
  }

  @override
  Widget buildWithModel(BuildContext context, _HomeModel model) {
    return const Scaffold(
      backgroundColor: Colors.blue,
    );
  }
}
