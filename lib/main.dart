import 'package:flutter/material.dart';
import 'package:etms_flutter/dashboard_screen.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(TMSApp());
}

class TMSApp extends StatelessWidget {
  const TMSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Set status bar color
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: const Color.fromARGB(255, 42, 8, 86), // Dark purple color
      statusBarIconBrightness: Brightness.light, // White icons for visibility
    ));

    return DashboardScreen();
  }
}
