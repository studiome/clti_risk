// ignore_for_file: avoid_print

import 'dart:math';

import 'package:clti_risk/models/patient_data.dart';
import 'package:flutter/foundation.dart';

class PatientRisk {
  final PatientData patientData;
  late double gnri; // geriatric nutritional risk index
  GNRIRisk? gnriRisk;
  late double predictedOS; //2yr OS;
  late double predictedAFS; //2yr AFS;
  late OSRisk osRisk;

  PatientRisk({required this.patientData}) {
    gnri = _calcGNRI();
    gnriRisk = _classifyGNRIRisk(gnri);
    predictedOS = _calcOS();
    predictedAFS = _calsAFS();
    osRisk = _classifyOSRisk(predictedOS);
  }

  double _calcGNRI() {
    if (patientData.height == 0.0) return double.nan;
    try {
      double v = 14.89 * patientData.alb +
          41.7 * patientData.weight / (22 * pow(patientData.height, 2));
      return v;
    } catch (e) {
      if (kDebugMode) print(e);
      return double.nan;
    }
  }

  GNRIRisk? _classifyGNRIRisk(double gnri) {
    if (gnri.isNaN) return null;
    if (gnri >= 98) {
      return GNRIRisk.noRisk;
    } else if (gnri >= 92) {
      return GNRIRisk.low;
    } else if (gnri >= 82) {
      return GNRIRisk.moderate;
    } else {
      return GNRIRisk.major;
    }
  }

  double _calcOS() {
    return 0.0;
  }

  double _calsAFS() {
    return 0.0;
  }

  OSRisk _classifyOSRisk(double overallSuvival) {
    if (overallSuvival >= 70.0) {
      return OSRisk.low;
    } else if (overallSuvival >= 50.0) {
      return OSRisk.medium;
    } else {
      return OSRisk.low;
    }
  }
}

enum OSRisk {
  high, // risk < 50%
  medium, // 50% <= risk < 70%
  low, // 70% <= risk
}

enum GNRIRisk {
  major, // gnri < 82
  moderate, // 82<= gnri < 92
  low, // 92<= gnri < 98
  noRisk, // 98 <= gnri
}
