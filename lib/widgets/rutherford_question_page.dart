import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/patient_data.dart';
import '../models/questions.dart';
import 'clinical_data_controller.dart';
import 'question_page.dart';

class RutherfordQuestionPage extends StatefulWidget {
  const RutherfordQuestionPage({super.key});

  @override
  State<RutherfordQuestionPage> createState() => _RutherfordQuestionPageState();
}

class _RutherfordQuestionPageState extends State<RutherfordQuestionPage> {
  @override
  Widget build(BuildContext context) {
    final c = ClinicalDataController.of(context);
    if (c == null) throw TypeError();
    return MultipleQuestionPage<RutherfordClassification>(
      subtitle: AppLocalizations.of(context)!.questionRutherfordSubtitle,
      values: RutherfordClassification.values,
      dataItem: c.patientData.rutherford,
      itemWidth: 160.0,
      itemHeight: 48.0,
      tabIndex: Questions.rutherford.index,
      tabCount: Questions.values.length,
      onChanged: (v) {
        if (v == null) return;
        setState(() {
          c.patientData.rutherford = v;
        });
      },
    );
  }
}
