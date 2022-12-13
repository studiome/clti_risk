import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/clinical_data_controller.dart';
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
      Questions.instruction.index: '',
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
      Questions.instruction.index:
          AppLocalizations.of(context).questionInstructionTitle,
      Questions.sex.index: AppLocalizations.of(context).questionSexTitle,
      Questions.age.index: AppLocalizations.of(context).questionAgeTitle,
      Questions.height.index: AppLocalizations.of(context).questionHeightTitle,
      Questions.weight.index: AppLocalizations.of(context).questionWeightTitle,
      Questions.albumin.index: AppLocalizations.of(context).questionAlbTitle,
      Questions.activity.index:
          AppLocalizations.of(context).questionActivityTitle,
      Questions.chf.index: AppLocalizations.of(context).questionCHFTitle,
      Questions.cad.index: AppLocalizations.of(context).questionCADTitle,
      Questions.cvd.index: AppLocalizations.of(context).questionCVDTitle,
      Questions.ckd.index: AppLocalizations.of(context).questionCKDTitle,
      Questions.malignantNeoplasm.index:
          AppLocalizations.of(context).questionMalignantTitle,
      Questions.lesionAI.index:
          AppLocalizations.of(context).questionAILesionTitle,
      Questions.lesionFP.index:
          AppLocalizations.of(context).questionFPLesionTitle,
      Questions.lesionBK.index:
          AppLocalizations.of(context).questionBKLesionTitle,
      Questions.urgentProcedure.index:
          AppLocalizations.of(context).questionUrgentTitle,
      Questions.fever.index: AppLocalizations.of(context).questionFeverTitle,
      Questions.abnormalWBC.index:
          AppLocalizations.of(context).questionAbnormalWBCTitle,
      Questions.localInfection.index:
          AppLocalizations.of(context).questionLocalInfectionTitle,
      Questions.dyslipidemia.index:
          AppLocalizations.of(context).questionDLTitle,
      Questions.smoking.index:
          AppLocalizations.of(context).questionSmokingTitle,
      Questions.contralateral.index:
          AppLocalizations.of(context).questionContraTitle,
      Questions.others.index:
          AppLocalizations.of(context).questionOtherLesionTitle,
      Questions.rutherford.index:
          AppLocalizations.of(context).questionRutherfordTitle,
    };
    //set value if not next tapped or done entered.
    try {
      c.patientData.age = int.parse(ageController.text);
      c.patientData.height = double.parse(heightController.text);
      c.patientData.weight = double.parse(weightController.text);
      c.patientData.alb = double.parse(albController.text);
    } catch (e) {
      if (kDebugMode) print(e);
      //DO NOTHING
    }
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          title: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 240),
            child: Text(
              '${index + 1}. ${title[index]}',
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
