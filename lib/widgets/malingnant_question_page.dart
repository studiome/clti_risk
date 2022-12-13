import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'clinical_data_controller.dart';
import '../models/patient_data.dart';
import '../models/questions.dart';
import 'question_page.dart';

class MalignantQuestionPage extends StatefulWidget {
  const MalignantQuestionPage({super.key});

  @override
  State<MalignantQuestionPage> createState() => _MalignantQuestionPageState();
}

class _MalignantQuestionPageState extends State<MalignantQuestionPage> {
  @override
  Widget build(BuildContext context) {
    final c = ClinicalDataController.of(context);
    if (c == null) throw NullThrownError();
    return MultipleQuestionPage<MalignantNeoplasm>(
      subtitle: AppLocalizations.of(context).questionMalignantSubtitle,
      values: MalignantNeoplasm.values,
      dataItem: c.patientData.malignant,
      itemWidth: 240.0,
      itemHeight: 48.0,
      tabIndex: Questions.malignantNeoplasm.index,
      tabCount: Questions.values.length,
      onChanged: (v) {
        if (v == null) return;
        setState(() {
          c.patientData.malignant = v;
        });
      },
    );
  }
}
