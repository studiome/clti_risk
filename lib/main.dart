import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

const Color jsvsColor = Color(0xFF2D6A7B);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CLTI RISK',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: jsvsColor),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: jsvsColor,
      ),
      themeMode: ThemeMode.system,
      home: const MyHomePage(title: 'CLTI Risk Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'CLTI Risk:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            FloatingActionButton(
                foregroundColor: Theme.of(context).colorScheme.primary,
                onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
