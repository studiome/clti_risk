import 'package:clti_risk/widgets/question_binder.dart';
import 'package:clti_risk/widgets/question_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const int tabCount = 3;

void main() {
  group('Question Binder Test', () {
    late MaterialApp testApp;
    late Finder titleAt0;
    late Finder subtitleAt0;
    late Finder contentAt0;
    late Finder titleAt1;
    late Finder subtitleAt1;
    late Finder contentAt1;
    late Finder titleAt2;
    late Finder subtitleAt2;
    late Finder contentAt2;
    late Finder nextButton;
    late Finder backButton;
    setUp(() {
      testApp = MaterialApp(home: QuestionPagesTestWidget());
      titleAt0 = find.text('Tab0');
      subtitleAt0 = find.text('TabTest0');
      contentAt0 = find.text('Q-0');
      titleAt1 = find.text('Tab1');
      subtitleAt1 = find.text('TabTest1');
      contentAt1 = find.text('Q-1');
      titleAt2 = find.text('Tab2');
      subtitleAt2 = find.text('TabTest2');
      contentAt2 = find.text('Q-2');

      nextButton = find.text('Next');
      backButton = find.text('Back');
    });

    testWidgets('build check', (tester) async {
      await tester.pumpWidget(testApp);
      expect(titleAt0, findsOneWidget);
      expect(subtitleAt0, findsOneWidget);
      expect(contentAt0, findsOneWidget);
      expect(nextButton, findsOneWidget);
      expect(backButton, findsOneWidget);
    });

    testWidgets('back button is disabled at first tab', (tester) async {
      await tester.pumpWidget(testApp);
      await tester.tap(backButton);
      await tester.pumpAndSettle();
      expect(titleAt0, findsOneWidget);
      expect(subtitleAt0, findsOneWidget);
      expect(contentAt0, findsOneWidget);
    });

    testWidgets('go to next', (tester) async {
      await tester.pumpWidget(testApp);
      await tester.tap(nextButton);
      await tester.pumpAndSettle();
      expect(titleAt1, findsOneWidget);
      expect(subtitleAt1, findsOneWidget);
      expect(contentAt1, findsOneWidget);
    });

    testWidgets('next button is disabled at last tab', (tester) async {
      await tester.pumpWidget(testApp);
      await tester.tap(nextButton);
      await tester.pumpAndSettle(); // Tab1
      await tester.tap(nextButton);
      await tester.pumpAndSettle(); // Tab 2
      await tester.tap(nextButton);
      await tester.pumpAndSettle();
      expect(titleAt2, findsOneWidget);
      expect(subtitleAt2, findsOneWidget);
      expect(contentAt2, findsOneWidget);
    });

    testWidgets('go back', (tester) async {
      await tester.pumpWidget(testApp);
      await tester.tap(nextButton);
      await tester.pumpAndSettle();
      await tester.tap(backButton);
      await tester.pumpAndSettle();
      expect(titleAt0, findsOneWidget);
      expect(subtitleAt0, findsOneWidget);
      expect(contentAt0, findsOneWidget);
    });
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
      actionButton: TextButton(
        child: const Text('test'),
        onPressed: () {},
      ),
      questionPages: _pages,
    );
  }
}
