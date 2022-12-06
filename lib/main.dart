import 'dart:async';

import 'package:clti_risk/widgets/risk_view.dart';
import 'package:flutter/material.dart';

import 'models/clinical_data_controller.dart';
import 'models/patient_data.dart';
import 'models/patient_risk.dart';
import 'models/questions.dart';
import 'widgets/question_form.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
  final String title = 'CLiTICAL';
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
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: MaterialApp(
          title: title,
          theme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: jsvsColor,
            //fontFamily: 'Noto Sans JP',
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            colorSchemeSeed: jsvsColor,
            //fontFamily: 'Noto Sans JP',
          ),
          themeMode: ThemeMode.system,
          home: ClinicalDataController(
              patientData: pd,
              onRiskCalculated: onRiskCalculated,
              child: Navigator(
                pages: [
                  MaterialPage(
                    key: const ValueKey('Question'),
                    child: QuestionForm(
                      title: 'Patient Data',
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
                      appName: 'CLiTICAL',
                      ageController: ageController,
                      heightController: heightController,
                      weightController: weightController,
                      albController: albController,
                    ),
                  ),
                  if (risk != null)
                    MaterialPage(
                        key: const ValueKey('Result'),
                        child: RiskView(title: 'Predicted Risk', risk: risk!)),
                ],
                onPopPage: (route, result) {
                  if (!route.didPop(result)) return false;
                  //setState(() {
                  //   _init();
                  //});
                  return true;
                },
              ))),
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
      icon: const Icon(Icons.refresh_outlined),
      onPressed: () {
        if (onPressed != null) onPressed;
        final tabController = DefaultTabController.of(context);
        if (tabController == null) throw NullThrownError();
        tabController.animateTo(0);
      },
    );
  }
}

class SummaryViewer extends StatelessWidget {
  const SummaryViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.summarize_outlined),
      onPressed: () {
        final tabController = DefaultTabController.of(context);
        if (tabController == null) throw NullThrownError();
        tabController.animateTo(Questions.summary.index);
      },
    );
  }
}
