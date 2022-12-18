import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/locale_controller.dart';
import '../models/patient_risk.dart';
import '../models/questions.dart';
import 'activity_question_page.dart';
import 'age_question_page.dart';
import 'ai_question_page.dart';
import 'albumin_question_page.dart';
import 'bk_question_page.dart';
import 'cad_question_page.dart';
import 'chf_question_page.dart';
import 'ckd_question_page.dart';
import 'clinical_data_controller.dart';
import 'contralateral_question_page.dart';
import 'cvd_question_page.dart';
import 'dl_question_page.dart';
import 'fever_question_page.dart';
import 'fp_question_page.dart';
import 'height_question_page.dart';
import 'instruction_page.dart';
import 'local_infection_question_page.dart';
import 'malingnant_question_page.dart';
import 'other_vascular_question_page.dart';
import 'patient_data_summary.dart';
import 'question_binder.dart';
import 'rutherford_question_page.dart';
import 'sex_question_page.dart';
import 'smoking_question_page.dart';
import 'urgent_question_page.dart';
import 'wbc_question_page.dart';
import 'weight_question_page.dart';

class QuestionForm extends StatefulWidget {
  final String title;
  final String appName;
  final List<Widget>? actions;
  final TextEditingController ageController;
  final TextEditingController heightController;
  final TextEditingController weightController;
  final TextEditingController albController;
  final LocaleController localeController;

  const QuestionForm({
    super.key,
    required this.title,
    required this.ageController,
    required this.heightController,
    required this.weightController,
    required this.albController,
    required this.appName,
    this.actions,
    required this.localeController,
  });

  @override
  State<QuestionForm> createState() => _QuestionFormState();
}

class _QuestionFormState extends State<QuestionForm> {
  var kIsWeb;

  @override
  Widget build(BuildContext context) {
    final Map<int, Widget> pageList = {
      Questions.instruction.index: const InstructionPage(),
      Questions.sex.index: const SexQuestionPage(),
      Questions.age.index: AgeQuestionPage(controller: widget.ageController),
      Questions.height.index:
          HeightQuestionPage(controller: widget.heightController),
      Questions.weight.index:
          WeightQuestionPage(controller: widget.weightController),
      Questions.albumin.index:
          AlbQuestionPage(controller: widget.albController),
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
        ageController: widget.ageController,
        heightController: widget.heightController,
        weightController: widget.weightController,
        albController: widget.albController,
      ),
    };

    final Map<int, String> titleList = {
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
      Questions.summary.index:
          AppLocalizations.of(context).questionSummaryTitle,
    };

    final c = ClinicalDataController.of(context);
    if (c == null) throw NullThrownError();
    return QuestionBinder(
        title: widget.title,
        actions: widget.actions,
        drawerListTiles: <ListTile>[
          ListTile(
            leading: const Icon(Icons.language_outlined),
            title: Text(AppLocalizations.of(context).language),
            onTap: () async {
              await showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(AppLocalizations.of(context).language),
                    content: LocaleSwitch(
                      localeController: widget.localeController,
                    ),
                    actions: [
                      TextButton(
                        child: Text(AppLocalizations.of(context).ok),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  );
                },
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.article_outlined),
            title: Text(AppLocalizations.of(context).references),
            onTap: () async {
              await showDialog(
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      title: Text(AppLocalizations.of(context).references),
                      children: const [
                        SimpleDialogOption(
                            child: Text(
                          '1. Miyata T. et al, Risk prediction model for early outcomes of revascularization for chronic limb-threatening ischaemia. Br J Surg. 2022 Oct 14;109(11):1123.',
                          softWrap: true,
                        )),
                        SimpleDialogOption(
                          child: Text(
                            '2. Miyata T. et al, Prediction Models for Two Year Overall Survival and Amputation Free Survival After Revascularisation for Chronic Limb Threatening Ischaemia. Eur J Vasc Endovasc Surg . 2022 Jun 7;S1078-5884(22)00340-9.',
                            softWrap: true,
                          ),
                        ),
                      ],
                    );
                  });
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text(AppLocalizations.of(context).about),
            onTap: () async {
              final PackageInfo packageInfo = await PackageInfo.fromPlatform();
              if (!mounted) return;
              showAboutDialog(
                context: context,
                applicationName: widget.appName,
                applicationVersion: packageInfo.version,
                applicationLegalese: AppLocalizations.of(context).appLegalese,
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.handshake_outlined),
            title: Text(AppLocalizations.of(context).appTerms),
            onTap: () async {
              await launchUrl(
                  Uri.parse("https://studiome.github.io/clti_risk/"));
            },
          ),
        ],
        actionButton: FloatingActionButton.extended(
          onPressed: () {
            try {
              c.patientData.age = int.parse(widget.ageController.text);
              c.patientData.height = double.parse(widget.heightController.text);
              c.patientData.weight = double.parse(widget.weightController.text);
              c.patientData.alb = double.parse(widget.albController.text);
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content:
                    Text(AppLocalizations.of(context).analysisErrorMessage),
                action: SnackBarAction(
                    textColor: Theme.of(context).colorScheme.onSecondary,
                    label: AppLocalizations.of(context).ok,
                    onPressed: () =>
                        ScaffoldMessenger.of(context).hideCurrentSnackBar()),
              ));
              return;
            }
            final pr = PatientRisk(patientData: c.patientData);
            c.onRiskCalculated.sink.add(pr);
          },
          icon: const Icon(Icons.analytics_outlined),
          label: Text(AppLocalizations.of(context).analysis),
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

class LocaleSwitch extends StatelessWidget {
  final LocaleController localeController;
  const LocaleSwitch({super.key, required this.localeController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.0,
      child: Column(
        children: [
          RadioListTile(
            title: Text(AppLocalizations.of(context).en),
            value: const Locale('en'),
            groupValue: localeController.value,
            onChanged: (v) async {
              if (v == null) return;
              localeController.value = v;
              await _setLocaleToPrefs(v);
            },
          ),
          RadioListTile(
            title: Text(AppLocalizations.of(context).ja),
            value: const Locale('ja'),
            groupValue: localeController.value,
            onChanged: (v) async {
              if (v == null) return;
              localeController.value = v;
              await _setLocaleToPrefs(v);
            },
          ),
        ],
      ),
    );
  }

  Future<void> _setLocaleToPrefs(Locale locale) {
    return SharedPreferences.getInstance().then(
      (pref) {
        pref.setString('locale', locale.toString());
      },
    );
  }
}
