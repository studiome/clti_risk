import 'package:flutter/material.dart';

import './widgets/app_scaffold.dart';

void main() {
  runApp(const MyApp());
}

const Color jsvsColor = Color(0xFF2D6A7B);

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  final String title = 'CLTI Patient Risk Predictor';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: jsvsColor),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: jsvsColor,
      ),
      themeMode: ThemeMode.system,
      home: AppScaffold(title: title),
    );
  }
}
