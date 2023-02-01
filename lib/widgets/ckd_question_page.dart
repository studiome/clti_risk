import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/patient_data.dart';
import '../models/questions.dart';
import 'clinical_data_controller.dart';
import 'internal/question_page.dart';

class CKDQuestionPage extends StatefulWidget {
  const CKDQuestionPage({super.key});

  @override
  State<CKDQuestionPage> createState() => _CKDQuestionPageState();
}

class _CKDQuestionPageState extends State<CKDQuestionPage> {
  @override
  Widget build(BuildContext context) {
    final c = ClinicalDataController.of(context);
    if (c == null) throw TypeError();
    return MultipleQuestionPage<CKD>(
      subtitle: AppLocalizations.of(context).questionCKDSubtitle,
      values: CKD.values,
      dataItem: c.patientData.ckd,
      itemWidth: 160.0,
      itemHeight: 48.0,
      tabIndex: Questions.ckd.index,
      tabCount: Questions.values.length,
      onChanged: (v) {
        if (v == null) return;
        setState(() {
          c.patientData.ckd = v;
        });
      },
    );
  }
}
