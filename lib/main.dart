import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const ElectroBrainApp());
}

class ElectroBrainApp extends StatelessWidget {
  const ElectroBrainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ElectroBrain',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // --- LA LIGNE MAGIQUE ---
        fontFamily: 'Rencana',

        // On garde vos couleurs actuelles
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}