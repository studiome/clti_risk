import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'clinical_data_controller.dart';
import '../models/patient_data.dart';
import '../models/questions.dart';
import 'question_page.dart';

class ActivityQuestionPage extends StatefulWidget {
  const ActivityQuestionPage({super.key});

  @override
  State<ActivityQuestionPage> createState() => _ActivityQuestionPageState();
}

class _ActivityQuestionPageState extends State<ActivityQuestionPage> {
  @override
  Widget build(BuildContext context) {
    final c = ClinicalDataController.of(context);
    if (c == null) throw NullThrownError();
    return MultipleQuestionPage<Activity>(
      subtitle: AppLocalizations.of(context).questionActivitySubtitle,
      values: Activity.values,
      dataItem: c.patientData.activity,
      itemWidth: 180.0,
      itemHeight: 48.0,
      tabIndex: Questions.activity.index,
      tabCount: Questions.values.length,
      onChanged: (v) {
        if (v == null) return;
        setState(() {
          c.patientData.activity = v;
        });
      },
    );
  }
}
