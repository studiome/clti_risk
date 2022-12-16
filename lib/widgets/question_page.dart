import 'package:clti_risk/widgets/label_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'tab_transition_navigator.dart';

class QuestionPage extends StatelessWidget {
  final int tabIndex;
  final int tabCount;
  final Widget content;
  final String subtitle;
  final Function? onNext;
  final Function? onBack;
  const QuestionPage(
      {super.key,
      required this.content,
      required this.subtitle,
      required this.tabIndex,
      required this.tabCount,
      this.onNext,
      this.onBack});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
              child: Text(subtitle)),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: content),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TabTransitionNavigator(
              tabIndex: tabIndex,
              tabCount: tabCount,
              onNext: onNext,
              onBack: onBack,
            ),
          ),
        ],
      ),
    );
  }
}

class MultipleQuestionPage<T extends Enum> extends StatelessWidget {
  final List<T> values;
  final T dataItem;
  final int tabIndex;
  final int tabCount;
  final double itemWidth;
  final double itemHeight;
  final String subtitle;
  final void Function(T?)? onChanged;
  const MultipleQuestionPage(
      {super.key,
      required this.subtitle,
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
            title:
                Text(LabelBuilder<T>(context: context, item: values[i]).text),
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

class NumberFormQuestionContent extends StatefulWidget {
  final String title;
  final String subtitle;
  final int tabIndex;
  final int tabCount;
  final bool isDecimal;
  final List<TextInputFormatter> inputFormatters;
  final void Function(String)? onSubmitted;
  final double itemWidth;
  final double itemHeight;
  final TextEditingController formController;

  const NumberFormQuestionContent({
    super.key,
    required this.title,
    required this.subtitle,
    required this.formController,
    required this.isDecimal,
    required this.inputFormatters,
    required this.onSubmitted,
    required this.itemWidth,
    required this.itemHeight,
    required this.tabIndex,
    required this.tabCount,
  });

  @override
  State<NumberFormQuestionContent> createState() =>
      _NumberFormQuestionContentState();
}

class _NumberFormQuestionContentState extends State<NumberFormQuestionContent> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    final tabController = DefaultTabController.of(context);
    if (tabController != null) {
      tabController.addListener(() {
        if (widget.onSubmitted != null) {
          widget.onSubmitted!(widget.formController.text);
        }
        _focusNode.unfocus();
      });
    }
    Widget content = _createContent(
      width: widget.itemWidth,
      height: widget.itemHeight,
      hint: widget.subtitle,
      label: widget.title,
      decimal: widget.isDecimal,
      inputFormatters: widget.inputFormatters,
      validator: (v) {
        if (v == null || v.isEmpty) {
          return AppLocalizations.of(context).formErrorMessage;
        }
        return null;
      },
      onSubmitted: widget.onSubmitted,
    );
    return QuestionPage(
      content: content,
      subtitle: widget.subtitle,
      tabIndex: widget.tabIndex,
      tabCount: widget.tabCount,
      onNext: () {
        if (formKey.currentState == null || !formKey.currentState!.validate()) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(AppLocalizations.of(context).invalidValueMessage),
            action: SnackBarAction(
                textColor: Theme.of(context).colorScheme.onSecondary,
                label: AppLocalizations.of(context).ok,
                onPressed: () =>
                    ScaffoldMessenger.of(context).hideCurrentSnackBar()),
          ));
          throw const FormatException('invalid value');
        }
        if (widget.onSubmitted != null) {
          widget.onSubmitted!(widget.formController.text);
        }
        _focusNode.unfocus();
      },
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
      key: formKey,
      child: SizedBox(
          width: width,
          height: height,
          child: TextFormField(
            controller: widget.formController,
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
            focusNode: _focusNode,
          )),
    );
  }
}
