class PatientData {
  //basic info
  Sex sex;
  int age; //years
  double weight; //kg
  double height; //m
  double alb; //albumin g/dl
  Activity activity;

  //clinical info
  bool hasCAD = false; // coronary artery disease
  bool hasCHF = false; // congestive heart failure
  CKD ckd = CKD.normal; //chroic kidney disease classification
  bool hasMN = false; // Malignant neoplasm
  OcclusiveLesion occlusiveLesion = OcclusiveLesion.ai;
  bool isUrgent = false; //urgent procedure
  bool hasFeverUp = false; // BT over 38 deg celsius
  bool hasLeukocytosis = false; //WBC over 8000/ul
  bool hasLocalInfection = false;

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
