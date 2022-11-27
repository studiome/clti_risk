import 'dart:math';

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
    if (patientData.weight == null ||
        patientData.height == null ||
        patientData.age == null ||
        patientData.alb == null) throw const FormatException();
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
    double wi = patientData.weight! / (22.0 * pow(patientData.height!, 2));
    if (wi >= 1.0) wi = 1.0;
    double v = 14.89 * patientData.alb! + 41.7 * wi;
    return v;
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
    if (data.sex == Sex.female) sigma += coeff[Covariants.isFemale] ?? 0.0;

    //age
    if (data.age! >= 85) {
      sigma += coeff[Covariants.ageOver85] ?? 0.0;
    } else if (data.age! >= 75) {
      sigma += coeff[Covariants.age75to84] ?? 0.0;
    } else if (data.age! >= 65) {
      sigma += coeff[Covariants.age65to74] ?? 0.0;
    }

    //CHF
    if (data.hasCHF) sigma += coeff[Covariants.hasCHF] ?? 0.0;

    //CVD
    if (data.hasCVD) sigma += coeff[Covariants.hasCVD] ?? 0.0;

    //CKD
    switch (data.ckd) {
      case CKD.g3:
        sigma += coeff[Covariants.hasCKDG3] ?? 0.0;
        break;
      case CKD.g4:
        sigma += coeff[Covariants.hasCKDG4] ?? 0.0;
        break;
      case CKD.g5:
        sigma += coeff[Covariants.hasCKDG5] ?? 0.0;
        break;
      case CKD.g5D:
        sigma += coeff[Covariants.hasCKDG5D] ?? 0.0;
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
        sigma += coeff[Covariants.gnriNoOrLow] ?? 0.0;
        break;
      case GNRIRisk.moderate:
        sigma += coeff[Covariants.gnriModerate] ?? 0.0;
        break;
      case GNRIRisk.major:
        sigma += coeff[Covariants.gnriMajor] ?? 0.0;
        break;
      default:
        break;
    }

    //Activity
    switch (data.activity) {
      case Activity.ambulatory:
        sigma += coeff[Covariants.activityAmbulatory] ?? 0.0;
        break;
      case Activity.wheelchair:
        sigma += coeff[Covariants.activityWheelChair] ?? 0.0;
        break;
      case Activity.immobile:
        sigma += coeff[Covariants.activityImmobile] ?? 0.0;
        break;
      default:
        break;
    }

    //Malignancy
    switch (data.mn) {
      case MalignantNeoplasm.pastHistory:
        sigma += coeff[Covariants.pastMalignancy] ?? 0.0;
        break;
      case MalignantNeoplasm.underTreatment:
        sigma += coeff[Covariants.treatingMalignancy] ?? 0.0;
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
    //
    //30 days
    if (!data.hasAILesion) sigma += coeff[Covariants.hasNoAIlesion] ?? 0.0;
    if (!data.hasFPLesion) sigma += coeff[Covariants.hasNoFPlesion] ?? 0.0;

    //2yr
    if (data.hasAILesion) {
      //DO nothing
    } else {
      if (data.hasFPLesion) {
        sigma += coeff[Covariants.lesionFP] ?? 0.0;
      } else {
        if (data.hasBKLesion) {
          sigma += coeff[Covariants.lesionBelowIP] ?? 0.0;
        }
      }
    }

    //Urgent
    if (data.isUrgent) sigma += coeff[Covariants.isUrgent] ?? 0.0;

    //Fever
    if (data.hasFever) sigma += coeff[Covariants.fever] ?? 0.0;

    //WBC
    if (data.hasAbnormalWBC) sigma += coeff[Covariants.abnormalWBC] ?? 0.0;

    //Local Infection
    if (data.hasLocalInfection) {
      sigma += coeff[Covariants.localInfection] ?? 0.0;
    }

    //coronary
    if (data.hasCAD) {
      sigma += coeff[Covariants.hasCAD] ?? 0.0;
    }

    // smoking
    if (data.isSmoking) {
      sigma += coeff[Covariants.isSmoking] ?? 0.0;
    }

    if (data.hasDislipidemia) {
      sigma += coeff[Covariants.hasDislipidemia] ?? 0.0;
    }

    // contralateral
    if (!data.hasContraLateralLesion) {
      sigma += coeff[Covariants.hasNoContralateral] ?? 0.0;
    }

    //  other vascular disease
    if (data.hasOtherVD) {
      sigma += coeff[Covariants.hasOther] ?? 0.0;
    }

    // Rutherford class
    switch (data.rutherford) {
      case RutherfordClassification.class4:
        sigma += coeff[Covariants.rutherford4] ?? 0.0;
        break;
      case RutherfordClassification.class5:
        sigma += coeff[Covariants.rutherford5] ?? 0.0;
        break;
      case RutherfordClassification.class6:
        sigma += coeff[Covariants.rutherford6] ?? 0.0;
        break;
    }

    sigma += coeff[Covariants.intercept] ?? 0.0;

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
  activityAmbulatory,
  activityWheelChair,
  activityImmobile,
  pastMalignancy,
  treatingMalignancy,
  isUrgent,
  fever,
  abnormalWBC,
  localInfection,
  hasCAD,
  isSmoking,
  hasDislipidemia,
  hasNoAIlesion,
  hasNoFPlesion,
  lesionFP,
  lesionBelowIP,
  hasNoContralateral,
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
  Covariants.gnriModerate: 0.14,
  Covariants.gnriMajor: 0.52,
  Covariants.activityWheelChair: 0.28,
  Covariants.activityImmobile: 0.77,
  Covariants.pastMalignancy: 0.20,
  Covariants.treatingMalignancy: 0.56,
  Covariants.lesionFP: -0.07,
  Covariants.lesionBelowIP: 0.16,
};

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
  Covariants.gnriModerate: 0.09,
  Covariants.gnriMajor: 0.45,
  Covariants.activityWheelChair: 0.37,
  Covariants.activityImmobile: 0.78,
  Covariants.pastMalignancy: 0.15,
  Covariants.treatingMalignancy: 0.39,
  Covariants.isUrgent: 0.34,
  Covariants.fever: 0.36,
  Covariants.abnormalWBC: 0.19,
  Covariants.localInfection: 0.15,
  Covariants.lesionFP: -0.07,
  Covariants.lesionBelowIP: 0.15,
};

const Map<Covariants, double> shortDeadOrAmputationCoeff = {
  Covariants.intercept: 2.86452,
  Covariants.abnormalWBC: -0.59896,
  Covariants.isUrgent: -0.64861,
  Covariants.hasCHF: -0.39326,
  Covariants.fever: -0.3888,
  Covariants.hasCKDG5D: -0.33797,
  Covariants.hasNoAIlesion: -0.14474,
  Covariants.hasCVD: -0.05239,
  Covariants.hasDislipidemia: 0.05969,
  Covariants.rutherford5: 0.12638,
  Covariants.hasNoFPlesion: 0.17229,
  Covariants.gnriModerate: 0.36795,
  Covariants.activityAmbulatory: 0.54391,
  Covariants.gnriNoOrLow: 0.76479,
};

const Map<Covariants, double> shortMALECoeff = {
  Covariants.intercept: 2.2575,
  Covariants.abnormalWBC: -0.50671,
  Covariants.fever: -0.33461,
  Covariants.localInfection: -0.28088,
  Covariants.rutherford6: -0.26513,
  Covariants.activityWheelChair: -0.22555,
  Covariants.isUrgent: -0.20964,
  Covariants.hasCHF: -0.09218,
  Covariants.hasCKDG5D: -0.02024,
  Covariants.hasCVD: 0.01592,
  Covariants.hasOther: 0.02649,
  Covariants.isSmoking: 0.03109,
  Covariants.hasCAD: 0.0375,
  Covariants.rutherford5: 0.14299,
  Covariants.age75to84: 0.16816,
  Covariants.activityAmbulatory: 0.17103,
  Covariants.hasNoContralateral: 0.18822,
  Covariants.hasNoFPlesion: 0.21082,
  Covariants.hasDislipidemia: 0.2189,
  Covariants.isFemale: 0.24023,
  Covariants.gnriNoOrLow: 0.32693,
  Covariants.ageOver85: 0.46026,
  Covariants.gnriModerate: 0.46838,
};
