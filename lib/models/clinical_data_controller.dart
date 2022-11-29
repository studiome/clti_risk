import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'patient_data.dart';

class ClinicalDataController extends InheritedWidget {
  final ValueNotifier<PatientData> data;
  final PatientData patientData;
  final PatientDataNotifier notifier;

  ClinicalDataController(
      {super.key, required this.patientData, required Widget child})
      : data = ValueNotifier(patientData),
        notifier = PatientDataNotifier(patientData),
        super(child: child);

  static ClinicalDataController? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ClinicalDataController>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}

class PatientDataNotifier extends ChangeNotifier
    implements ValueListenable<PatientData> {
  final PatientData _value;
  PatientDataNotifier(this._value);

  void update() {
    notifyListeners();
  }

  @override
  PatientData get value => _value;
}
