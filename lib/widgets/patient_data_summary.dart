import 'package:flutter/material.dart';

import '../models/clinical_data_controller.dart';

class PatientDataSummary extends StatelessWidget {
  final TextEditingController ageController;
  final TextEditingController heightController;
  final TextEditingController weightController;
  final TextEditingController albController;
  const PatientDataSummary(
      {super.key,
      required this.ageController,
      required this.heightController,
      required this.weightController,
      required this.albController});

  @override
  Widget build(BuildContext context) {
    final c = ClinicalDataController.of(context);
    if (c == null) throw NullThrownError();
    final pd = c.patientData;
    // TODO: implement build
    throw UnimplementedError();
  }
}
