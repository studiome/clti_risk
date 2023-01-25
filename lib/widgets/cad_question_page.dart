import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/questions.dart';
import '../models/yes_no.dart';
import 'clinical_data_controller.dart';
import 'question_page.dart';

class CADQuestionPage extends StatefulWidget {
  const CADQuestionPage({super.key});

  @override
  State<CADQuestionPage> createState() => _CADQuestionPageState();
}

class _CADQuestionPageState extends State<CADQuestionPage> {
  @override
  Widget build(BuildContext context) {
    final c = ClinicalDataController.of(context);
    if (c == null) throw TypeError();
    return MultipleQuestionPage<YesNo>(
      subtitle: AppLocalizations.of(context).questionCADSubtitle,
      values: YesNo.values,
      dataItem: c.patientData.hasCAD.toYesNo(),
      itemWidth: 160.0,
      itemHeight: 48.0,
      tabIndex: Questions.cad.index,
      tabCount: Questions.values.length,
      onChanged: (v) {
        if (v == null) return;
        setState(() {
          c.patientData.hasCAD = v.toBool();
        });
      },
    );
  }
}
