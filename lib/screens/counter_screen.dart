import 'dart:async';
import 'package:flutter/material.dart';

class CounterScreen extends StatefulWidget {
  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _counter = 0;
  Timer? _timer;

  void _start() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() => _counter++);
    });
  }

  void _pause() {
    _timer?.cancel();
  }

  void _reset() {
    _timer?.cancel();
    setState(() => _counter = 0);
    _start(); // Reinicia
  }

  @override
  void dispose() {
    _timer?.cancel(); // Previene fugas
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contador")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Contador: $_counter', style: TextStyle(fontSize: 32)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: _start, child: Text("Iniciar")),
                SizedBox(width: 10),
                ElevatedButton(onPressed: _pause, child: Text("Pausar")),
                SizedBox(width: 10),
                ElevatedButton(onPressed: _reset, child: Text("Reiniciar")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
