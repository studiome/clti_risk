import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TabTransitionNavigator extends StatelessWidget {
  final int tabIndex; //[0 .. tabCount-1]
  final int tabCount;
  final Function? onNext;
  final Function? onBack;
  const TabTransitionNavigator(
      {super.key,
      required this.tabIndex,
      required this.tabCount,
      this.onNext,
      this.onBack});

  @override
  Widget build(BuildContext context) {
    final TabController tabController = DefaultTabController.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        OutlinedButton(
            onPressed: (tabIndex == 0)
                ? null
                : () {
                    //user defined function
                    if (onBack != null) {
                      try {
                        onBack!.call();
                      } catch (e) {
                        if (kDebugMode) print(e);
                      }
                    }
                    int i = tabController.index;
                    // button disabeld if first tab.
                    tabController.animateTo(i - 1);
                  },
            child: Text(AppLocalizations.of(context).backButton)),
        FilledButton.tonal(
            onPressed: (tabIndex == tabCount - 1)
                ? null
                : () {
                    //user defined function
                    //if thorows exception, DO NOT Move to next tab;
                    if (onNext != null) {
                      try {
                        onNext!.call();
                      } on FormatException catch (_) {
                        //DO NOTHING
                        return;
                      } catch (e) {
                        if (kDebugMode) print(e);
                      }
                    }

                    int i = tabController.index;
                    // button disabeld if last tab.
                    tabController.animateTo(i + 1);
                  },
            child: Text(AppLocalizations.of(context).nextButton)),
      ],
    );
  }
}
