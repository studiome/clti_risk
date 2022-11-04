import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final String title;
  final Widget child;
  const AppScaffold({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: child,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          icon: const Icon(Icons.analytics),
          label: const Text('Calculate')),
    );
  }
}
