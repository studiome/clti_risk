import 'package:flutter/material.dart';

class TabTransitionNavigator extends StatelessWidget {
  final int tabIndex; //[0 .. tabCount-1]
  final int tabCount;
  const TabTransitionNavigator(
      {super.key, required this.tabIndex, required this.tabCount});

  @override
  Widget build(BuildContext context) {
    final TabController? tabController = DefaultTabController.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: (tabIndex == tabCount - 1)
                ? null
                : () {
                    if (tabController == null) return;
                    int i = tabController.index;
                    // button disabeld if last tab.
                    tabController.animateTo(i + 1);
                  },
            child: const Text('Next')),
        ElevatedButton(
            onPressed: (tabIndex == 0)
                ? null
                : () {
                    if (tabController == null) return;
                    int i = tabController.index;
                    // button disabeld if first tab.
                    tabController.animateTo(i - 1);
                  },
            child: const Text('Back')),
      ],
    );
  }
}
