import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/home_screen.dart';
import 'screens/detail_screen.dart';
import 'screens/student_list_screen.dart';
import 'screens/counter_screen.dart';
import 'screens/heavy_task_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    // Ruta principal
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen(),
    ),
    // Ruta con parámetro
    GoRoute(
      path: '/detail/:message',
      builder: (context, state) {
        final message = state.pathParameters['message'] ?? 'Sin mensaje';
        return DetailScreen(message: message);
      },
    ),
    // Lista de estudiantes (Future)
    GoRoute(
      path: '/students',
      builder: (context, state) => StudentListScreen(),
    ),
    // Contador con Timer
    GoRoute(
      path: '/counter',
      builder: (context, state) => CounterScreen(),
    ),
    // Tarea pesada con Isolate
    GoRoute(
      path: '/heavy-task',
      builder: (context, state) => HeavyTaskScreen(),
    ),
  ],
);
