import 'package:flutter/material.dart';
import 'dart:async';

class StudentListScreen extends StatefulWidget {
  @override
  _StudentListScreenState createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  List<String> _students = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    obtenerEstudiantes();
  }

  Future<void> obtenerEstudiantes() async {
    // Simula carga de datos
    final datos = await Future.delayed(
      Duration(seconds: 3),
      () => ['Ana', 'Luis', 'Carlos', 'Sofía', 'Mariana'],
    );
    if (!mounted) return;
    setState(() {
      _students = datos;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lista de Estudiantes")),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _students.length,
              itemBuilder: (context, index) {
                return ListTile(title: Text(_students[index]));
              },
            ),
    );
  }
}
