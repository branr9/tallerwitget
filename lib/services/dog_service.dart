import 'dart:convert';
import 'package:http/http.dart' as http;

class DogService {
  // Obtener listado de razas con una imagen representativa
  static Future<List<Map<String, String>>> getRazasConImagen() async {
    final response = await http.get(Uri.parse('https://dog.ceo/api/breeds/list/all'));

    if (response.statusCode != 200) {
      throw Exception('Error al cargar razas');
    }

    final data = jsonDecode(response.body);
    final Map<String, dynamic> razas = data['message'];

    final List<Map<String, String>> razasConImagen = [];

    for (final raza in razas.keys) {
      final imagen = await _getImagenDeRaza(raza);
      razasConImagen.add({'raza': raza, 'imagen': imagen});
    }

    return razasConImagen;
  }

  // Obtener imagen aleatoria de una raza
  static Future<String> _getImagenDeRaza(String raza) async {
    final url = 'https://dog.ceo/api/breed/$raza/images/random';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      return 'https://via.placeholder.com/150';
    }

    final data = jsonDecode(response.body);
    return data['message'];
  }

  // Obtener varias imágenes de una raza (para detalle)
  static Future<List<String>> getImagenesDeRaza(String raza) async {
    final url = 'https://dog.ceo/api/breed/$raza/images';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw Exception('No se pudieron cargar las imágenes de $raza');
    }

    final data = jsonDecode(response.body);
    final List<dynamic> imagenes = data['message'];
    return imagenes.cast<String>().take(20).toList(); // máximo 20 imágenes
  }
}
