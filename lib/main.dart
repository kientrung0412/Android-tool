import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ota_tool/screens/adb_home_page.dart';

void main() {
  runApp(const ProviderScope(child: AdbAssistApp()));
}

class AdbAssistApp extends StatelessWidget {
  const AdbAssistApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF8FD3FF),
          secondary: Color(0xFFFFC75F),
          surface: Color(0xFF0F1115),
          background: Color(0xFF0B0E12),
        ),
        scaffoldBackgroundColor: const Color(0xFF0B0E12),
        useMaterial3: true,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 14, height: 1.4),
        ),
      ),
      home: const AdbHomePage(),
    );
  }
}
