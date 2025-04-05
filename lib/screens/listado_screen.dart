import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/dog_service.dart';

class ListadoScreen extends StatefulWidget {
  const ListadoScreen({super.key});

  @override
  State<ListadoScreen> createState() => _ListadoScreenState();
}

class _ListadoScreenState extends State<ListadoScreen> {
  late Future<List<Map<String, String>>> _razasFuture;

  @override
  void initState() {
    super.initState();
    _razasFuture = DogService.getRazasConImagen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Razas de Perros')),
      body: FutureBuilder<List<Map<String, String>>>(
        future: _razasFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No se encontraron razas.'));
          }

          final razas = snapshot.data!;
          return ListView.builder(
            itemCount: razas.length,
            itemBuilder: (context, index) {
              final raza = razas[index]['raza']!;
              final imagen = razas[index]['imagen']!;
              return ListTile(
                leading: Image.network(imagen, width: 50, height: 50, fit: BoxFit.cover),
                title: Text(raza),
                onTap: () => context.push('/detalle/$raza'),
              );
            },
          );
        },
      ),
    );
  }
}
