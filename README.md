# Surepay POS Plugin

[![pub package](https://img.shields.io/pub/v/custom_widgets_2.svg)](https://pub.dev/packages/surepay_pos_plugin)
A Flutter plugin for integrating with Surepay POS USB SDK. This plugin enables communication with Surepay POS terminals via USB connection.

## Features

* USB connection initialization
* Send transaction amounts to terminal
* Receive terminal responses and events
* Handle transaction errors and responses

## Getting Started

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  surepay_pos_plugin: ^0.0.3
```

## Usage

First, initialize the USB connection:

```dart
try {
  String result = await SurepayPosPlugin.initializeUsb();
  print('Initialized: $result');
} catch (e) {
  print('Error initializing: $e');
}
```

Listen to terminal events:

```dart
SurepayPosPlugin.eventStream.listen((event) {
  print('Event received: $event');
});
```

Send an amount to the terminal:

```dart
try {
  String result = await SurepayPosPlugin.sendAmount("100.00");
  print('Amount sent: $result');
} catch (e) {
  print('Error sending amount: $e');
}
```

## Additional Information

* Make sure to add necessary USB permissions to your Android manifest

```XML
<uses-permission android:name="android.permission.USB_PERMISSION" />
```
* Requires Android API level 23 or higher
* add surepaysdkv3.0.0.aar to android/app/libs/
* For detailed implementation, check the example app in the repository

## Contributing

Feel free to contribute to this plugin by creating issues or submitting pull requests.