# Surepay POS Plugin

A Flutter plugin for integrating with Sure POS USB SDK. This plugin enables communication with Sure POS terminals via USB connection.

## Features

* USB connection initialization
* Send transaction amounts to terminal
* Receive terminal responses and events
* Handle transaction errors and responses

## Getting Started

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  sure_pos_plugin: ^0.0.1
```

## Usage

First, initialize the USB connection:

```dart
try {
  String result = await SurePosPlugin.initializeUsb();
  print('Initialized: $result');
} catch (e) {
  print('Error initializing: $e');
}
```

Listen to terminal events:

```dart
SurePosPlugin.eventStream.listen((event) {
  print('Event received: $event');
});
```

Send an amount to the terminal:

```dart
try {
  String result = await SurePosPlugin.sendAmount("100.00");
  print('Amount sent: $result');
} catch (e) {
  print('Error sending amount: $e');
}
```

## Additional Information

* Make sure to add necessary USB permissions to your Android manifest
* Requires Android API level 23 or higher
* add surepaysdkv3.0.0.aar to android/app/libs/
* For detailed implementation, check the example app in the repository

## Contributing

Feel free to contribute to this plugin by creating issues or submitting pull requests.#   s u r e p a y _ p o s _ p l u g i n 
 
 