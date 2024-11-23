// lib/main.dart
import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart';
import 'screens/anime_list_screen.dart';
import 'screens/add_anime_screen.dart';

void main() {
  runApp(AnimeCollectionApp());
}

class AnimeCollectionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coleção de Animes',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.grey[100],
        cardTheme: CardTheme(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => DashboardScreen(),
        '/anime_list': (context) => AnimeListScreen(),
        '/add_anime': (context) => AddAnimeScreen(),
      },
    );
  }
}
