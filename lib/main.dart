import 'package:bot_toast/bot_toast.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/gestures.dart';
import 'package:unicross_cbt_desktop_app/screens/splashscreen/splash_screen.dart';
import 'package:unicross_cbt_desktop_app/utilities/color.dart';
import 'package:unicross_cbt_desktop_app/utilities/config.dart';
import 'package:win32/win32.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Must add this line.
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    // size: Size(1200, 600),
    minimumSize: Size(800, 600),
    center: true,
    backgroundColor: Colors.transparent,
    fullScreen: true,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
    windowButtonVisibility: false,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  final VK_WIN = 0x5B; // Windows key virtual key code

  // Register hotkey for the Windows key
  if (RegisterHotKey(NULL, 1, 0x0008, 0x5C) == 0) {
    UnregisterHotKey(NULL, 1);
    print(UnregisterHotKey(NULL, 1),);
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // ThemeMode _themeMode = ThemeMode.light;

  @override
  void initState() {
    sharedConfigManager.addListener(_configListen);
    super.initState();
  }

  @override
  void dispose() {
    sharedConfigManager.removeListener(_configListen);
    super.dispose();
  }

  void _configListen() {
    // _themeMode = sharedConfig.themeMode;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final virtualWindowFrameBuilder = VirtualWindowFrameInit();
    final botToastBuilder = BotToastInit();
    return FluentApp(
        title: 'Unicross CBT',
        debugShowCheckedModeBanner: false,
        scrollBehavior: const FluentScrollBehavior(),
        theme: FluentThemeData(
          scaffoldBackgroundColor: white,
          navigationPaneTheme: NavigationPaneThemeData(
              highlightColor: white,
              backgroundColor: black,
              selectedIconColor: ButtonState.all(white)),
        ),
        builder: (context, child) {
          child = virtualWindowFrameBuilder(context, child);
          child = botToastBuilder(context, child);
          return child;
        },
        navigatorObservers: [BotToastNavigatorObserver()],
        home: const SplashScreen());
  }
}
