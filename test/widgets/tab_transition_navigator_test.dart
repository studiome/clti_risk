import 'package:clti_risk/widgets/tab_transition_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

const initialTab = 1;
const tabCount = 3;

void main() {
  group('Tab Tansition Test', () {
    late List<int> log;
    late MaterialApp testApp;

    setUp(() {
      log = <int>[];
      testApp = MaterialApp(
        home: TabTestWidget(log: log),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        locale: const Locale('en'),
      );
    });

    testWidgets('build check', (tester) async {
      await tester.pumpWidget(testApp);
      final nextButton = find.text('Next');
      final backButton = find.text('Back');
      final initialTabView = find.text('TabView$initialTab');
      expect(initialTabView, findsOneWidget);
      expect(nextButton, findsOneWidget);
      expect(backButton, findsOneWidget);
      expect(log, isEmpty);
    });

    testWidgets('next', (tester) async {
      await tester.pumpWidget(testApp);
      final nextButton = find.text('Next');
      final initialTabView = find.text('TabView$initialTab');
      final nextTabView = find.text('TabView${initialTab + 1}');
      await tester.tap(nextButton);
      await tester.pumpAndSettle();
      expect(initialTabView, findsNothing);
      expect(nextTabView, findsOneWidget);
      expect(log, <int>[1]);
    });

    testWidgets('back', (tester) async {
      await tester.pumpWidget(testApp);
      final backButton = find.text('Back');
      final initialTabView = find.text('TabView$initialTab');
      final previousTabView = find.text('TabView${initialTab - 1}');
      await tester.tap(backButton);
      await tester.pumpAndSettle();
      expect(initialTabView, findsNothing);
      expect(previousTabView, findsOneWidget);
      expect(log, <int>[0]);
    });
  });
}

class TabTestWidget extends StatelessWidget {
  final List<int> log;
  const TabTestWidget({super.key, required this.log});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: initialTab,
        length: tabCount,
        child: Builder(builder: (context) {
          return Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                isScrollable: true,
                tabs: _buildTabBar(),
              ),
            ),
            body: TabBarView(children: _buildTabPage(context)),
          );
        }));
  }

  List<Tab> _buildTabBar() {
    final tabs = <Tab>[];
    for (int i = 0; i < tabCount; i++) {
      tabs.add(Tab(
        text: 'TabBar$i',
      ));
    }
    return tabs;
  }

  List<Widget> _buildTabPage(BuildContext context) {
    final tabPages = <Widget>[];
    for (int i = 0; i < tabCount; i++) {
      tabPages.add(Column(
        children: [
          Text('TabView$i'),
          TabTransitionNavigator(
            onNext: () => log.add(1),
            onBack: () => log.add(0),
            tabCount: tabCount,
            tabIndex: i,
          ),
        ],
      ));
    }
    return tabPages;
  }
}
