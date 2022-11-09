import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final String title;
  final Widget child;
  const AppScaffold({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
            headerSliverBuilder: ((context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  title: Text(title),
                  forceElevated: innerBoxIsScrolled,
                ),
              ];
            }),
            body: SafeArea(
              bottom: false,
              maintainBottomViewPadding: true,
              child: child,
            )));
  }
}
