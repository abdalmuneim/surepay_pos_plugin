import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:surepay_pos_plugin/surepay_pos_plugin_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelSurepayPosPlugin platform = MethodChannelSurepayPosPlugin();
  const MethodChannel channel = MethodChannel('surepay_pos_plugin');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
