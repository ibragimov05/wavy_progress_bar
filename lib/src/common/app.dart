import 'package:flutter/material.dart';

import '../main_screen.dart';

/// {@template app}
/// App widget.
/// {@endtemplate}
class App extends StatelessWidget {
  /// {@macro app}
  const App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Wavy Progress Bar',
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(title: const Text('Wavy Progress Bar'), backgroundColor: Colors.blue),
      backgroundColor: Colors.lightBlueAccent,
      body: const CircularWaveProgress(),
    ),
  );
}
