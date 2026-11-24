import 'package:cairn/driver/driver_app.dart';
import 'package:cairn/injection/injection.dart';
import 'package:cairn/owner/owner_app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

bool get _isDesktop =>
    !kIsWeb &&
    (defaultTargetPlatform == TargetPlatform.windows ||
        defaultTargetPlatform == TargetPlatform.linux ||
        defaultTargetPlatform == TargetPlatform.macOS);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies();

  if (_isDesktop) {
    await _setupDesktopWindow();
    runApp(const OwnerApp());
  } else {
    runApp(const DriverApp());
  }
}

Future<void> _setupDesktopWindow() async {
  await windowManager.ensureInitialized();

  const options = WindowOptions(
    title: 'Cairn Owner',
    center: true,
    titleBarStyle: TitleBarStyle.normal,
  );

  await windowManager.waitUntilReadyToShow(options, () async {
    await windowManager.maximize();
    await windowManager.setResizable(false);
    await windowManager.setMaximizable(false);
    await windowManager.show();
    await windowManager.focus();
  });
}