import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailScreen extends StatelessWidget {
  final String message;

  DetailScreen({required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detalles")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Mensaje recibido:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              message,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.go('/'); // Regresar a la pantalla principal
              },
              child: Text("Regresar al inicio"),
            ),
          ],
        ),
      ),
    );
  }
}
