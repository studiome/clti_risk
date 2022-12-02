import 'package:clti_risk/models/clinical_data_controller.dart';
import 'package:clti_risk/models/patient_data.dart';
import 'package:flutter/material.dart';

import 'widgets/question_form.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

const Color jsvsColor = Color(0xFF2D6A7B);

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final PatientData pd = PatientData();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController albController = TextEditingController();
  final String title = 'CLiTICAL';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
            risk: null,
            child: QuestionForm(
              title: 'Patient Data',
              appName: 'CLiTICAL',
              ageController: ageController,
              heightController: heightController,
              weightController: weightController,
              albController: albController,
            )));
  }
}
