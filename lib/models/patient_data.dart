class PatientData {
  Sex sex;
  int age; //years
  double weight; //kg
  double height; //m
  double alb; //albumin g/dl
  Activity activity;
  bool hasCAD = false; // coronary artery disease
  bool hasCHF = false; // congestive heart failure
  CKD ckd = CKD.normal;
  bool hasCKD = false;
  bool hasMN = false; // Malignant neoplasm
  OcclusiveLesion occlusiveLesion = OcclusiveLesion.ai;
  bool isUrgent = false; //urgent procedure
  bool hasFeverUp = false; // BT over 38 deg celsius
  bool hasLeukocytosis = false; //WBC over 8000/ul
  double whiteBloodCell = 6000.0; //WBC
  bool hasLocalInfection = false;
  double predictedOS = 0.0; //2yr OS;
  double predictedAFS = 0.0; //2yr AFS;
  double gnri = 100.0; // geriatric nutritional risk index

  GNRIRisk gnriRisk = GNRIRisk.low; //GNRI Risk
  OSRisk osRisk = OSRisk.low; // 2Yr OS risk

  PatientData(
      {required this.sex,
      required this.age,
      required this.weight,
      required this.height,
      required this.alb,
      required this.activity});
}

enum Sex {
  male,
  female,
}

enum Activity {
  ambulatory,
  wheelchair,
  immobile,
}

enum OcclusiveLesion {
  ai, //aoroiliac lesion
  fpWithoutAI, //FP: femoropopliteal
  belowIP, //only below infra-popliteal
}

enum CKD {
  normal, //eGFR over 60ml/min.1.73m2
  g3, // 30 <= eGFR < 60
  g4, // 15<= eGFR <  30
  g5, // <15
  g5D, // < 15 HD
}

enum OSRisk {
  high, // risk < 50%
  medium, // 50% <= risk < 70%
  low, // 70% <= risk
}

enum GNRIRisk {
  major, // gnri < 82
  moderate, // 82<= gnri < 92
  low, // 98<= gnri
}
