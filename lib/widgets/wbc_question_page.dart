import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/questions.dart';
import '../models/yes_no.dart';
import 'clinical_data_controller.dart';
import 'question_page.dart';

class AbnormalWBCQuestionPage extends StatefulWidget {
  const AbnormalWBCQuestionPage({super.key});

  @override
  State<AbnormalWBCQuestionPage> createState() =>
      _AbnormalWBCQuestionPageState();
}

class _AbnormalWBCQuestionPageState extends State<AbnormalWBCQuestionPage> {
  @override
  Widget build(BuildContext context) {
    final c = ClinicalDataController.of(context);
    if (c == null) throw TypeError();
    return MultipleQuestionPage<YesNo>(
      subtitle: AppLocalizations.of(context).questionAbnormalWBCSubtitle,
      values: YesNo.values,
      dataItem: c.patientData.hasAbnormalWBC.toYesNo(),
      itemWidth: 160.0,
      itemHeight: 48.0,
      tabIndex: Questions.abnormalWBC.index,
      tabCount: Questions.values.length,
      onChanged: (v) {
        if (v == null) return;
        setState(() {
          c.patientData.hasAbnormalWBC = v.toBool();
        });
      },
    );
  }
}
