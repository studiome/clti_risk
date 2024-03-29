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
  final List<ListTile> drawerListTiles;
  final List<QuestionPageDetail> questionPages;
  final List<Widget>? actions;
  final int _tabCount;
  final FloatingActionButton actionButton;

  const QuestionBinder({
    super.key,
    required this.title,
    required this.questionPages,
    required this.actionButton,
    required this.drawerListTiles,
    this.actions,
  }) : _tabCount = questionPages.length;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabCount,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        floatingActionButton: actionButton,
        appBar: AppBar(
          title: Text(title),
          actions: actions,
          bottom: TabBar(
            tabs: questionPages.map((e) {
              return Tab(
                  child: Center(
                      child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 240, maxHeight: 80),
                child: Text(
                  '${e.tabIndex + 1}. ${e.tabBarTitle}',
                  softWrap: true,
                  maxLines: 3,
                ),
              )));
            }).toList(),
            isScrollable: true,
          ),
        ),
        drawer: Drawer(
            child: ListView(
          children: drawerListTiles,
        )),
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
