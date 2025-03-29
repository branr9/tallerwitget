import 'dart:async';
import 'dart:isolate';
import 'package:flutter/material.dart';

class HeavyTaskScreen extends StatefulWidget {
  @override
  _HeavyTaskScreenState createState() => _HeavyTaskScreenState();
}

class _HeavyTaskScreenState extends State<HeavyTaskScreen> {
  bool _calculating = false;

  void _startHeavyTask() async {
    setState(() => _calculating = true);

    final receivePort = ReceivePort();
    await Isolate.spawn(_sumNumbers, receivePort.sendPort);

    final result = await receivePort.first as int;

    if (!mounted) return;

    setState(() => _calculating = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Resultado: $result')),
    );
  }

  static void _sumNumbers(SendPort sendPort) {
    int sum = 0;
    for (int i = 1; i <= 2000000; i++) {
      sum += i;
    }
    sendPort.send(sum);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tarea Pesada")),
      body: Center(
        child: _calculating
            ? CircularProgressIndicator()
            : ElevatedButton(
                onPressed: _startHeavyTask,
                child: Text("Iniciar Tarea Pesada"),
              ),
      ),
    );
  }
}
