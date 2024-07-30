import 'dart:io';

import 'package:flutter/foundation.dart';

final kIsDesktop = Platform.isWindows || Platform.isLinux || Platform.isMacOS;
final kIsMobile = Platform.isAndroid || Platform.isIOS;

final kIsMacOS = kIsWeb ? false : Platform.isMacOS;
final kIsWindows = kIsWeb ? false : Platform.isWindows;
final kIsLinux = kIsWeb ? false : Platform.isLinux;
final kIsAndroid = kIsWeb ? false : Platform.isAndroid;
final kIsIOS = kIsWeb ? false : Platform.isIOS;
