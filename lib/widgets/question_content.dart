import 'package:flutter/material.dart';

import '../models/question_details.dart' as detail;
import '../models/questions.dart';
import 'question_page.dart';

class MultipleQuestionContent<T extends Enum> extends StatefulWidget {
  final List<T> values;
  final T dataItem;
  final int tabIndex;
  final int tabCount;
  final double itemWidth;
  final double itemHeight;
  final Questions question;
  const MultipleQuestionContent(
      {super.key,
      required this.question,
      required this.dataItem,
      required this.values,
      required this.tabIndex,
      required this.tabCount,
      required this.itemWidth,
      required this.itemHeight});

  @override
  State<MultipleQuestionContent<T>> createState() =>
      _MultipleQuestionContentState<T>();
}

class _MultipleQuestionContentState<T extends Enum>
    extends State<MultipleQuestionContent<T>> {
  Widget _createContent(List<T> values, T dataItem, double itemWidth,
      double itemHeight, BuildContext context) {
    final itemLength = values.length;
    List<Widget> choices = <Widget>[];
    for (int i = 0; i < itemLength; i++) {
      choices.add(SizedBox(
          width: itemWidth,
          height: itemHeight,
          child: RadioListTile<T>(
            title: Text(values[i].toString()),
            value: values[i],
            groupValue: dataItem,
            onChanged: (v) {
              if (v == null) return;
              setState(() {
                dataItem = v;
              });
            },
          )));
    }
    return LayoutBuilder(builder: (context, constrains) {
      if (constrains.maxWidth < 600) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: choices,
          ),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: choices,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Widget content = _createContent(widget.values, widget.dataItem,
        widget.itemWidth, widget.itemHeight, context);
    final String subtitle;
    var d = detail.questionDetail[widget.question];
    if (d == null) {
      subtitle = '';
    } else {
      subtitle = d[detail.Description.subtitle] ?? '';
    }
    return QuestionPage(
        content: content,
        subtitle: subtitle,
        tabIndex: widget.tabIndex,
        tabCount: widget.tabCount);
  }
}
