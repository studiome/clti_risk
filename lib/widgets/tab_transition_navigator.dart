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
        OutlinedButton(
            onPressed: (tabIndex == 0)
                ? null
                : () {
                    if (tabController == null) return;
                    int i = tabController.index;
                    // button disabeld if first tab.
                    tabController.animateTo(i - 1);
                  },
            child: const Text('Back')),
        OutlinedButton(
            style: OutlinedButton.styleFrom(
                side: BorderSide.none,
                backgroundColor:
                    Theme.of(context).colorScheme.secondaryContainer,
                foregroundColor:
                    Theme.of(context).colorScheme.onSecondaryContainer,
                shadowColor: Theme.of(context).colorScheme.shadow,
                disabledBackgroundColor:
                    Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
                disabledForegroundColor:
                    Theme.of(context).colorScheme.onSurface.withOpacity(0.38)),
            onPressed: (tabIndex == tabCount - 1)
                ? null
                : () {
                    if (tabController == null) return;
                    int i = tabController.index;
                    // button disabeld if last tab.
                    tabController.animateTo(i + 1);
                  },
            child: const Text('Next')),
      ],
    );
  }
}
