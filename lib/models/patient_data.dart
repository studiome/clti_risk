class PatientData {
  //basic info
  Sex sex = Sex.female;
  int age = 65; //years
  double weight = 50.0; //kg
  double height = 1.50; //m
  double alb = 4.0; //albumin g/dl
  Activity activity = Activity.ambulatory;

  //clinical info
  bool hasCHF = false; // congestive heart failure
  bool hasCVD = false; //cerebral vasuclar disease
  CKD ckd = CKD.normal; //chroic kidney disease classification
  MalignantNeoplasm mn = MalignantNeoplasm.no; // Malignant neoplasm
  OcclusiveLesion occlusiveLesion = OcclusiveLesion.ai;
  bool isUrgent = false; //urgent procedure
  bool hasFeverUp = false; // BT over 38 deg celsius
  bool hasLeukocytosis = false; //WBC over 8000/ul
  bool hasLocalInfection = false;

//constructor with dummy data
  PatientData();
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

enum MalignantNeoplasm {
  no, //having no MN
  pastHistory, //having past history
  uderTreatment, //under treatment
}
