import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/questions.dart';
import '../models/yes_no.dart';
import 'clinical_data_controller.dart';
import 'question_page.dart';

class ContraLateralQuestionPage extends StatefulWidget {
  const ContraLateralQuestionPage({super.key});

  @override
  State<ContraLateralQuestionPage> createState() =>
      _ContraLateralQuestionPageState();
}

class _ContraLateralQuestionPageState extends State<ContraLateralQuestionPage> {
  @override
  Widget build(BuildContext context) {
    final c = ClinicalDataController.of(context);
    if (c == null) throw TypeError();
    return MultipleQuestionPage<YesNo>(
      subtitle: AppLocalizations.of(context).questionContraSubtitle,
      values: YesNo.values,
      dataItem: c.patientData.hasContraLateralLesion.toYesNo(),
      itemWidth: 160.0,
      itemHeight: 48.0,
      tabIndex: Questions.contralateral.index,
      tabCount: Questions.values.length,
      onChanged: (v) {
        if (v == null) return;
        setState(() {
          c.patientData.hasContraLateralLesion = v.toBool();
        });
      },
    );
  }
}
