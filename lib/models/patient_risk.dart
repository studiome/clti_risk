import 'dart:math';

import 'package:flutter/foundation.dart';

import 'patient_data.dart';

class PatientRisk {
  final PatientData patientData;
  late double gnri; // geriatric nutritional risk index
  GNRIRisk? gnriRisk;
  late double predictedOS; //2yr OS;
  late double predictedAFS; //2yr AFS;
  late OSRisk? osRisk;
  late double predicted30DDeathOrAmputation;
  late double predicted30DMALE;

  PatientRisk({required this.patientData}) {
    gnri = _calcGNRI();
    gnriRisk = _classifyGNRIRisk(gnri);
    predictedOS = _calcPredictedOS(patientData);
    predictedAFS = _calcPredictedAFS(patientData);
    osRisk = _classifyOSRisk(predictedOS);
    predicted30DDeathOrAmputation = _calc30DDorA(patientData);
    predicted30DMALE = _calc30DMALE(patientData);
  }

  double _calcGNRI() {
    if (patientData.height == 0.0) return double.nan;
    try {
      double wi = patientData.weight / (22.0 * pow(patientData.height, 2));
      if (wi >= 1.0) wi = 1.0;
      double v = 14.89 * patientData.alb + 41.7 * wi;
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

  double _calcPredictedOS(PatientData data) {
    double sigma = _calcSigma(data, osCoeff);

    return pow(osH0Coeff, exp(sigma)).toDouble();
  }

  double _calcPredictedAFS(PatientData data) {
    double sigma = _calcSigma(data, afsCoeff);
    return pow(afsH0Coeff, exp(sigma)).toDouble();
  }

  OSRisk? _classifyOSRisk(double overallSuvival) {
    if (overallSuvival.isNaN) return null;
    if (overallSuvival >= 0.70) {
      return OSRisk.low;
    } else if (overallSuvival >= 0.50) {
      return OSRisk.medium;
    } else {
      return OSRisk.high;
    }
  }

  double _calc30DDorA(PatientData data) {
    double sigma = _calcSigma(data, shortDeadOrAmputationCoeff);
    return 1.0 / (1.0 + exp(sigma));
  }

  double _calc30DMALE(PatientData data) {
    double sigma = _calcSigma(data, shortMALECoeff);
    return 1.0 / (1.0 + exp(sigma));
  }

  double _calcSigma(PatientData data, Map<Covariants, double> coeff) {
    double sigma = 0.0;

    //coeff returns non null
    //sex
    if (data.sex == Sex.female) sigma += coeff[Covariants.isFemale]!;

    //age
    if (data.age >= 85) {
      sigma += coeff[Covariants.ageOver85]!;
    } else if (data.age >= 75) {
      sigma += coeff[Covariants.age75to84]!;
    } else if (data.age >= 65) {
      sigma += coeff[Covariants.age65to74]!;
    }

    //CHF
    if (data.hasCHF) sigma += coeff[Covariants.hasCHF]!;

    //CVD
    if (data.hasCVD) sigma += coeff[Covariants.hasCVD]!;

    //CKD
    switch (data.ckd) {
      case CKD.g3:
        sigma += coeff[Covariants.hasCKDG3]!;
        break;
      case CKD.g4:
        sigma += coeff[Covariants.hasCKDG4]!;
        break;
      case CKD.g5:
        sigma += coeff[Covariants.hasCKDG5]!;
        break;
      case CKD.g5D:
        sigma += coeff[Covariants.hasCKDG5D]!;
        break;
      default:
        break;
    }

    //GNRI
    // if GNRI is not caliculated, return NaN
    if (gnriRisk == null) return double.nan;

    switch (gnriRisk) {
      case GNRIRisk.noRisk:
      case GNRIRisk.low:
        sigma += coeff[Covariants.gnriNoOrLow]!;
        break;
      case GNRIRisk.moderate:
        sigma += coeff[Covariants.gnriModerate]!;
        break;
      case GNRIRisk.major:
        sigma += coeff[Covariants.gnriMajor]!;
        break;
      default:
        break;
    }

    //Activity
    switch (data.activity) {
      case Activity.wheelchair:
        sigma += coeff[Covariants.activityWheelChair]!;
        break;
      case Activity.immobile:
        sigma += coeff[Covariants.activityImmobile]!;
        break;
      default:
        break;
    }

    //Malignancy
    switch (data.mn) {
      case MalignantNeoplasm.pastHistory:
        sigma += coeff[Covariants.pastMalignancy]!;
        break;
      case MalignantNeoplasm.underTreatment:
        sigma += coeff[Covariants.treatingMalignancy]!;
        break;
      default:
        break;
    }

    //occlusive lesion
    // EJEVS occlusive classification
    // | AI | FP | BK | 2yr occlusive lesion
    // | +  | +- | +- | AI
    // | -  | +  | +- | FP without AI
    // | -  | -  | +  | Below IP
    // | -  | -  | -  | undefined
    if (data.hasAILesion) {
      //DO nothing
    } else {
      //30days prediction
      sigma += coeff[Covariants.hasNoAIlesion]!;
      if (data.hasFPLesion) {
        // 2yr
        sigma += coeff[Covariants.lesionFP]!;
      } else {
        //30dyas
        sigma += coeff[Covariants.hasNoFPlesion]!;
        if (data.hasBKLesion) {
          //2yr
          sigma += coeff[Covariants.lesionBelowIP]!;
        }
      }
    }

    //Urgent
    if (data.isUrgent) sigma += coeff[Covariants.isUrgent]!;

    //Fever
    if (data.hasFever) sigma += coeff[Covariants.fever]!;

    //WBC
    if (data.hasLeukocytosis) sigma += coeff[Covariants.leukocytosis]!;

    //Local Infection
    if (data.hasLocalInfection) {
      sigma += coeff[Covariants.localInfection]!;
    }

    //coronary
    if (data.hasCAD) {
      sigma += coeff[Covariants.hasCAD]!;
    }

    // smoking
    if (data.isSmoking) {
      sigma += coeff[Covariants.isSmoking]!;
    }

    // contralateral
    if (data.hasContraLateralLesion) {
      sigma += coeff[Covariants.hasContralateral]!;
    }

    //  other vascular disease
    if (data.hasOtherVD) {
      sigma += coeff[Covariants.hasOther]!;
    }

    // Rutherford class
    switch (data.rutherford) {
      case RutherfordClassification.class4:
        sigma += coeff[Covariants.rutherford4]!;
        break;
      case RutherfordClassification.class5:
        sigma += coeff[Covariants.rutherford5]!;
        break;
      case RutherfordClassification.class6:
        sigma += coeff[Covariants.rutherford6]!;
        break;
    }

    sigma += coeff[Covariants.intercept]!;

    return sigma;
  }
}

enum OSRisk {
  high('High Risk'), // risk < 50%
  medium('Medium Risk'), // 50% <= risk < 70%
  low('Low Risk'); // 70% <= risk

  const OSRisk(this.name);
  final String name;

  @override
  String toString() => name;
}

enum GNRIRisk {
  major('Major Risk'), // gnri < 82
  moderate('Moderate Risk'), // 82<= gnri < 92
  low('Low Risk'), // 92<= gnri < 98
  noRisk('No Risk'); // 98 <= gnri

  const GNRIRisk(this.name);
  final String name;

  @override
  String toString() => name;
}

//Covariants for predictor
// age less than 65, without CKD, ambulatory(activity),
// no malignancy are setted to reference.
enum Covariants {
  isFemale,
  age65to74,
  age75to84,
  ageOver85,
  hasCHF,
  hasCVD,
  hasCKDG3,
  hasCKDG4,
  hasCKDG5,
  hasCKDG5D, //HD
  gnriNoOrLow,
  gnriModerate,
  gnriMajor,
  activityWheelChair,
  activityImmobile,
  pastMalignancy,
  treatingMalignancy,
  isUrgent,
  fever,
  leukocytosis,
  localInfection,
  hasCAD,
  isSmoking,
  hasNoAIlesion,
  hasNoFPlesion,
  lesionFP,
  lesionBelowIP,
  hasContralateral,
  hasOther,
  rutherford4,
  rutherford5,
  rutherford6,
  intercept,
}

const osH0Coeff = 0.922;

const Map<Covariants, double> osCoeff = {
  Covariants.isFemale: -0.25,
  Covariants.age65to74: 0.31,
  Covariants.age75to84: 0.76,
  Covariants.ageOver85: 1.04,
  Covariants.hasCHF: 0.50,
  Covariants.hasCVD: 0.0,
  Covariants.hasCKDG3: 0.27,
  Covariants.hasCKDG4: 0.61,
  Covariants.hasCKDG5: 0.76,
  Covariants.hasCKDG5D: 1.01, //HD
  Covariants.gnriNoOrLow: 0.0,
  Covariants.gnriModerate: 0.14,
  Covariants.gnriMajor: 0.52,
  Covariants.activityWheelChair: 0.28,
  Covariants.activityImmobile: 0.77,
  Covariants.pastMalignancy: 0.20,
  Covariants.treatingMalignancy: 0.56,
  Covariants.isUrgent: 0.0,
  Covariants.fever: 0.0,
  Covariants.leukocytosis: 0.0,
  Covariants.localInfection: 0.0,
  Covariants.hasCAD: 0.0,
  Covariants.isSmoking: 0.0,
  Covariants.hasNoAIlesion: 0.0,
  Covariants.hasNoFPlesion: 0.0,
  Covariants.lesionFP: -0.07,
  Covariants.lesionBelowIP: 0.16,
  Covariants.hasContralateral: 0.0,
  Covariants.hasOther: 0.0,
  Covariants.rutherford4: 0.0,
  Covariants.rutherford5: 0.0,
  Covariants.rutherford6: 0.0,
  Covariants.intercept: 0.0,
};

const osBetaCoeff = [
  -0.25,
  0.31,
  0.76,
  1.04,
  0.50,
  0.0,
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
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
];
const afsH0Coeff = 0.876;

const Map<Covariants, double> afsCoeff = {
  Covariants.isFemale: -0.21,
  Covariants.age65to74: 0.19,
  Covariants.age75to84: 0.42,
  Covariants.ageOver85: 0.62,
  Covariants.hasCHF: 0.41,
  Covariants.hasCVD: 0.10,
  Covariants.hasCKDG3: 0.16,
  Covariants.hasCKDG4: 0.36,
  Covariants.hasCKDG5: 0.73,
  Covariants.hasCKDG5D: 0.81, //HD
  Covariants.gnriNoOrLow: 0.0,
  Covariants.gnriModerate: 0.09,
  Covariants.gnriMajor: 0.45,
  Covariants.activityWheelChair: 0.37,
  Covariants.activityImmobile: 0.78,
  Covariants.pastMalignancy: 0.15,
  Covariants.treatingMalignancy: 0.39,
  Covariants.isUrgent: 0.34,
  Covariants.fever: 0.36,
  Covariants.leukocytosis: 0.19,
  Covariants.localInfection: 0.15,
  Covariants.hasCAD: 0.0,
  Covariants.isSmoking: 0.0,
  Covariants.hasNoAIlesion: 0.0,
  Covariants.hasNoFPlesion: 0.0,
  Covariants.lesionFP: -0.07,
  Covariants.lesionBelowIP: 0.15,
  Covariants.hasContralateral: 0.0,
  Covariants.hasOther: 0.0,
  Covariants.rutherford4: 0.0,
  Covariants.rutherford5: 0.0,
  Covariants.rutherford6: 0.0,
  Covariants.intercept: 0.0,
};

const afsBetaCoeff = [
  -0.21,
  0.19,
  0.42,
  0.62,
  0.41,
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
  -0.07,
  0.15,
  0.34,
  0.36,
  0.19,
  0.15,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
];

const Map<Covariants, double> shortDeadOrAmputationCoeff = {
  Covariants.isFemale: 0.0,
  Covariants.age65to74: 0.0,
  Covariants.age75to84: 0.0,
  Covariants.ageOver85: 0.0,
  Covariants.hasCHF: 0.0,
  Covariants.hasCVD: 0.0,
  Covariants.hasCKDG3: 0.0,
  Covariants.hasCKDG4: 0.0,
  Covariants.hasCKDG5: 0.0,
  Covariants.hasCKDG5D: 0.0, //HD
  Covariants.gnriNoOrLow: 0.0,
  Covariants.gnriModerate: 0.0,
  Covariants.gnriMajor: 0.0,
  Covariants.activityWheelChair: 0.0,
  Covariants.activityImmobile: 0.0,
  Covariants.pastMalignancy: 0.0,
  Covariants.treatingMalignancy: 0.0,
  Covariants.isUrgent: 0.0,
  Covariants.fever: 0.0,
  Covariants.leukocytosis: 0.0,
  Covariants.localInfection: 0.0,
  Covariants.hasCAD: 0.0,
  Covariants.isSmoking: 0.0,
  Covariants.hasNoAIlesion: 0.0,
  Covariants.hasNoFPlesion: 0.0,
  Covariants.lesionFP: 0.0,
  Covariants.lesionBelowIP: 0.0,
  Covariants.hasContralateral: 0.0,
  Covariants.hasOther: 0.0,
  Covariants.rutherford4: 0.0,
  Covariants.rutherford5: 0.0,
  Covariants.rutherford6: 0.0,
  Covariants.intercept: 0.0,
};
const shortDorACoeff = [
  0.0,
  0.0,
  0.0,
  0.0,
  -0.39,
  -0.05,
  0.0,
  -0.60,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  -0.65,
  -0.39,
  0.0,
  0.0,
  0.0,
  0.0,
  -0.34,
  -0.144,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  2.86452,
];

const Map<Covariants, double> shortMALECoeff = {
  Covariants.isFemale: 0.0,
  Covariants.age65to74: 0.0,
  Covariants.age75to84: 0.0,
  Covariants.ageOver85: 0.0,
  Covariants.hasCHF: 0.0,
  Covariants.hasCVD: 0.0,
  Covariants.hasCKDG3: 0.0,
  Covariants.hasCKDG4: 0.0,
  Covariants.hasCKDG5: 0.0,
  Covariants.hasCKDG5D: 0.0, //HD
  Covariants.gnriNoOrLow: 0.0,
  Covariants.gnriModerate: 0.0,
  Covariants.gnriMajor: 0.0,
  Covariants.activityWheelChair: 0.0,
  Covariants.activityImmobile: 0.0,
  Covariants.pastMalignancy: 0.0,
  Covariants.treatingMalignancy: 0.0,
  Covariants.isUrgent: 0.0,
  Covariants.fever: 0.0,
  Covariants.leukocytosis: 0.0,
  Covariants.localInfection: 0.0,
  Covariants.hasCAD: 0.0,
  Covariants.isSmoking: 0.0,
  Covariants.hasNoAIlesion: 0.0,
  Covariants.hasNoFPlesion: 0.0,
  Covariants.lesionFP: 0.0,
  Covariants.lesionBelowIP: 0.0,
  Covariants.hasContralateral: 0.0,
  Covariants.hasOther: 0.0,
  Covariants.rutherford4: 0.0,
  Covariants.rutherford5: 0.0,
  Covariants.rutherford6: 0.0,
  Covariants.intercept: 0.0,
};
