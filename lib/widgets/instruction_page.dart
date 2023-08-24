import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/questions.dart';
import 'question_page.dart';

class InstructionPage extends StatelessWidget {
  const InstructionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return QuestionPage(
      subtitle: AppLocalizations.of(context)!.questionInstructionSubtitle,
      content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: RichText(
              text: TextSpan(
            style: Theme.of(context).textTheme.bodyMedium,
            children: _getInstructionContent(context),
          ))),
      tabIndex: Questions.instruction.index,
      tabCount: Questions.values.length,
    );
  }

  List<InlineSpan>? _getInstructionContent(BuildContext context) {
    final locale = Localizations.localeOf(context);
    switch (locale.languageCode) {
      case 'ja':
        return <InlineSpan>[
          const TextSpan(
              text:
                  'i. 選択肢を選ぶか値を入力して、次へを押してください。\nii. 全て入力し、リスク解析ボタンを押すと結果が得られます。\niii. データ一覧が見たい場合は、上の'),
          const WidgetSpan(child: Icon(Icons.summarize_outlined)),
          const TextSpan(text: ' を押してください。\niv. 初期化したい場合は、上の'),
          const WidgetSpan(child: Icon(Icons.refresh_outlined)),
          const TextSpan(text: 'を押してください。\n'),
        ];
      case 'en':
        return <InlineSpan>[
          const TextSpan(
              text:
                  'i. Check the choices or fill in the blanks, then press "Next".\nii. Analysis button will show you patient risks.\niii. If you would like to see summary, press '),
          const WidgetSpan(child: Icon(Icons.summarize_outlined)),
          const TextSpan(text: ' above.\niv. You can refresh data to press '),
          const WidgetSpan(child: Icon(Icons.refresh_outlined)),
          const TextSpan(text: ' next to summary button.\n'),
        ];
    }
    return null;
  }
}
