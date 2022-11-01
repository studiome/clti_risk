import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final String title;
  final Widget child;
  const AppScaffold({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              title: Text(title),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                  childCount: 1, (context, index) => child),
            ),
          ],
        ),
      ),
    );
  }
}
