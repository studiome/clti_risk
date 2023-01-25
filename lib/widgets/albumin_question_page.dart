import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/questions.dart';
import 'clinical_data_controller.dart';
import 'question_page.dart';

class AlbQuestionPage extends StatelessWidget {
  final TextEditingController controller;
  const AlbQuestionPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final c = ClinicalDataController.of(context);
    if (c == null) throw TypeError();
    controller.text =
        c.patientData.alb == null ? '' : c.patientData.alb.toString();
    return NumberFormQuestionContent(
        title: AppLocalizations.of(context).questionAlbTitle,
        subtitle: AppLocalizations.of(context).questionAlbSubtitle,
        formController: controller,
        isDecimal: true,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'^\d{1}\.?\d{0,1}')),
        ],
        onSubmitted: (v) {
          try {
            c.patientData.alb = double.parse(v);
          } catch (e) {
            c.patientData.alb = null;
          }
        },
        itemWidth: 240,
        itemHeight: 80,
        tabIndex: Questions.albumin.index,
        tabCount: Questions.values.length);
  }
}
