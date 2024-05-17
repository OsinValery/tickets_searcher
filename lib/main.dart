import 'package:flutter/material.dart';
import 'package:tickets_searcher/ui/main/view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        useMaterial3: false,
        fontFamily: "SF Pro Display",
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Color(0xff2261BC),
          onPrimary: Colors.white,
          secondary: Color(0xFF9E9E9E),
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          background: Colors.black,
          onBackground: Colors.white,
          surface: Color.fromARGB(255, 36, 37, 41),
          surfaceVariant: Color.fromARGB(255, 29, 30, 32),
          surfaceTint: Color.fromARGB(255, 47, 48, 53),
          onSurface: Colors.white,
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
          titleMedium: TextStyle(
            fontSize: 20,
          ),
          titleSmall: TextStyle(
            fontSize: 16,
          ),
          labelLarge: TextStyle(
            fontSize: 16,
          ),
          labelMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w200,
          ),
          displaySmall: TextStyle(
            fontSize: 14,
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.black,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.white,
          selectedIconTheme: IconThemeData(color: Colors.blue),
          showUnselectedLabels: true,
        ),
        dividerColor: const Color(0xff5E5F61),
      ),
      home: const MainScreenView(),
    );
  }
}
