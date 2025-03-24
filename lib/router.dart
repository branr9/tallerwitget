import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/home_screen.dart';
import 'screens/detail_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: '/detail/:message',
      builder: (context, state) {
        final message = state.pathParameters['message'] ?? 'Sin mensaje';
        return DetailScreen(message: message);
      },
    ),
  ],
);
