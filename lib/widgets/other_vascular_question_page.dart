import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/questions.dart';
import '../models/yes_no.dart';
import 'clinical_data_controller.dart';
import 'internal/question_page.dart';

class OtherVDQuestionPage extends StatefulWidget {
  const OtherVDQuestionPage({super.key});

  @override
  State<OtherVDQuestionPage> createState() => _OtherVDQuestionPageState();
}

class _OtherVDQuestionPageState extends State<OtherVDQuestionPage> {
  @override
  Widget build(BuildContext context) {
    final c = ClinicalDataController.of(context);
    if (c == null) throw TypeError();
    return MultipleQuestionPage<YesNo>(
      subtitle: AppLocalizations.of(context).questionOtherLesionSubtitle,
      values: YesNo.values,
      dataItem: c.patientData.hasOtherVD.toYesNo(),
      itemWidth: 160.0,
      itemHeight: 48.0,
      tabIndex: Questions.others.index,
      tabCount: Questions.values.length,
      onChanged: (v) {
        if (v == null) return;
        setState(() {
          c.patientData.hasOtherVD = v.toBool();
        });
      },
    );
  }
}
