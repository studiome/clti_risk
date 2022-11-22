import 'package:clti_risk/widgets/question_binder.dart';
import 'package:clti_risk/widgets/question_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const int tabCount = 3;

void main() {
  testWidgets('Build check', (tester) async {
    await tester.pumpWidget(MaterialApp(home: QuestionPagesTestWidget()));
    final title = find.text('Tab0');
    final subtitle = find.text('TabTest0');
    final content = find.text('Q-0');
    final nextButton = find.text('Next');
    final backButton = find.text('Back');
    expect(title, findsOneWidget);
    expect(subtitle, findsOneWidget);
    expect(content, findsOneWidget);
    expect(nextButton, findsOneWidget);
    expect(backButton, findsOneWidget);
  });
  testWidgets('Back is disabled at first tab', (tester) async {
    await tester.pumpWidget(MaterialApp(home: QuestionPagesTestWidget()));
    final title = find.text('Tab0');
    final subtitle = find.text('TabTest0');
    final content = find.text('Q-0');
    final backButton = find.text('Back');
    await tester.tap(backButton);
    await tester.pumpAndSettle();
    expect(title, findsOneWidget);
    expect(subtitle, findsOneWidget);
    expect(content, findsOneWidget);
  });
  testWidgets('Next', (tester) async {
    await tester.pumpWidget(MaterialApp(home: QuestionPagesTestWidget()));
    final nextButton = find.text('Next');
    await tester.tap(nextButton);
    await tester.pumpAndSettle();
    final title = find.text('Tab1');
    final subtitle = find.text('TabTest1');
    final content = find.text('Q-1');
    expect(title, findsOneWidget);
    expect(subtitle, findsOneWidget);
    expect(content, findsOneWidget);
  });
  testWidgets('Next is disabled at last tab', (tester) async {
    await tester.pumpWidget(MaterialApp(home: QuestionPagesTestWidget()));
    final nextButton = find.text('Next');
    await tester.tap(nextButton);
    await tester.pumpAndSettle(); // Tab1
    await tester.tap(nextButton);
    await tester.pumpAndSettle(); // Tab 2
    await tester.tap(nextButton);
    await tester.pumpAndSettle();
    final title = find.text('Tab2');
    final subtitle = find.text('TabTest2');
    final content = find.text('Q-2');
    expect(title, findsOneWidget);
    expect(subtitle, findsOneWidget);
    expect(content, findsOneWidget);
  });
  testWidgets('Go and Back', (tester) async {
    await tester.pumpWidget(MaterialApp(home: QuestionPagesTestWidget()));
    final nextButton = find.text('Next');
    final backButton = find.text('Back');
    await tester.tap(nextButton);
    await tester.pumpAndSettle();
    await tester.tap(backButton);
    await tester.pumpAndSettle();
    final title = find.text('Tab0');
    final subtitle = find.text('TabTest0');
    final content = find.text('Q-0');
    expect(title, findsOneWidget);
    expect(subtitle, findsOneWidget);
    expect(content, findsOneWidget);
  });
}

class QuestionPagesTestWidget extends StatelessWidget {
  final List<QuestionPageDetail> _pages =
      List<QuestionPageDetail>.generate(tabCount, (int index) {
    return QuestionPageDetail(
        tabIndex: index,
        tabBarTitle: 'Tab$index',
        page: QuestionPage(
          tabIndex: index,
          tabCount: tabCount,
          subtitle: 'TabTest$index',
          content: Text('Q-$index'),
        ));
  });
  QuestionPagesTestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return QuestionBinder(
      title: 'test',
      questionPages: _pages,
    );
  }
}
