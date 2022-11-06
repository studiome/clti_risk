import 'package:clti_risk/models/patient_data.dart';
import 'package:clti_risk/models/patient_risk.dart';
import 'package:clti_risk/widgets/patient_data_form.dart';
import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final String title;
  final PatientData patientData = PatientData();
  AppScaffold({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SafeArea(
        bottom: false,
        child: PatientDataForm(
          patientData: patientData,
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            final PatientRisk pr = PatientRisk(patientData: patientData);
            print(pr.gnri);
          },
          icon: const Icon(Icons.analytics),
          label: const Text('Calculate')),
    );
  }
}
