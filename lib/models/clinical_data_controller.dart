import 'package:flutter/material.dart';

import 'patient_data.dart';

class ClinicalDataController extends InheritedWidget {
  final PatientData patientData;

  const ClinicalDataController(
      {super.key, required this.patientData, required Widget child})
      : super(child: child);

  static ClinicalDataController? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ClinicalDataController>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
