import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/question_details.dart' as detail;
import '../models/questions.dart';
import 'question_page.dart';

class MultipleQuestionContent<T extends Enum> extends StatelessWidget {
  final List<T> values;
  final T dataItem;
  final int tabIndex;
  final int tabCount;
  final double itemWidth;
  final double itemHeight;
  final Questions question;
  final void Function(T?)? onChanged;
  const MultipleQuestionContent(
      {super.key,
      required this.question,
      required this.dataItem,
      required this.values,
      required this.tabIndex,
      required this.tabCount,
      required this.itemWidth,
      required this.itemHeight,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final Widget content =
        _createContent(values, dataItem, itemWidth, itemHeight, context);
    final d = detail.questionDetail[question];
    if (d == null) throw NullThrownError();
    final String? subtitle = d[detail.Description.subtitle];
    if (subtitle == null) throw NullThrownError();
    return QuestionPage(
        content: content,
        subtitle: subtitle,
        tabIndex: tabIndex,
        tabCount: tabCount);
  }

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
            onChanged: onChanged,
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
}

class NumberFormQuestionContent extends StatelessWidget {
  final Questions question;
  final int tabIndex;
  final int tabCount;
  final bool isDecimal;
  final List<TextInputFormatter> inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String)? onSubmitted;
  final double itemWidth;
  final double itemHeight;
  final Function? onNext;
  final Function? onBack;
  final TextEditingController formController;

  const NumberFormQuestionContent(
      {super.key,
      required this.question,
      required this.formController,
      required this.isDecimal,
      required this.inputFormatters,
      required this.validator,
      required this.onSubmitted,
      required this.itemWidth,
      required this.itemHeight,
      required this.tabIndex,
      required this.tabCount,
      this.onNext,
      this.onBack});

  @override
  Widget build(BuildContext context) {
    final d = detail.questionDetail[question];
    if (d == null) throw NullThrownError();

    final String? subtitle = d[detail.Description.subtitle];
    if (subtitle == null) throw NullThrownError();

    final String? label = d[detail.Description.title];

    Widget content = _createContent(
      width: itemWidth,
      height: itemHeight,
      hint: subtitle,
      label: label,
      decimal: isDecimal,
      inputFormatters: inputFormatters,
      validator: validator,
      onSubmitted: onSubmitted,
    );
    return QuestionPage(
      content: content,
      subtitle: subtitle,
      tabIndex: tabIndex,
      tabCount: tabCount,
      onNext: onNext,
      onBack: onBack,
    );
  }

  Widget _createContent({
    required double width,
    required double height,
    String? hint,
    String? label,
    bool? decimal,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    void Function(String)? onSubmitted,
  }) {
    return Form(
      child: SizedBox(
          width: width,
          height: height,
          child: TextFormField(
            controller: formController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: hint,
              labelText: label,
            ),
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.numberWithOptions(
              signed: false,
              decimal: decimal,
            ),
            inputFormatters: inputFormatters,
            autovalidateMode: AutovalidateMode.always,
            validator: validator,
            onFieldSubmitted: onSubmitted,
          )),
    );
  }
}
