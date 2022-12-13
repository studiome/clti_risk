import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/clinical_data_controller.dart';
import '../models/questions.dart';
import '../models/yes_no.dart';
import 'label_builder.dart';

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
      Questions.sex.index: LabelBuilder(context: context, item: pd.sex).text,
      Questions.age.index: ageController.text,
      Questions.height.index: heightController.text,
      Questions.weight.index: weightController.text,
      Questions.albumin.index: albController.text,
      Questions.activity.index:
          LabelBuilder(context: context, item: pd.activity).text,
      Questions.chf.index:
          LabelBuilder(context: context, item: pd.hasCHF.toYesNo()).text,
      Questions.cad.index:
          LabelBuilder(context: context, item: pd.hasCAD.toYesNo()).text,
      Questions.cvd.index:
          LabelBuilder(context: context, item: pd.hasCVD.toYesNo()).text,
      Questions.ckd.index: LabelBuilder(context: context, item: pd.ckd).text,
      Questions.malignantNeoplasm.index:
          LabelBuilder(context: context, item: pd.malignant).text,
      Questions.lesionAI.index:
          LabelBuilder(context: context, item: pd.hasAILesion.toYesNo()).text,
      Questions.lesionFP.index:
          LabelBuilder(context: context, item: pd.hasFPLesion.toYesNo()).text,
      Questions.lesionBK.index:
          LabelBuilder(context: context, item: pd.hasBKLesion.toYesNo()).text,
      Questions.urgentProcedure.index:
          LabelBuilder(context: context, item: pd.isUrgent.toYesNo()).text,
      Questions.fever.index:
          LabelBuilder(context: context, item: pd.hasFever.toYesNo()).text,
      Questions.abnormalWBC.index:
          LabelBuilder(context: context, item: pd.hasAbnormalWBC.toYesNo())
              .text,
      Questions.localInfection.index:
          LabelBuilder(context: context, item: pd.hasLocalInfection.toYesNo())
              .text,
      Questions.dyslipidemia.index:
          LabelBuilder(context: context, item: pd.hasDyslipidemia.toYesNo())
              .text,
      Questions.smoking.index:
          LabelBuilder(context: context, item: pd.isSmoking.toYesNo()).text,
      Questions.contralateral.index: LabelBuilder(
              context: context, item: pd.hasContraLateralLesion.toYesNo())
          .text,
      Questions.others.index:
          LabelBuilder(context: context, item: pd.hasOtherVD.toYesNo()).text,
      Questions.rutherford.index:
          LabelBuilder(context: context, item: pd.rutherford).text,
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
