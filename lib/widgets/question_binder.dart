import 'package:flutter/material.dart';

class QuestionPageDetail {
  String tabBarTitle;
  int tabIndex;
  Widget page;
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
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(title),
          bottom: TabBar(
            indicatorColor: Theme.of(context).colorScheme.primary,
            labelColor: Theme.of(context).colorScheme.primary,
            unselectedLabelColor:
                Theme.of(context).colorScheme.onSurfaceVariant,
            tabs: questionPages.map((e) {
              return Tab(
                  child: Center(
                      child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 240, maxHeight: 80),
                child: Text(
                  e.tabBarTitle,
                  softWrap: true,
                  maxLines: 3,
                ),
              )));
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
