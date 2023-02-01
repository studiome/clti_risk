import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/questions.dart';
import '../models/yes_no.dart';
import 'clinical_data_controller.dart';
import 'internal/question_page.dart';

class UrgentQuestionPage extends StatefulWidget {
  const UrgentQuestionPage({super.key});

  @override
  State<UrgentQuestionPage> createState() => _UrgentQuestionPageState();
}

class _UrgentQuestionPageState extends State<UrgentQuestionPage> {
  @override
  Widget build(BuildContext context) {
    final c = ClinicalDataController.of(context);
    if (c == null) throw TypeError();
    return MultipleQuestionPage<YesNo>(
      subtitle: AppLocalizations.of(context).questionUrgentSubtitle,
      values: YesNo.values,
      dataItem: c.patientData.isUrgent.toYesNo(),
      itemWidth: 160.0,
      itemHeight: 48.0,
      tabIndex: Questions.urgentProcedure.index,
      tabCount: Questions.values.length,
      onChanged: (v) {
        if (v == null) return;
        setState(() {
          c.patientData.isUrgent = v.toBool();
        });
      },
    );
  }
}
