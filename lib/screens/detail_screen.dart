import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String message;

  DetailScreen({required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detalles")),
      body: Center(
        child: Text("Mensaje recibido: $message"),
      ),
    );
  }
}
