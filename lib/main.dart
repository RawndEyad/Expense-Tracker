import 'package:expenses_tracker_app/views/pages/expense.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

final colorScheme = ColorScheme.fromSeed(
  seedColor: Colors.teal,
  brightness: Brightness.light,
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      home: const ExpensesPage(),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,

        fontFamily: 'Roboto',

        scaffoldBackgroundColor: colorScheme.background,

        appBarTheme: AppBarTheme(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: 2,
          titleTextStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: colorScheme.secondary,
          foregroundColor: colorScheme.onSecondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),

        cardTheme: CardTheme(
          color: colorScheme.surface,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        ),

        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: colorScheme.surfaceVariant,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          labelStyle: TextStyle(color: colorScheme.onSurface),
        ),

        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: colorScheme.primary,
            textStyle: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
        ),
      ),
    );
  }
}
