import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:milunch_pos/services/desktop_tools/option.dart';
import 'package:milunch_pos/utils/platform.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:local_notifier/local_notifier.dart';
import 'package:window_manager/window_manager.dart';

late SharedPreferences _preferences;
final _instance = DesktopTools._();

class DesktopTools with WidgetsBindingObserver {
  DesktopTools._();
  factory DesktopTools() => _instance;

  static WindowManager get window => windowManager;
  static SafePlatform get platform => SafePlatform();

  static Future<void> ensureInitialized([DesktopWindowOptions? options]) async {
    if (!platform.isDesktop) return;
    options ??= DesktopWindowOptions();
    _preferences = await SharedPreferences.getInstance();

    WidgetsFlutterBinding.ensureInitialized();
    WidgetsBinding.instance.addObserver(DesktopTools());

    if (options.title != null) {
      await localNotifier.setup(appName: options.title!);
    }

    await window.ensureInitialized();
    await window.waitUntilReadyToShow(options, () async {
      if (platform.isWindows || platform.isMacOS) {
        await window.setHasShadow(options!.hasShadow);
      }
      await window.setAlignment(options!.alignment);
      await window.setSkipTaskbar(!options.showOnTaskbar);
      if (options.aspectRatio != null) {
        await window.setAspectRatio(options.aspectRatio!);
      }
      if (options.windowBrightness != null) {
        await window.setBrightness(options.windowBrightness!);
      }
      if (options.opacity != null) {
        await window.setOpacity(options.opacity!);
      }
      if (options.position != null) {
        await window.setPosition(options.position!);
      }
      if (options.taskbarIcon != null && platform.isWindows) {
        await window.setIcon(options.taskbarIcon!);
      }
      if (options.hideWindowFrame) await window.setAsFrameless();
      if (options.rememberWindowSize == true) {
        final savedSize =
            json.decode(_preferences.getString(_windowSizeKey) ?? "{}");
        final double? height = savedSize?["height"];
        final double? width = savedSize?["width"];
        await windowManager.setResizable(options.resizable);
        if (savedSize?["maximized"] == true &&
            !(await windowManager.isMaximized())) {
          await windowManager.maximize();
        } else if (height != null && width != null) {
          await windowManager.setSize(Size(width, height));
        }
      }

      await window.show();
    });
  }

  static LocalNotification? createNotification({
    required String title,
    required String message,
    List<LocalNotificationAction>? actions,
    String? identifier,
    bool silent = false,
    String? subtitle,
  }) {
    if (!platform.isDesktop) return null;
    final notification = LocalNotification(
      title: title,
      body: message,
      actions: actions,
      identifier: identifier,
      silent: silent,
      subtitle: subtitle,
    );

    return notification;
  }

  static const _windowSizeKey = "window_size";

  Size? _prevSize;

  @override
  void didChangeMetrics() async {
    super.didChangeMetrics();
    if (platform.isMobile) return;
    final size = await window.getSize();
    final windowSameDimension =
        _prevSize?.width == size.width && _prevSize?.height == size.height;

    if (windowSameDimension || _prevSize == null) {
      _prevSize = size;
      return;
    }
    final isMaximized = await window.isMaximized();
    await _preferences.setString(
      _windowSizeKey,
      jsonEncode({
        'maximized': isMaximized,
        'width': size.width,
        'height': size.height,
      }),
    );
    _prevSize = size;
  }
}
