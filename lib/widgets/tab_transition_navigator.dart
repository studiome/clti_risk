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
        // my filled tonal button. Switch offical widget if implemented.
        ElevatedButton(
            style: ButtonStyle(
                elevation: MaterialStateProperty.resolveWith<double?>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.disabled)) return 0.0;
                  if (states.contains(MaterialState.hovered)) return 1.0;
                  if (states.contains(MaterialState.focused)) return 0.0;
                  if (states.contains(MaterialState.pressed)) return 0.0;
                  return 0.0;
                }),
                backgroundColor:
                    MaterialStateProperty.resolveWith<Color?>((states) {
                  final bgColor =
                      Theme.of(context).colorScheme.secondaryContainer;
                  if (states.contains(MaterialState.disabled)) {
                    return bgColor.withOpacity(0.12);
                  }
                  return bgColor;
                }),
                foregroundColor:
                    MaterialStateProperty.resolveWith<Color?>((states) {
                  final fgColor =
                      Theme.of(context).colorScheme.onSecondaryContainer;
                  if (states.contains(MaterialState.disabled)) {
                    return fgColor.withOpacity(0.38);
                  }
                  return fgColor;
                }),
                overlayColor:
                    MaterialStateProperty.resolveWith<Color?>((states) {
                  final fgColor =
                      Theme.of(context).colorScheme.onSecondaryContainer;
                  if (states.contains(MaterialState.hovered)) {
                    return fgColor.withOpacity(0.08);
                  }
                  if (states.contains(MaterialState.focused)) {
                    return fgColor.withOpacity(0.12);
                  }
                  if (states.contains(MaterialState.pressed)) {
                    return fgColor.withOpacity(0.12);
                  }
                  return null;
                }),
                shadowColor: MaterialStateProperty.resolveWith<Color?>(
                    (states) => Theme.of(context).colorScheme.shadow)),
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
