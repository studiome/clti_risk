import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/questions.dart';
import 'clinical_data_controller.dart';
import 'question_page.dart';

class AgeQuestionPage extends StatelessWidget {
  final TextEditingController controller;
  const AgeQuestionPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final c = ClinicalDataController.of(context);
    if (c == null) throw TypeError();
    controller.text =
        c.patientData.age == null ? '' : c.patientData.age.toString();
    return NumberFormQuestionContent(
        title: AppLocalizations.of(context)!.questionAgeTitle,
        subtitle: AppLocalizations.of(context)!.questionAgeSubtitle,
        formController: controller,
        isDecimal: false,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
        onSubmitted: (v) {
          try {
            c.patientData.age = int.parse(v);
          } catch (e) {
            c.patientData.age = null;
          }
        },
        itemWidth: 240,
        itemHeight: 80,
        tabIndex: Questions.age.index,
        tabCount: Questions.values.length);
  }
}
