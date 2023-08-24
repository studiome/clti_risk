import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/questions.dart';
import 'clinical_data_controller.dart';
import 'question_page.dart';

class HeightQuestionPage extends StatelessWidget {
  final TextEditingController controller;
  const HeightQuestionPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final c = ClinicalDataController.of(context);
    if (c == null) throw TypeError();
    controller.text = c.patientData.height == null
        ? ''
        : (c.patientData.height! * 100.0).toString();

    return NumberFormQuestionContent(
        title: AppLocalizations.of(context)!.questionHeightTitle,
        subtitle: AppLocalizations.of(context)!.questionHeightSubtitle,
        formController: controller,
        isDecimal: true,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'^\d{1,3}\.?\d{0,1}')),
        ],
        onSubmitted: (v) {
          try {
            c.patientData.height = double.parse(v) / 100.0;
          } catch (e) {
            c.patientData.height = null;
          }
        },
        itemWidth: 240,
        itemHeight: 80,
        tabIndex: Questions.height.index,
        tabCount: Questions.values.length);
  }
}
