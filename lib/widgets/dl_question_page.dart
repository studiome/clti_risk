import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/questions.dart';
import '../models/yes_no.dart';
import 'clinical_data_controller.dart';
import 'question_page.dart';

class DLQuestionPage extends StatefulWidget {
  const DLQuestionPage({super.key});

  @override
  State<DLQuestionPage> createState() => _DLQuestionPageState();
}

class _DLQuestionPageState extends State<DLQuestionPage> {
  @override
  Widget build(BuildContext context) {
    final c = ClinicalDataController.of(context);
    if (c == null) throw TypeError();
    return MultipleQuestionPage<YesNo>(
      subtitle: AppLocalizations.of(context).questionDLSubtitle,
      values: YesNo.values,
      dataItem: c.patientData.hasDyslipidemia.toYesNo(),
      itemWidth: 160.0,
      itemHeight: 48.0,
      tabIndex: Questions.dyslipidemia.index,
      tabCount: Questions.values.length,
      onChanged: (v) {
        if (v == null) return;
        setState(() {
          c.patientData.hasDyslipidemia = v.toBool();
        });
      },
    );
  }
}
