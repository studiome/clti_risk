import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ja')
  ];

  /// No description provided for @questionFormTitle.
  ///
  /// In en, this message translates to:
  /// **'Patient Data'**
  String get questionFormTitle;

  /// No description provided for @nextButton.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get nextButton;

  /// No description provided for @backButton.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get backButton;

  /// No description provided for @questionInstructionTitle.
  ///
  /// In en, this message translates to:
  /// **'Instruction'**
  String get questionInstructionTitle;

  /// No description provided for @questionInstructionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Follow the instructions below.'**
  String get questionInstructionSubtitle;

  /// No description provided for @questionSexTitle.
  ///
  /// In en, this message translates to:
  /// **'Sex'**
  String get questionSexTitle;

  /// No description provided for @questionSexSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Male or Female'**
  String get questionSexSubtitle;

  /// No description provided for @questionAgeTitle.
  ///
  /// In en, this message translates to:
  /// **'Age [year-old]'**
  String get questionAgeTitle;

  /// No description provided for @questionAgeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter Age [year-old], then press Next.'**
  String get questionAgeSubtitle;

  /// No description provided for @questionHeightTitle.
  ///
  /// In en, this message translates to:
  /// **'Body Height [cm]'**
  String get questionHeightTitle;

  /// No description provided for @questionHeightSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter body height [cm], then press Next'**
  String get questionHeightSubtitle;

  /// No description provided for @questionWeightTitle.
  ///
  /// In en, this message translates to:
  /// **'Body Weight [kg]'**
  String get questionWeightTitle;

  /// No description provided for @questionWeightSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter body weight [kg], then press Next'**
  String get questionWeightSubtitle;

  /// No description provided for @questionAlbTitle.
  ///
  /// In en, this message translates to:
  /// **'Serum Albumin [g/dl]'**
  String get questionAlbTitle;

  /// No description provided for @questionAlbSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter albumin [g/dl], then press Next'**
  String get questionAlbSubtitle;

  /// No description provided for @questionActivityTitle.
  ///
  /// In en, this message translates to:
  /// **'Activity'**
  String get questionActivityTitle;

  /// No description provided for @questionActivitySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Ambulatory: able to walk, Wheelchair: unable to walk but could stand on their own legs during bed to wheelchair transfer, Immobile: full assistance is indispensable'**
  String get questionActivitySubtitle;

  /// No description provided for @questionCHFTitle.
  ///
  /// In en, this message translates to:
  /// **'Congestive heart failure'**
  String get questionCHFTitle;

  /// No description provided for @questionCHFSubtitle.
  ///
  /// In en, this message translates to:
  /// **'absent or present: a history of admission due to CHF or clinical symptoms of CHF confirmed on echocardiography or absence of clinical symptoms but clearly reduced cardiac function on echocardiography'**
  String get questionCHFSubtitle;

  /// No description provided for @questionCADTitle.
  ///
  /// In en, this message translates to:
  /// **'Coronary artery disease'**
  String get questionCADTitle;

  /// No description provided for @questionCADSubtitle.
  ///
  /// In en, this message translates to:
  /// **'absent or present: myocardial infarction and/or ongoing angina or previous endovascular coronary intervention and/or coronary artery bypass surgery'**
  String get questionCADSubtitle;

  /// No description provided for @questionCVDTitle.
  ///
  /// In en, this message translates to:
  /// **'Cerebral vascular disease'**
  String get questionCVDTitle;

  /// No description provided for @questionCVDSubtitle.
  ///
  /// In en, this message translates to:
  /// **'absent or present: stroke and/or transient ischemic attacks'**
  String get questionCVDSubtitle;

  /// No description provided for @questionCKDTitle.
  ///
  /// In en, this message translates to:
  /// **'Chronic kidney disease\n (eGFR*: mL/min/1.73m²)'**
  String get questionCKDTitle;

  /// No description provided for @questionCKDSubtitle.
  ///
  /// In en, this message translates to:
  /// **'No: 60 or higher, G3: 30-59, G4: 15-29, G5: below 15, G5D: below 15 in haemodialysis.\n *eGFR: the estimated glomerular filtration rate'**
  String get questionCKDSubtitle;

  /// No description provided for @questionMalignantTitle.
  ///
  /// In en, this message translates to:
  /// **'Malignant neoplasm'**
  String get questionMalignantTitle;

  /// No description provided for @questionMalignantSubtitle.
  ///
  /// In en, this message translates to:
  /// **'absent, past history of malignant neoplasm, or present under treatment'**
  String get questionMalignantSubtitle;

  /// No description provided for @questionAILesionTitle.
  ///
  /// In en, this message translates to:
  /// **'Sites of artery occlusive lesions: Aorto-Iliac'**
  String get questionAILesionTitle;

  /// No description provided for @questionAILesionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'aorto-iliac occlusive lesion present or absent'**
  String get questionAILesionSubtitle;

  /// No description provided for @questionFPLesionTitle.
  ///
  /// In en, this message translates to:
  /// **'Sites of artery occlusive lesions: Femoro-Popliteal'**
  String get questionFPLesionTitle;

  /// No description provided for @questionFPLesionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'femoro-popliteal present or absent'**
  String get questionFPLesionSubtitle;

  /// No description provided for @questionBKLesionTitle.
  ///
  /// In en, this message translates to:
  /// **'Sites of artery occlusive lesions: Infrapopliteal'**
  String get questionBKLesionTitle;

  /// No description provided for @questionBKLesionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'infrapopliteal present or absent'**
  String get questionBKLesionSubtitle;

  /// No description provided for @questionUrgentTitle.
  ///
  /// In en, this message translates to:
  /// **'Urgent revascularisation procedures'**
  String get questionUrgentTitle;

  /// No description provided for @questionUrgentSubtitle.
  ///
  /// In en, this message translates to:
  /// **'indication for revascularization, no: elective or yes'**
  String get questionUrgentSubtitle;

  /// No description provided for @questionFeverTitle.
  ///
  /// In en, this message translates to:
  /// **'Fever'**
  String get questionFeverTitle;

  /// No description provided for @questionFeverSubtitle.
  ///
  /// In en, this message translates to:
  /// **'body temperature is higher than 38℃'**
  String get questionFeverSubtitle;

  /// No description provided for @questionAbnormalWBCTitle.
  ///
  /// In en, this message translates to:
  /// **'Abnormal WBC'**
  String get questionAbnormalWBCTitle;

  /// No description provided for @questionAbnormalWBCSubtitle.
  ///
  /// In en, this message translates to:
  /// **'white blood cell count: abnormal: > 8000 [/µl] or absent'**
  String get questionAbnormalWBCSubtitle;

  /// No description provided for @questionLocalInfectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Local Infection'**
  String get questionLocalInfectionTitle;

  /// No description provided for @questionLocalInfectionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'absent or present: the wound was suppurative or showed at least two of the following findings: heat, erythema, lymphangitis, lymph node swelling, oedema, and pain'**
  String get questionLocalInfectionSubtitle;

  /// No description provided for @questionDLTitle.
  ///
  /// In en, this message translates to:
  /// **'Dyslipidemia'**
  String get questionDLTitle;

  /// No description provided for @questionDLSubtitle.
  ///
  /// In en, this message translates to:
  /// **'absent or present:serum low density lipoprotein (LDL-C) > 140 [mg/dl]'**
  String get questionDLSubtitle;

  /// No description provided for @questionSmokingTitle.
  ///
  /// In en, this message translates to:
  /// **'Smoking Status'**
  String get questionSmokingTitle;

  /// No description provided for @questionSmokingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'no or yes: smoker or ex-smoker'**
  String get questionSmokingSubtitle;

  /// No description provided for @questionContraTitle.
  ///
  /// In en, this message translates to:
  /// **'Contralateral limb arterial occlusive lesions'**
  String get questionContraTitle;

  /// No description provided for @questionContraSubtitle.
  ///
  /// In en, this message translates to:
  /// **'absent or present: including post-treatment,'**
  String get questionContraSubtitle;

  /// No description provided for @questionOtherLesionTitle.
  ///
  /// In en, this message translates to:
  /// **'Other vascular lesions except contralateral limb'**
  String get questionOtherLesionTitle;

  /// No description provided for @questionOtherLesionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'absent or present'**
  String get questionOtherLesionSubtitle;

  /// No description provided for @questionRutherfordTitle.
  ///
  /// In en, this message translates to:
  /// **'Rutherford Classification'**
  String get questionRutherfordTitle;

  /// No description provided for @questionRutherfordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'classes 4, 5, or 6'**
  String get questionRutherfordSubtitle;

  /// No description provided for @questionSummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Patient Data Summary'**
  String get questionSummaryTitle;

  /// No description provided for @questionSummarySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Check items'**
  String get questionSummarySubtitle;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @ambulatory.
  ///
  /// In en, this message translates to:
  /// **'Ambulatory'**
  String get ambulatory;

  /// No description provided for @wheelchair.
  ///
  /// In en, this message translates to:
  /// **'WheelChair'**
  String get wheelchair;

  /// No description provided for @immobile.
  ///
  /// In en, this message translates to:
  /// **'Immobile'**
  String get immobile;

  /// No description provided for @normal.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get normal;

  /// No description provided for @g3.
  ///
  /// In en, this message translates to:
  /// **'G3'**
  String get g3;

  /// No description provided for @g4.
  ///
  /// In en, this message translates to:
  /// **'G4'**
  String get g4;

  /// No description provided for @g5.
  ///
  /// In en, this message translates to:
  /// **'G5'**
  String get g5;

  /// No description provided for @g5D.
  ///
  /// In en, this message translates to:
  /// **'G5D'**
  String get g5D;

  /// No description provided for @noMalignancy.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get noMalignancy;

  /// No description provided for @pastHistory.
  ///
  /// In en, this message translates to:
  /// **'Past History'**
  String get pastHistory;

  /// No description provided for @underTreatment.
  ///
  /// In en, this message translates to:
  /// **'UnderTreatment'**
  String get underTreatment;

  /// No description provided for @class4.
  ///
  /// In en, this message translates to:
  /// **'Class 4'**
  String get class4;

  /// No description provided for @class5.
  ///
  /// In en, this message translates to:
  /// **'Class 5'**
  String get class5;

  /// No description provided for @class6.
  ///
  /// In en, this message translates to:
  /// **'Class 6'**
  String get class6;

  /// No description provided for @formErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Please enter value.'**
  String get formErrorMessage;

  /// No description provided for @invalidValueMessage.
  ///
  /// In en, this message translates to:
  /// **'Invalid Value'**
  String get invalidValueMessage;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @analysisDefaultErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Error! Check patient data.'**
  String get analysisDefaultErrorMessage;

  /// No description provided for @analysisNullErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Error! Missing some data at Number Form.'**
  String get analysisNullErrorMessage;

  /// No description provided for @analysisLesionErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Error! Check Lesions choice.'**
  String get analysisLesionErrorMessage;

  /// No description provided for @references.
  ///
  /// In en, this message translates to:
  /// **'References'**
  String get references;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @tapToOpenLink.
  ///
  /// In en, this message translates to:
  /// **'Tap to open link.'**
  String get tapToOpenLink;

  /// No description provided for @appLegalese.
  ///
  /// In en, this message translates to:
  /// **'2022 Kazuhiro Miyahara, JSVS, JCLIMB'**
  String get appLegalese;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @en.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get en;

  /// No description provided for @ja.
  ///
  /// In en, this message translates to:
  /// **'日本語'**
  String get ja;

  /// No description provided for @analysis.
  ///
  /// In en, this message translates to:
  /// **'Analysis'**
  String get analysis;

  /// No description provided for @result.
  ///
  /// In en, this message translates to:
  /// **'Predicted Risks'**
  String get result;

  /// No description provided for @gnri.
  ///
  /// In en, this message translates to:
  /// **'GNRI'**
  String get gnri;

  /// No description provided for @gnriDesctiption.
  ///
  /// In en, this message translates to:
  /// **'Geriatric Nutritional Risk Index'**
  String get gnriDesctiption;

  /// No description provided for @predicted30DAD.
  ///
  /// In en, this message translates to:
  /// **'Predicted 30-day Amputation/Death'**
  String get predicted30DAD;

  /// No description provided for @predicted30DADDescription.
  ///
  /// In en, this message translates to:
  /// **'Predicted risk of major amputation and/or death 30 days after revascularization'**
  String get predicted30DADDescription;

  /// No description provided for @predicted30DMALE.
  ///
  /// In en, this message translates to:
  /// **'Predicted 30-day MALE'**
  String get predicted30DMALE;

  /// No description provided for @predicted30DMALEDescription.
  ///
  /// In en, this message translates to:
  /// **'Predicted risk of  major adverse limb event 30 days after revascularization.\n*MALE: major adverse limb events; above-ankle amputation of the index limb or major reintervention (new bypass graft, jump/ interposition graft revision, or thrombectomy/thrombolysis)'**
  String get predicted30DMALEDescription;

  /// No description provided for @predicted2yrOS.
  ///
  /// In en, this message translates to:
  /// **'Predicted 2-year OS'**
  String get predicted2yrOS;

  /// No description provided for @predicted2yrOSDescription.
  ///
  /// In en, this message translates to:
  /// **'Predicted 2 year Overall Survival post-revascularisation'**
  String get predicted2yrOSDescription;

  /// No description provided for @predicted2yrAFS.
  ///
  /// In en, this message translates to:
  /// **'Predicted 2-year AFS'**
  String get predicted2yrAFS;

  /// No description provided for @predicted2yrAFSDescription.
  ///
  /// In en, this message translates to:
  /// **'Predicted 2 year Amputation Free Survival post-revascularisation'**
  String get predicted2yrAFSDescription;

  /// No description provided for @gnriNoRisk.
  ///
  /// In en, this message translates to:
  /// **'No Risk'**
  String get gnriNoRisk;

  /// No description provided for @gnriLowRisk.
  ///
  /// In en, this message translates to:
  /// **'Low Risk'**
  String get gnriLowRisk;

  /// No description provided for @gnriModerateRisk.
  ///
  /// In en, this message translates to:
  /// **'Moderate Risk'**
  String get gnriModerateRisk;

  /// No description provided for @gntiMajorRisk.
  ///
  /// In en, this message translates to:
  /// **'Major Risk'**
  String get gntiMajorRisk;

  /// No description provided for @osLowRisk.
  ///
  /// In en, this message translates to:
  /// **'Low Risk'**
  String get osLowRisk;

  /// No description provided for @osMediumRisk.
  ///
  /// In en, this message translates to:
  /// **'Medium Risk'**
  String get osMediumRisk;

  /// No description provided for @osHighRisk.
  ///
  /// In en, this message translates to:
  /// **'High Risk'**
  String get osHighRisk;

  /// No description provided for @appTerms.
  ///
  /// In en, this message translates to:
  /// **'Terms of service'**
  String get appTerms;

  /// No description provided for @refreshButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Refresh Question Form'**
  String get refreshButtonLabel;

  /// No description provided for @summaryButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Move to Summary'**
  String get summaryButtonLabel;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ja'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'ja': return AppLocalizationsJa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
