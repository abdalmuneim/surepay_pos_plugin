import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'surepay_pos_plugin_platform_interface.dart';

/// An implementation of [SurepayPosPluginPlatform] that uses method channels.
class MethodChannelSurepayPosPlugin extends SurepayPosPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('surepay_pos_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
