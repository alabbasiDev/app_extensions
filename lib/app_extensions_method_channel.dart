import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'app_extensions_platform_interface.dart';

/// An implementation of [AppExtensionsPlatform] that uses method channels.
class MethodChannelAppExtensions extends AppExtensionsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('app_extensions');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
