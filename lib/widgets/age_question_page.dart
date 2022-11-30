import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/clinical_data_controller.dart';
import '../models/questions.dart';
import 'question_page.dart';

class AgeQuestionPage extends StatelessWidget {
  final TextEditingController controller;
  const AgeQuestionPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final c = ClinicalDataController.of(context);
    if (c == null) throw NullThrownError();
    return NumberFormQuestionContent(
        question: Questions.age,
        formController: controller,
        isDecimal: false,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
        onSubmitted: (v) {
          try {
            c.patientData.age = int.parse(v);
          } catch (e) {
            c.patientData.age = null;
          }
        },
        itemWidth: 240,
        itemHeight: 60,
        tabIndex: Questions.age.index,
        tabCount: Questions.values.length);
  }
}
