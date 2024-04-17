import 'dart:io';

import 'package:flutter/foundation.dart';

final SafePlatform _platform = SafePlatform._();

class SafePlatform {
  SafePlatform._();

  factory SafePlatform() => _platform;

  bool get isWeb => kIsWeb;
  bool get isDesktop => isLinux || isWindows || isMacOS;
  bool get isMobile => isAndroid || isIOS;

  bool get isMacOS => kIsWeb ? false : Platform.isMacOS;
  bool get isLinux => kIsWeb ? false : Platform.isLinux;
  bool get isAndroid => kIsWeb ? false : Platform.isAndroid;
  bool get isIOS => kIsWeb ? false : Platform.isIOS;
  bool get isWindows => kIsWeb ? false : Platform.isWindows;
}
