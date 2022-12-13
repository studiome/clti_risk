import 'dart:async';

import 'package:flutter/material.dart';

import '../models/patient_data.dart';
import '../models/patient_risk.dart';

class ClinicalDataController extends InheritedWidget {
  final PatientData patientData;
  final StreamController<PatientRisk?> onRiskCalculated;

  const ClinicalDataController(
      {super.key,
      required this.patientData,
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
