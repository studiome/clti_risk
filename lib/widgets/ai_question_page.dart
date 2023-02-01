import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/questions.dart';
import '../models/yes_no.dart';
import 'clinical_data_controller.dart';
import 'internal/question_page.dart';

class LesionAIQuestionPage extends StatefulWidget {
  const LesionAIQuestionPage({super.key});

  @override
  State<LesionAIQuestionPage> createState() => _LesionAIQuestionPageState();
}

class _LesionAIQuestionPageState extends State<LesionAIQuestionPage> {
  @override
  Widget build(BuildContext context) {
    final c = ClinicalDataController.of(context);
    if (c == null) throw TypeError();
    return MultipleQuestionPage<YesNo>(
      subtitle: AppLocalizations.of(context).questionAILesionSubtitle,
      values: YesNo.values,
      dataItem: c.patientData.hasAILesion.toYesNo(),
      itemWidth: 160.0,
      itemHeight: 48.0,
      tabIndex: Questions.lesionAI.index,
      tabCount: Questions.values.length,
      onChanged: (v) {
        if (v == null) return;
        setState(() {
          c.patientData.hasAILesion = v.toBool();
        });
      },
    );
  }
}
