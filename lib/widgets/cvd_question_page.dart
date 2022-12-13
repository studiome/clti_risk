import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/clinical_data_controller.dart';
import '../models/questions.dart';
import '../models/yes_no.dart';
import 'question_page.dart';

class CVDQuestionPage extends StatefulWidget {
  const CVDQuestionPage({super.key});

  @override
  State<CVDQuestionPage> createState() => _CVDQuestionPageState();
}

class _CVDQuestionPageState extends State<CVDQuestionPage> {
  @override
  Widget build(BuildContext context) {
    final c = ClinicalDataController.of(context);
    if (c == null) throw NullThrownError();
    return MultipleQuestionPage<YesNo>(
      subtitle: AppLocalizations.of(context).questionCVDSubtitle,
      values: YesNo.values,
      dataItem: c.patientData.hasCVD.toYesNo(),
      itemWidth: 160.0,
      itemHeight: 48.0,
      tabIndex: Questions.cvd.index,
      tabCount: Questions.values.length,
      onChanged: (v) {
        if (v == null) return;
        setState(() {
          c.patientData.hasCVD = v.toBool();
        });
      },
    );
  }
}
