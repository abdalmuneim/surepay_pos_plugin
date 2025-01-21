import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'surepay_pos_plugin_method_channel.dart';

abstract class SurepayPosPluginPlatform extends PlatformInterface {
  /// Constructs a SurepayPosPluginPlatform.
  SurepayPosPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static SurepayPosPluginPlatform _instance = MethodChannelSurepayPosPlugin();

  /// The default instance of [SurepayPosPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelSurepayPosPlugin].
  static SurepayPosPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SurepayPosPluginPlatform] when
  /// they register themselves.
  static set instance(SurepayPosPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
