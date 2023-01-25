import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/questions.dart';
import '../models/yes_no.dart';
import 'clinical_data_controller.dart';
import 'question_page.dart';

class SmokingQuestionPage extends StatefulWidget {
  const SmokingQuestionPage({super.key});

  @override
  State<SmokingQuestionPage> createState() => _SmokingQuestionPageState();
}

class _SmokingQuestionPageState extends State<SmokingQuestionPage> {
  @override
  Widget build(BuildContext context) {
    final c = ClinicalDataController.of(context);
    if (c == null) throw TypeError();
    return MultipleQuestionPage<YesNo>(
      subtitle: AppLocalizations.of(context).questionSmokingSubtitle,
      values: YesNo.values,
      dataItem: c.patientData.isSmoking.toYesNo(),
      itemWidth: 160.0,
      itemHeight: 48.0,
      tabIndex: Questions.smoking.index,
      tabCount: Questions.values.length,
      onChanged: (v) {
        if (v == null) return;
        setState(() {
          c.patientData.isSmoking = v.toBool();
        });
      },
    );
  }
}
