import 'package:flutter/material.dart';

import 'patient_data.dart';

class ClinicalDataController extends InheritedWidget {
  final ValueNotifier<PatientData> data;
  final PatientData patientData;

  ClinicalDataController(
      {super.key, required this.patientData, required Widget child})
      : data = ValueNotifier(patientData),
        super(child: child);

  static ClinicalDataController? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ClinicalDataController>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
