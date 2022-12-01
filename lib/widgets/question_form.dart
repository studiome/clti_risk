import 'package:clti_risk/widgets/patient_data_summary.dart';
import 'package:flutter/material.dart';

import '../models/question_details.dart' as details;
import '../models/questions.dart';
import 'activity_question_page.dart';
import 'age_question_page.dart';
import 'ai_question_page.dart';
import 'albumin_question_page.dart';
import 'bk_question_page.dart';
import 'cad_question_page.dart';
import 'chf_question_page.dart';
import 'ckd_question_page.dart';
import 'contralateral_question_page.dart';
import 'cvd_question_page.dart';
import 'dl_question_page.dart';
import 'fever_question_page.dart';
import 'fp_question_page.dart';
import 'height_question_page.dart';
import 'local_infection_question_page.dart';
import 'malingnant_question_page.dart';
import 'other_vascular_question_page.dart';
import 'question_binder.dart';
import 'rutherford_question_page.dart';
import 'sex_question_page.dart';
import 'smoking_question_page.dart';
import 'urgent_question_page.dart';
import 'wbc_question_page.dart';
import 'weight_question_page.dart';

class QuestionForm extends StatelessWidget {
  final String title;
  final TextEditingController ageController;
  final TextEditingController heightController;
  final TextEditingController weightController;
  final TextEditingController albController;

  const QuestionForm({
    super.key,
    required this.title,
    required this.ageController,
    required this.heightController,
    required this.weightController,
    required this.albController,
  });

  @override
  Widget build(BuildContext context) {
    final Map<int, Widget> pageList = {
      Questions.sex.index: const SexQuestionPage(),
      Questions.age.index: AgeQuestionPage(controller: ageController),
      Questions.height.index: HeightQuestionPage(controller: heightController),
      Questions.weight.index: WeightQuestionPage(controller: weightController),
      Questions.albumin.index: AlbQuestionPage(controller: albController),
      Questions.activity.index: const ActivityQuestionPage(),
      Questions.chf.index: const CHFQuestionPage(),
      Questions.cad.index: const CADQuestionPage(),
      Questions.cvd.index: const CVDQuestionPage(),
      Questions.ckd.index: const CKDQuestionPage(),
      Questions.malignantNeoplasm.index: const MalignantQuestionPage(),
      Questions.lesionAI.index: const LesionAIQuestionPage(),
      Questions.lesionFP.index: const LesionFPQuestionPage(),
      Questions.lesionBK.index: const LesionBKQuestionPage(),
      Questions.urgentProcedure.index: const UrgentQuestionPage(),
      Questions.fever.index: const FeverQuestionPage(),
      Questions.abnormalWBC.index: const AbnormalWBCQuestionPage(),
      Questions.localInfection.index: const LocalInfectionQuestionPage(),
      Questions.dyslipidemia.index: const DLQuestionPage(),
      Questions.smoking.index: const SmokingQuestionPage(),
      Questions.contralateral.index: const ContraLateralQuestionPage(),
      Questions.others.index: const OtherVDQuestionPage(),
      Questions.rutherford.index: const RutherfordQuestionPage(),
      Questions.summary.index: PatientDataSummary(
        ageController: ageController,
        heightController: heightController,
        weightController: weightController,
        albController: albController,
      ),
    };

    final Map<int, String> titleList = {
      Questions.sex.index:
          details.questionDetail[Questions.sex]![details.Description.title]!,
      Questions.age.index:
          details.questionDetail[Questions.age]![details.Description.title]!,
      Questions.height.index:
          details.questionDetail[Questions.height]![details.Description.title]!,
      Questions.weight.index:
          details.questionDetail[Questions.weight]![details.Description.title]!,
      Questions.albumin.index: details
          .questionDetail[Questions.albumin]![details.Description.title]!,
      Questions.activity.index: details
          .questionDetail[Questions.activity]![details.Description.title]!,
      Questions.chf.index:
          details.questionDetail[Questions.chf]![details.Description.title]!,
      Questions.cad.index:
          details.questionDetail[Questions.cad]![details.Description.title]!,
      Questions.cvd.index:
          details.questionDetail[Questions.cvd]![details.Description.title]!,
      Questions.ckd.index:
          details.questionDetail[Questions.ckd]![details.Description.title]!,
      Questions.malignantNeoplasm.index: details.questionDetail[
          Questions.malignantNeoplasm]![details.Description.title]!,
      Questions.lesionAI.index: details
          .questionDetail[Questions.lesionAI]![details.Description.title]!,
      Questions.lesionFP.index: details
          .questionDetail[Questions.lesionFP]![details.Description.title]!,
      Questions.lesionBK.index: details
          .questionDetail[Questions.lesionBK]![details.Description.title]!,
      Questions.urgentProcedure.index: details.questionDetail[
          Questions.urgentProcedure]![details.Description.title]!,
      Questions.fever.index:
          details.questionDetail[Questions.fever]![details.Description.title]!,
      Questions.abnormalWBC.index: details
          .questionDetail[Questions.abnormalWBC]![details.Description.title]!,
      Questions.localInfection.index: details.questionDetail[
          Questions.localInfection]![details.Description.title]!,
      Questions.dyslipidemia.index: details
          .questionDetail[Questions.dyslipidemia]![details.Description.title]!,
      Questions.smoking.index: details
          .questionDetail[Questions.smoking]![details.Description.title]!,
      Questions.contralateral.index: details
          .questionDetail[Questions.contralateral]![details.Description.title]!,
      Questions.others.index:
          details.questionDetail[Questions.others]![details.Description.title]!,
      Questions.rutherford.index: details
          .questionDetail[Questions.rutherford]![details.Description.title]!,
      Questions.summary.index: details
          .questionDetail[Questions.summary]![details.Description.title]!,
    };

    return QuestionBinder(
        title: title,
        actionButton: TextButton.icon(
          icon: const Icon(Icons.calculate_outlined),
          onPressed: () {},
          label: const Text('Calculate'),
        ),
        questionPages:
            List<QuestionPageDetail>.generate(Questions.values.length, (index) {
          return QuestionPageDetail(
              tabBarTitle: titleList[index]!,
              tabIndex: index,
              page: pageList[index]!);
        }));
  }
}
