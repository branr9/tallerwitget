import 'package:flutter/material.dart';
import '../services/dog_service.dart';

class DetalleScreen extends StatefulWidget {
  final String raza;

  const DetalleScreen({super.key, required this.raza});

  @override
  State<DetalleScreen> createState() => _DetalleScreenState();
}

class _DetalleScreenState extends State<DetalleScreen> {
  late Future<List<String>> _imagenesFuture;

  @override
  void initState() {
    super.initState();
    _imagenesFuture = DogService.getImagenesDeRaza(widget.raza);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalle: ${widget.raza}')),
      body: FutureBuilder<List<String>>(
        future: _imagenesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay imágenes.'));
          }

          final imagenes = snapshot.data!;
          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: imagenes.length,
            itemBuilder: (context, index) {
              return Image.network(imagenes[index], fit: BoxFit.cover);
            },
          );
        },
      ),
    );
  }
}
