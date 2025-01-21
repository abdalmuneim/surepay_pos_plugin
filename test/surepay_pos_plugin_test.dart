import 'package:flutter_test/flutter_test.dart';
import 'package:surepay_pos_plugin/surepay_pos_plugin.dart';
import 'package:surepay_pos_plugin/surepay_pos_plugin_platform_interface.dart';
import 'package:surepay_pos_plugin/surepay_pos_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockSurepayPosPluginPlatform
    with MockPlatformInterfaceMixin
    implements SurepayPosPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final SurepayPosPluginPlatform initialPlatform = SurepayPosPluginPlatform.instance;

  test('$MethodChannelSurepayPosPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSurepayPosPlugin>());
  });

  test('getPlatformVersion', () async {
    SurepayPosPlugin surepayPosPlugin = SurepayPosPlugin();
    MockSurepayPosPluginPlatform fakePlatform = MockSurepayPosPluginPlatform();
    SurepayPosPluginPlatform.instance = fakePlatform;

    expect(await surepayPosPlugin.getPlatformVersion(), '42');
  });
}
