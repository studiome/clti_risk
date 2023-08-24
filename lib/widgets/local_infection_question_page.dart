import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/questions.dart';
import '../models/yes_no.dart';
import 'clinical_data_controller.dart';
import 'question_page.dart';

class LocalInfectionQuestionPage extends StatefulWidget {
  const LocalInfectionQuestionPage({super.key});

  @override
  State<LocalInfectionQuestionPage> createState() =>
      _LocalInfectionQuestionPageState();
}

class _LocalInfectionQuestionPageState
    extends State<LocalInfectionQuestionPage> {
  @override
  Widget build(BuildContext context) {
    final c = ClinicalDataController.of(context);
    if (c == null) throw TypeError();
    return MultipleQuestionPage<YesNo>(
      subtitle: AppLocalizations.of(context)!.questionLocalInfectionSubtitle,
      values: YesNo.values,
      dataItem: c.patientData.hasLocalInfection.toYesNo(),
      itemWidth: 160.0,
      itemHeight: 48.0,
      tabIndex: Questions.localInfection.index,
      tabCount: Questions.values.length,
      onChanged: (v) {
        if (v == null) return;
        setState(() {
          c.patientData.hasLocalInfection = v.toBool();
        });
      },
    );
  }
}
