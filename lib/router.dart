import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/listado_screen.dart';
import 'screens/detalle_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'listado',
      builder: (context, state) => const ListadoScreen(),
    ),
    GoRoute(
      path: '/detalle/:raza',
      name: 'detalle',
      builder: (context, state) {
        final raza = state.pathParameters['raza']!;
        return DetalleScreen(raza: raza);
      },
    ),
  ],
);
