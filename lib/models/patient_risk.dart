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

//Covariants Index of 2Yr OS and AFS
// age less than 65, without CKD, ambulatory(activity),
// no malignancy are setted to reference.
enum Covariants {
  isFemale,
  age65to74,
  age75to84,
  ageOver85,
  hasCHF,
  hasCKDG3,
  hasCKDG4,
  hasCDKg5,
  hasCKDg5d,
  gnriModerate,
  gnriMajor,
  activityWheelChair,
  activityImmobile,
  pastMalignancy,
  treatingMalignancy,
  lesionFP,
  lesionBelowIP,
  isUrgent,
  feverUp,
  leukocytosis,
  localInfection,
}

const OS_H0_Coeff = 0.922;

const OS_Beta_Coeff = [
  -0.25,
  0.31,
  0.76,
  1.04,
  0.50,
  0.27,
  0.61,
  0.76,
  1.01,
  0.14,
  0.52,
  0.28,
  0.77,
  0.20,
  0.56,
  -0.07,
  0.16,
  0.0,
  0.0,
  0.0,
  0.0,
];
const AFS_H0_Coeff = 0.876;

const AFS_Beta_Coeff = [
  -0.21,
  0.19,
  0.42,
  0.62,
  0.10,
  0.16,
  0.36,
  0.73,
  0.81,
  0.09,
  0.45,
  0.37,
  0.78,
  0.15,
  0.39,
  0.34,
  0.36,
  0.19,
  0.15,
  -0.07,
  0.15,
];
