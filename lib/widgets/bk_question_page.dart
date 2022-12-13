import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'clinical_data_controller.dart';
import '../models/questions.dart';
import '../models/yes_no.dart';
import 'question_page.dart';

class LesionBKQuestionPage extends StatefulWidget {
  const LesionBKQuestionPage({super.key});

  @override
  State<LesionBKQuestionPage> createState() => _LesionBKQuestionPageState();
}

class _LesionBKQuestionPageState extends State<LesionBKQuestionPage> {
  @override
  Widget build(BuildContext context) {
    final c = ClinicalDataController.of(context);
    if (c == null) throw NullThrownError();
    return MultipleQuestionPage<YesNo>(
      subtitle: AppLocalizations.of(context).questionBKLesionSubtitle,
      values: YesNo.values,
      dataItem: c.patientData.hasBKLesion.toYesNo(),
      itemWidth: 160.0,
      itemHeight: 48.0,
      tabIndex: Questions.lesionBK.index,
      tabCount: Questions.values.length,
      onChanged: (v) {
        if (v == null) return;
        setState(() {
          c.patientData.hasBKLesion = v.toBool();
        });
      },
    );
  }
}
