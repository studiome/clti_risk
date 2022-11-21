import 'package:clti_risk/widgets/tab_transition_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const initialTab = 5;
const tabCount = 10;

void main() {
  testWidgets('Build Check', (tester) async {
    await tester.pumpWidget(const TabTestApp());
    final nextButton = find.text('Next');
    final backButton = find.text('Back');
    final initialTabView = find.text('TabView$initialTab');
    expect(initialTabView, findsOneWidget);
    expect(nextButton, findsOneWidget);
    expect(backButton, findsOneWidget);
  });

  testWidgets('Next Tab', (tester) async {
    await tester.pumpWidget(const TabTestApp());
    final nextButton = find.text('Next');
    final initialTabView = find.text('TabView$initialTab');
    final nextTabView = find.text('TabView${initialTab + 1}');
    await tester.tap(nextButton);
    await tester.pumpAndSettle();
    expect(initialTabView, findsNothing);
    expect(nextTabView, findsOneWidget);
  });

  testWidgets('Previous Tab', (tester) async {
    await tester.pumpWidget(const TabTestApp());
    final backButton = find.text('Back');
    final initialTabView = find.text('TabView$initialTab');
    final previousTabView = find.text('TabView${initialTab - 1}');
    await tester.tap(backButton);
    await tester.pumpAndSettle();
    expect(initialTabView, findsNothing);
    expect(previousTabView, findsOneWidget);
  });
}

class TabTestWidget extends StatelessWidget {
  const TabTestWidget({super.key});

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
            tabCount: tabCount,
            tabIndex: i,
          ),
        ],
      ));
    }
    return tabPages;
  }
}

class TabTestApp extends StatelessWidget {
  const TabTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: TabTestWidget());
  }
}
