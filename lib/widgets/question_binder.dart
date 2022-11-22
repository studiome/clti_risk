import 'package:clti_risk/widgets/question_page.dart';
import 'package:flutter/material.dart';

class QuestionPageDetail {
  String tabBarTitle;
  int tabIndex;
  QuestionPage page;
  QuestionPageDetail(
      {required this.tabBarTitle, required this.tabIndex, required this.page});
}

class QuestionBinder extends StatelessWidget {
  final String title;
  final List<QuestionPageDetail> questionPages;
  final int _tabCount;

  const QuestionBinder({
    super.key,
    required this.title,
    required this.questionPages,
  }) : _tabCount = questionPages.length;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabCount,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          bottom: TabBar(
            indicatorColor: Theme.of(context).colorScheme.primary,
            labelColor: Theme.of(context).colorScheme.primary,
            tabs: questionPages.map((e) {
              return Tab(text: e.tabBarTitle);
            }).toList(),
            isScrollable: true,
          ),
        ),
        body: SafeArea(
          bottom: false,
          child: TabBarView(
            children: questionPages.map((e) => e.page).toList(),
          ),
        ),
      ),
    );
  }
}
