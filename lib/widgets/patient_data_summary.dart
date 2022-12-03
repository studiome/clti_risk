import 'package:flutter/material.dart';

import '../models/clinical_data_controller.dart';
import '../models/question_details.dart' as details;
import '../models/questions.dart';
import '../models/yes_no.dart';

class PatientDataSummary extends StatelessWidget {
  final TextEditingController ageController;
  final TextEditingController heightController;
  final TextEditingController weightController;
  final TextEditingController albController;
  const PatientDataSummary(
      {super.key,
      required this.ageController,
      required this.heightController,
      required this.weightController,
      required this.albController});

  @override
  Widget build(BuildContext context) {
    final c = ClinicalDataController.of(context);
    if (c == null) throw NullThrownError();
    final pd = c.patientData;
    final Map<int, String> data = {
      Questions.sex.index: pd.sex.toString(),
      Questions.age.index: ageController.text,
      Questions.height.index: heightController.text,
      Questions.weight.index: weightController.text,
      Questions.albumin.index: albController.text,
      Questions.activity.index: pd.activity.toString(),
      Questions.chf.index: pd.hasCHF.toYesNo().toString(),
      Questions.cad.index: pd.hasCAD.toYesNo().toString(),
      Questions.cvd.index: pd.hasCVD.toYesNo().toString(),
      Questions.ckd.index: pd.ckd.toString(),
      Questions.malignantNeoplasm.index: pd.malignant.toString(),
      Questions.lesionAI.index: pd.hasAILesion.toYesNo().toString(),
      Questions.lesionFP.index: pd.hasFPLesion.toYesNo().toString(),
      Questions.lesionBK.index: pd.hasBKLesion.toYesNo().toString(),
      Questions.urgentProcedure.index: pd.isUrgent.toYesNo().toString(),
      Questions.fever.index: pd.hasFever.toYesNo().toString(),
      Questions.abnormalWBC.index: pd.hasAbnormalWBC.toYesNo().toString(),
      Questions.localInfection.index: pd.hasLocalInfection.toYesNo().toString(),
      Questions.dyslipidemia.index: pd.hasDyslipidemia.toYesNo().toString(),
      Questions.smoking.index: pd.isSmoking.toYesNo().toString(),
      Questions.contralateral.index:
          pd.hasContraLateralLesion.toYesNo().toString(),
      Questions.others.index: pd.hasOtherVD.toYesNo().toString(),
      Questions.rutherford.index: pd.rutherford.toString(),
    };
    final Map<int, String> title = {
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
    };
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          title: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 240),
            child: Text(
              '${index + 1}. ${title[index!]}',
              softWrap: true,
              maxLines: 3,
            ),
          ),
          subtitle: Text(data[index]!),
          onTap: () {
            final TabController? tabController =
                DefaultTabController.of(context);
            if (tabController == null) return;
            tabController.animateTo(index);
          },
        );
      },
      itemCount: data.length,
    );
  }
}
