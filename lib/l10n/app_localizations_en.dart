// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get questionFormTitle => 'Patient Data';

  @override
  String get nextButton => 'Next';

  @override
  String get backButton => 'Back';

  @override
  String get questionInstructionTitle => 'Instruction';

  @override
  String get questionInstructionSubtitle => 'Follow the instructions below.';

  @override
  String get questionSexTitle => 'Sex';

  @override
  String get questionSexSubtitle => 'Male or Female';

  @override
  String get questionAgeTitle => 'Age [year-old]';

  @override
  String get questionAgeSubtitle => 'Enter Age [year-old], then press Next.';

  @override
  String get questionHeightTitle => 'Body Height [cm]';

  @override
  String get questionHeightSubtitle => 'Enter body height [cm], then press Next';

  @override
  String get questionWeightTitle => 'Body Weight [kg]';

  @override
  String get questionWeightSubtitle => 'Enter body weight [kg], then press Next';

  @override
  String get questionAlbTitle => 'Serum Albumin [g/dl]';

  @override
  String get questionAlbSubtitle => 'Enter albumin [g/dl], then press Next';

  @override
  String get questionActivityTitle => 'Activity';

  @override
  String get questionActivitySubtitle => 'Ambulatory: able to walk, Wheelchair: unable to walk but could stand on their own legs during bed to wheelchair transfer, Immobile: full assistance is indispensable';

  @override
  String get questionCHFTitle => 'Congestive heart failure';

  @override
  String get questionCHFSubtitle => 'absent or present: a history of admission due to CHF or clinical symptoms of CHF confirmed on echocardiography or absence of clinical symptoms but clearly reduced cardiac function on echocardiography';

  @override
  String get questionCADTitle => 'Coronary artery disease';

  @override
  String get questionCADSubtitle => 'absent or present: myocardial infarction and/or ongoing angina or previous endovascular coronary intervention and/or coronary artery bypass surgery';

  @override
  String get questionCVDTitle => 'Cerebral vascular disease';

  @override
  String get questionCVDSubtitle => 'absent or present: stroke and/or transient ischemic attacks';

  @override
  String get questionCKDTitle => 'Chronic kidney disease\n (eGFR*: mL/min/1.73m²)';

  @override
  String get questionCKDSubtitle => 'No: 60 or higher, G3: 30-59, G4: 15-29, G5: below 15, G5D: below 15 in haemodialysis.\n *eGFR: the estimated glomerular filtration rate';

  @override
  String get questionMalignantTitle => 'Malignant neoplasm';

  @override
  String get questionMalignantSubtitle => 'absent, past history of malignant neoplasm, or present under treatment';

  @override
  String get questionAILesionTitle => 'Sites of artery occlusive lesions: Aorto-Iliac';

  @override
  String get questionAILesionSubtitle => 'aorto-iliac occlusive lesion present or absent';

  @override
  String get questionFPLesionTitle => 'Sites of artery occlusive lesions: Femoro-Popliteal';

  @override
  String get questionFPLesionSubtitle => 'femoro-popliteal present or absent';

  @override
  String get questionBKLesionTitle => 'Sites of artery occlusive lesions: Infrapopliteal';

  @override
  String get questionBKLesionSubtitle => 'infrapopliteal present or absent';

  @override
  String get questionUrgentTitle => 'Urgent revascularisation procedures';

  @override
  String get questionUrgentSubtitle => 'indication for revascularization, no: elective or yes';

  @override
  String get questionFeverTitle => 'Fever';

  @override
  String get questionFeverSubtitle => 'body temperature is higher than 38℃';

  @override
  String get questionAbnormalWBCTitle => 'Abnormal WBC';

  @override
  String get questionAbnormalWBCSubtitle => 'white blood cell count: abnormal: > 8000 [/µl] or absent';

  @override
  String get questionLocalInfectionTitle => 'Local Infection';

  @override
  String get questionLocalInfectionSubtitle => 'absent or present: the wound was suppurative or showed at least two of the following findings: heat, erythema, lymphangitis, lymph node swelling, oedema, and pain';

  @override
  String get questionDLTitle => 'Dyslipidemia';

  @override
  String get questionDLSubtitle => 'absent or present:serum low density lipoprotein (LDL-C) > 140 [mg/dl]';

  @override
  String get questionSmokingTitle => 'Smoking Status';

  @override
  String get questionSmokingSubtitle => 'no or yes: smoker or ex-smoker';

  @override
  String get questionContraTitle => 'Contralateral limb arterial occlusive lesions';

  @override
  String get questionContraSubtitle => 'absent or present: including post-treatment,';

  @override
  String get questionOtherLesionTitle => 'Other vascular lesions except contralateral limb';

  @override
  String get questionOtherLesionSubtitle => 'absent or present';

  @override
  String get questionRutherfordTitle => 'Rutherford Classification';

  @override
  String get questionRutherfordSubtitle => 'classes 4, 5, or 6';

  @override
  String get questionSummaryTitle => 'Patient Data Summary';

  @override
  String get questionSummarySubtitle => 'Check items';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get male => 'Male';

  @override
  String get female => 'Female';

  @override
  String get ambulatory => 'Ambulatory';

  @override
  String get wheelchair => 'WheelChair';

  @override
  String get immobile => 'Immobile';

  @override
  String get normal => 'No';

  @override
  String get g3 => 'G3';

  @override
  String get g4 => 'G4';

  @override
  String get g5 => 'G5';

  @override
  String get g5D => 'G5D';

  @override
  String get noMalignancy => 'No';

  @override
  String get pastHistory => 'Past History';

  @override
  String get underTreatment => 'UnderTreatment';

  @override
  String get class4 => 'Class 4';

  @override
  String get class5 => 'Class 5';

  @override
  String get class6 => 'Class 6';

  @override
  String get formErrorMessage => 'Please enter value.';

  @override
  String get invalidValueMessage => 'Invalid Value';

  @override
  String get ok => 'OK';

  @override
  String get analysisDefaultErrorMessage => 'Error! Check patient data.';

  @override
  String get analysisNullErrorMessage => 'Error! Missing some data at Number Form.';

  @override
  String get analysisLesionErrorMessage => 'Error! Check Lesions choice.';

  @override
  String get references => 'References';

  @override
  String get about => 'About';

  @override
  String get tapToOpenLink => 'Tap to open link.';

  @override
  String get appLegalese => '2022 Kazuhiro Miyahara, JSVS, JCLIMB';

  @override
  String get language => 'Language';

  @override
  String get en => 'English';

  @override
  String get ja => '日本語';

  @override
  String get analysis => 'Analysis';

  @override
  String get result => 'Predicted Risks';

  @override
  String get gnri => 'GNRI';

  @override
  String get gnriDesctiption => 'Geriatric Nutritional Risk Index';

  @override
  String get predicted30DAD => 'Predicted 30-day Amputation/Death';

  @override
  String get predicted30DADDescription => 'Predicted risk of major amputation and/or death 30 days after revascularization';

  @override
  String get predicted30DMALE => 'Predicted 30-day MALE';

  @override
  String get predicted30DMALEDescription => 'Predicted risk of  major adverse limb event 30 days after revascularization.\n*MALE: major adverse limb events; above-ankle amputation of the index limb or major reintervention (new bypass graft, jump/ interposition graft revision, or thrombectomy/thrombolysis)';

  @override
  String get predicted2yrOS => 'Predicted 2-year OS';

  @override
  String get predicted2yrOSDescription => 'Predicted 2 year Overall Survival post-revascularisation';

  @override
  String get predicted2yrAFS => 'Predicted 2-year AFS';

  @override
  String get predicted2yrAFSDescription => 'Predicted 2 year Amputation Free Survival post-revascularisation';

  @override
  String get gnriNoRisk => 'No Risk';

  @override
  String get gnriLowRisk => 'Low Risk';

  @override
  String get gnriModerateRisk => 'Moderate Risk';

  @override
  String get gntiMajorRisk => 'Major Risk';

  @override
  String get osLowRisk => 'Low Risk';

  @override
  String get osMediumRisk => 'Medium Risk';

  @override
  String get osHighRisk => 'High Risk';

  @override
  String get appTerms => 'Terms of Use and Disclaimer';

  @override
  String get appPrivacyPolicy => 'Privacy Policy';

  @override
  String get appSupport => 'Support';

  @override
  String get medicalDisclaimer => 'This app does not provide medical advice, diagnosis, treatment, or prevention and is not a substitute for professional clinical judgment. Consult a qualified healthcare professional before making medical decisions.';

  @override
  String get refreshButtonLabel => 'Refresh Question Form';

  @override
  String get summaryButtonLabel => 'Move to Summary';
}
