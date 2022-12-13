import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'clinical_data_controller.dart';
import '../models/questions.dart';
import 'question_page.dart';

class WeightQuestionPage extends StatelessWidget {
  final TextEditingController controller;
  const WeightQuestionPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final c = ClinicalDataController.of(context);
    if (c == null) throw NullThrownError();
    controller.text =
        c.patientData.weight == null ? '' : c.patientData.weight.toString();
    return NumberFormQuestionContent(
        title: AppLocalizations.of(context).questionWeightTitle,
        subtitle: AppLocalizations.of(context).questionWeightSubtitle,
        formController: controller,
        isDecimal: true,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'^\d{1,3}\.?\d{0,1}')),
        ],
        onSubmitted: (v) {
          try {
            c.patientData.weight = double.parse(v);
          } catch (e) {
            c.patientData.weight = null;
          }
        },
        itemWidth: 240,
        itemHeight: 80,
        tabIndex: Questions.weight.index,
        tabCount: Questions.values.length);
  }
}
