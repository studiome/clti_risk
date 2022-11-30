import 'package:flutter/material.dart';

import './widgets/question_form.dart';

void main() {
  runApp(const MyApp());
}

const Color jsvsColor = Color(0xFF2D6A7B);

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  final String title = 'CLiTICAL';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: jsvsColor,
        fontFamily: 'Noto Sans JP',
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: jsvsColor,
        fontFamily: 'Noto Sans JP',
      ),
      themeMode: ThemeMode.system,
      home: const QuestionForm(title: 'Question Form'),
    );
  }
}
