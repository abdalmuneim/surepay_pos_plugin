import 'package:flutter/material.dart';
import 'package:surepay_pos_plugin/surepay_pos_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _status = 'Not initialized';
  final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeUsb();
    _listenToEvents();
  }

  Future<void> _initializeUsb() async {
    try {
      String result = await SurepayPosPlugin.initializeUsb();
      setState(() {
        _status = 'Initialized: $result';
      });
    } catch (e) {
      setState(() {
        _status = 'Error initializing: $e';
      });
    }
  }

  void _listenToEvents() {
    SurepayPosPlugin.eventStream.listen((event) {
      setState(() {
        _status = 'Event received: $event';
      });
    });
  }

  Future<void> _sendAmount() async {
    if (_amountController.text.isEmpty) return;

    try {
      String result = await SurepayPosPlugin.sendAmount(_amountController.text);
      setState(() {
        _status = 'Amount sent: $result';
      });
    } catch (e) {
      setState(() {
        _status = 'Error sending amount: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Sure POS Plugin Example'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _amountController,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  hintText: 'Enter amount',
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _sendAmount,
                child: const Text('Send Amount'),
              ),
              const SizedBox(height: 16),
              Text('Status: $_status'),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }
}
