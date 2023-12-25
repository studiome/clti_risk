import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/patient_data.dart';
import 'models/patient_risk.dart';
import 'models/questions.dart';
import 'widgets/clinical_data_controller.dart';
import 'widgets/locale_controller.dart';
import 'widgets/question_form.dart';
import 'widgets/risk_view.dart';

const String appName = 'CLiTICAL';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GoogleFonts.pendingFonts([
    GoogleFonts.notoSansJpTextTheme(),
  ]);
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  runApp(const AppRoot());
}

const Color jsvsColor = Color(0xFF2D6A7B);

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController albController = TextEditingController();
  LocaleController localeController = LocaleController(const Locale('ja'));
  final String title = appName;
  late PatientData pd;
  PatientRisk? risk;
  StreamController<PatientRisk?> onRiskCalculated = StreamController();

  void _init() {
    risk = null;
    pd = PatientData();
    ageController.text = '';
    heightController.text = '';
    weightController.text = '';
    albController.text = '';
  }

  @override
  void initState() {
    super.initState();
    _init();
    onRiskCalculated.stream.listen((event) {
      setState(() {
        risk = event;
      });
    });
    SharedPreferences.getInstance().then((pref) {
      final l = pref.getString('locale');
      if (l == null) {
        if (kIsWeb) {
          //localeController.value = const Locale('en');
          //return;
        }
        localeController.value = const Locale('ja');
        return;
      }
      localeController.value = Locale(l);
    });
  }

  void _dismissKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _dismissKeyboard(context),
      child: ValueListenableBuilder<Locale>(
          valueListenable: localeController,
          builder: (c, value, _) {
            return MaterialApp(
                title: title,
                theme: ThemeData(
                    useMaterial3: true,
                    colorSchemeSeed: jsvsColor,
                    textTheme: GoogleFonts.notoSansJpTextTheme()),
                darkTheme: ThemeData(
                    useMaterial3: true,
                    brightness: Brightness.dark,
                    colorSchemeSeed: jsvsColor,
                    textTheme: GoogleFonts.notoSansJpTextTheme(
                      ThemeData(brightness: Brightness.dark).textTheme,
                    )),
                themeMode: ThemeMode.system,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                locale: localeController.value,
                home: ClinicalDataController(
                    patientData: pd,
                    onRiskCalculated: onRiskCalculated,
                    child: Navigator(
                      pages: [
                        MaterialPage(
                          key: const ValueKey('Question'),
                          child: Builder(builder: (context) {
                            return QuestionForm(
                              title: AppLocalizations.of(context)!
                                  .questionFormTitle,
                              actions: [
                                //for focusing and keyboard dismissing
                                Builder(builder: (context) {
                                  return SummaryViewer(
                                      onPressed: () =>
                                          _dismissKeyboard(context));
                                }),
                                FormInitializer(
                                  onPressed: () {
                                    setState(() {
                                      _init();
                                    });
                                  },
                                ),
                              ],
                              appName: appName,
                              ageController: ageController,
                              heightController: heightController,
                              weightController: weightController,
                              albController: albController,
                              localeController: localeController,
                            );
                          }),
                        ),
                        if (risk != null)
                          MaterialPage(
                              key: const ValueKey('Result'),
                              child: RiskView(risk: risk!)),
                      ],
                      onPopPage: (route, result) {
                        if (!route.didPop(result)) {
                          return false;
                        }
                        risk = null;
                        return true;
                      },
                    )));
          }),
    );
  }
}

class FormInitializer extends StatelessWidget {
  final void Function()? onPressed;
  const FormInitializer({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.refresh_outlined,
        semanticLabel: AppLocalizations.of(context)!.refreshButtonLabel,
      ),
      onPressed: () {
        final tabController = DefaultTabController.of(context);
        tabController.animateTo(0);
        if (onPressed != null) onPressed!();
      },
    );
  }
}

class SummaryViewer extends StatelessWidget {
  final void Function()? onPressed;
  const SummaryViewer({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.summarize_outlined,
        semanticLabel: AppLocalizations.of(context)!.summaryButtonLabel,
      ),
      onPressed: () {
        final tabController = DefaultTabController.of(context);
        tabController.animateTo(Questions.summary.index);
        if (onPressed != null) onPressed!();
      },
    );
  }
}
