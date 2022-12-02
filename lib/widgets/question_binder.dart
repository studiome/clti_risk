import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

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
  final ButtonStyleButton actionButton;

  const QuestionBinder({
    super.key,
    required this.title,
    required this.questionPages,
    required this.actionButton,
  }) : _tabCount = questionPages.length;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabCount,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(title),
          actions: [
            actionButton,
          ],
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
        drawer: Drawer(
            child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () async {
                final PackageInfo packageInfo =
                    await PackageInfo.fromPlatform();

                showAboutDialog(
                    context: context,
                    applicationName: 'CLiTICAL',
                    applicationVersion: packageInfo.version,
                    applicationLegalese: '2022 Kazuhiro Miyahara');
              },
            )
          ],
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
