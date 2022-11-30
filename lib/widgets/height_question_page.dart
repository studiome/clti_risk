import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/clinical_data_controller.dart';
import '../models/questions.dart';
import 'question_page.dart';

class HeightQuestionPage extends StatelessWidget {
  final TextEditingController controller;
  const HeightQuestionPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final c = ClinicalDataController.of(context);
    if (c == null) throw NullThrownError();
    return NumberFormQuestionContent(
        question: Questions.height,
        formController: controller,
        isDecimal: true,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'^\d{1}\.?\d{0,2}')),
        ],
        onSubmitted: (v) {
          try {
            c.patientData.height = double.parse(v);
          } catch (e) {
            c.patientData.height = null;
          }
        },
        itemWidth: 240,
        itemHeight: 60,
        tabIndex: Questions.height.index,
        tabCount: Questions.values.length);
  }
}
