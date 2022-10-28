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
    predictedOS = _calcPredictedOS(patientData);
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

  double _calcPredictedOS(PatientData data) {
    double _sigma = 0.0;
    //sex
    if (data.sex == Sex.female)
      _sigma += OS_Beta_Coeff[Covariants.isFemale.index];

    //age
    if (data.age >= 85) {
      _sigma += OS_Beta_Coeff[Covariants.ageOver85.index];
    } else if (data.age >= 75) {
      _sigma += OS_Beta_Coeff[Covariants.age75to84.index];
    } else if (data.age >= 65) {
      _sigma += OS_Beta_Coeff[Covariants.age65to74.index];
    }

    //CHF
    if (data.hasCHF) _sigma += OS_Beta_Coeff[Covariants.hasCHF.index];

    //CKD
    switch (data.ckd) {
      case CKD.g3:
        _sigma += OS_Beta_Coeff[Covariants.hasCKDG3.index];
        break;
      case CKD.g4:
        _sigma += OS_Beta_Coeff[Covariants.hasCKDG4.index];
        break;
      case CKD.g5:
        _sigma += OS_Beta_Coeff[Covariants.hasCKDG5.index];
        break;
      case CKD.g5D:
        _sigma += OS_Beta_Coeff[Covariants.hasCKDG5D.index];
        break;
      default:
        break;
    }

    //GNRI
    switch (gnriRisk) {
      case GNRIRisk.moderate:
        _sigma += OS_Beta_Coeff[Covariants.gnriModerate.index];
        break;
      case GNRIRisk.major:
        _sigma += OS_Beta_Coeff[Covariants.gnriMajor.index];
        break;
      default:
        break;
    }

    //Activity
    switch (data.activity) {
      case Activity.wheelchair:
        _sigma += OS_Beta_Coeff[Covariants.activityWheelChair.index];
        break;
      case Activity.immobile:
        _sigma += OS_Beta_Coeff[Covariants.activityImmobile.index];
        break;
      default:
        break;
    }

    //Malignancy
    switch (data.mn) {
      case MalignantNeoplasm.pastHistory:
        _sigma += OS_Beta_Coeff[Covariants.pastMalignancy.index];
        break;
      case MalignantNeoplasm.uderTreatment:
        _sigma += OS_Beta_Coeff[Covariants.treatingMalignancy.index];
        break;
      default:
        break;
    }

    //occlusive lesion
    switch (data.occlusiveLesion) {
      case OcclusiveLesion.fpWithoutAI:
        _sigma += OS_Beta_Coeff[Covariants.lesionFP.index];
        break;
      case OcclusiveLesion.belowIP:
        _sigma += OS_Beta_Coeff[Covariants.lesionBelowIP.index];
        break;
      default:
        break;
    }

    return pow(OS_H0_Coeff, exp(_sigma)).toDouble();
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
  hasCKDG5,
  hasCKDG5D,
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
