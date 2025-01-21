import 'dart:async';
import 'package:flutter/services.dart';

class SurepayPosPlugin {
  static const MethodChannel _channel = MethodChannel('com.mnemdev.surepayposplugin/channel');
  static const EventChannel _eventChannel =
  EventChannel('com.mnemdev.surepayposplugin/event');
  static Stream<dynamic>? _eventStream;

  /// Initialize USB connection
  static Future<String> initializeUsb() async {
    try {
      final String result =
      await _channel.invokeMethod('usbConnectionInitialize');
      return result;
    } on PlatformException catch (e) {
      throw 'Failed to initialize USB: ${e.message}';
    }
  }

  /// Send amount to terminal
  static Future<String> sendAmount(String amount) async {
    try {
      final String result = await _channel.invokeMethod('sendAmount', {
        'amount': amount,
      });
      return result;
    } on PlatformException catch (e) {
      throw 'Failed to send amount: ${e.message}';
    }
  }

  /// Clear stored data
  static Future<String> clearData() async {
    try {
      final String result = await _channel.invokeMethod('clearData');
      return result;
    } on PlatformException catch (e) {
      throw 'Failed to clear data: ${e.message}';
    }
  }

  /// Listen to terminal events
  static Stream<dynamic> get eventStream {
    _eventStream ??= _eventChannel.receiveBroadcastStream();
    return _eventStream!;
  }
}
