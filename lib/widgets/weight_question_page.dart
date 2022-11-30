import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/clinical_data_controller.dart';
import '../models/questions.dart';
import 'question_page.dart';

class WeightQuestionPage extends StatelessWidget {
  final TextEditingController controller;
  const WeightQuestionPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final c = ClinicalDataController.of(context);
    if (c == null) throw NullThrownError();
    return NumberFormQuestionContent(
        question: Questions.weight,
        formController: controller,
        isDecimal: true,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'^\d{1,3}\.?\d{0,1}')),
        ],
        onSubmitted: (v) {
          try {
            c.patientData.weight = double.parse(v);
          } catch (e) {
            c.patientData.weight = null;
          }
        },
        itemWidth: 240,
        itemHeight: 80,
        tabIndex: Questions.weight.index,
        tabCount: Questions.values.length);
  }
}
