import 'package:flutter/material.dart';

import '../models/question_details.dart' as detail;
import '../models/questions.dart';
import 'question_page.dart';

class InstructionPage extends StatelessWidget {
  const InstructionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final d = detail.questionDetail[Questions.instruction];
    if (d == null) throw NullThrownError();
    final String? subtitle = d[detail.Description.subtitle];
    if (subtitle == null) throw NullThrownError();
    return QuestionPage(
      subtitle: subtitle,
      content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: RichText(
              text: TextSpan(
            style: Theme.of(context).textTheme.bodyText1,
            children: const [
              TextSpan(
                  text:
                      'i. Check the choices or fill in the blanks, then press "Next".\nii. Analysis button will show you patient risks.\niii. If you would like to see summary, press '),
              WidgetSpan(child: Icon(Icons.summarize_outlined)),
              TextSpan(text: ' above.\niv. You can refresh data to press '),
              WidgetSpan(child: Icon(Icons.refresh_outlined)),
              TextSpan(text: ' next to summary button.\n'),
            ],
          ))),
      tabIndex: Questions.instruction.index,
      tabCount: Questions.values.length,
    );
  }
}
