import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'clinical_data_controller.dart';
import '../models/questions.dart';
import '../models/yes_no.dart';
import 'question_page.dart';

class LesionFPQuestionPage extends StatefulWidget {
  const LesionFPQuestionPage({super.key});

  @override
  State<LesionFPQuestionPage> createState() => _LesionFPQuestionPageState();
}

class _LesionFPQuestionPageState extends State<LesionFPQuestionPage> {
  @override
  Widget build(BuildContext context) {
    final c = ClinicalDataController.of(context);
    if (c == null) throw NullThrownError();
    return MultipleQuestionPage<YesNo>(
      subtitle: AppLocalizations.of(context).questionFPLesionSubtitle,
      values: YesNo.values,
      dataItem: c.patientData.hasFPLesion.toYesNo(),
      itemWidth: 160.0,
      itemHeight: 48.0,
      tabIndex: Questions.lesionFP.index,
      tabCount: Questions.values.length,
      onChanged: (v) {
        if (v == null) return;
        setState(() {
          c.patientData.hasFPLesion = v.toBool();
        });
      },
    );
  }
}
