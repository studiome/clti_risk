import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/locale_controller.dart';
import 'models/patient_data.dart';
import 'models/patient_risk.dart';
import 'models/questions.dart';
import 'widgets/clinical_data_controller.dart';
import 'widgets/question_form.dart';
import 'widgets/risk_view.dart';

const String appName = 'CLiTICAL';

void main() {
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
  LocaleController localeController = LocaleController(const Locale('en'));
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
        localeController.value = const Locale('en');
        return;
      }
      localeController.value = Locale(l);
    });
  }

  void _dissmissKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _dissmissKeyboard(context),
      child: ValueListenableBuilder<Locale>(
          valueListenable: localeController,
          builder: (c, value, _) {
            return MaterialApp(
                title: title,
                theme: ThemeData(
                  useMaterial3: true,
                  colorSchemeSeed: jsvsColor,
                ),
                darkTheme: ThemeData(
                  useMaterial3: true,
                  brightness: Brightness.dark,
                  colorSchemeSeed: jsvsColor,
                ),
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
                              title: AppLocalizations.of(context)
                                  .questionFormTitle,
                              actions: [
                                const SummaryViewer(),
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
        semanticLabel: AppLocalizations.of(context).refreshButtonLabel,
      ),
      onPressed: () {
        final tabController = DefaultTabController.of(context);
        if (tabController == null) throw NullThrownError();
        tabController.animateTo(0);
        if (onPressed != null) onPressed!();
      },
    );
  }
}

class SummaryViewer extends StatelessWidget {
  const SummaryViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.summarize_outlined,
        semanticLabel: AppLocalizations.of(context).summaryButtonLabel,
      ),
      onPressed: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
        final tabController = DefaultTabController.of(context);
        if (tabController == null) throw NullThrownError();
        tabController.animateTo(Questions.summary.index);
      },
    );
  }
}
