import 'package:clti_risk/widgets/tab_transition_navigator.dart';
import 'package:flutter/material.dart';

class QuestionPage extends StatelessWidget {
  final int tabIndex;
  final int tabCount;
  final Widget content;
  final String subtitle;
  const QuestionPage(
      {super.key,
      required this.content,
      required this.subtitle,
      required this.tabIndex,
      required this.tabCount});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(subtitle),
          content,
          TabTransitionNavigator(
            tabIndex: tabIndex,
            tabCount: tabCount,
          ),
        ],
      ),
    );
  }
}
