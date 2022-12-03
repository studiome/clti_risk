import 'dart:async';

import 'package:flutter/material.dart';

import 'patient_data.dart';
import 'patient_risk.dart';

class ClinicalDataController extends InheritedWidget {
  final PatientData patientData;
  final StreamController<PatientRisk?> onRiskCalculated;
  final PatientRisk? risk;

  const ClinicalDataController(
      {super.key,
      required this.patientData,
      required this.risk,
      required this.onRiskCalculated,
      required Widget child})
      : super(child: child);

  static ClinicalDataController? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ClinicalDataController>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
