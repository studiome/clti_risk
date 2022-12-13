class PatientData {
  //basic info
  Sex sex = Sex.female;
  int? age; //years
  double? weight; //kg
  double? height; //m
  double? alb; //albumin g/dl
  Activity activity = Activity.ambulatory;

  //clinical info

  // congestive heart failure
  bool hasCHF = false;

  // cerebral vascular disease
  bool hasCVD = false;

  // chronic kidney disease classification
  CKD ckd = CKD.normal;

  // malignant neoplasm
  MalignantNeoplasm malignant = MalignantNeoplasm.no;

  // arterial occlusive lesion: AorotIliac, FP, below Pop
  bool hasAILesion = true;
  bool hasFPLesion = false;
  bool hasBKLesion = false;

  // EJEVS occlusive classification
  // | AI | FP | BK | 2yr occlusive lesion
  // | +  | +- | +- | AI
  // | -  | +  | +- | FP without AI
  // | -  | -  | +  | Below IP
  // | -  | -  | -  | undefined

  // urgent procedure
  bool isUrgent = false;

  // BT over 38 deg celsius
  bool hasFever = false;

  // WBC over 8000/ul
  bool hasAbnormalWBC = false;

  // infection
  bool hasLocalInfection = false;

  // high LDL-C or TG
  bool hasDyslipidemia = false;

  // smoking status
  bool isSmoking = false;

  // coronary artery disease
  bool hasCAD = false;

  // contraLateral limb arterial lesions
  bool hasContraLateralLesion = false;

  // other vascular lesions except contralateral limb
  bool hasOtherVD = false;

  //Rutherford Classification 4, 5,6
  RutherfordClassification rutherford = RutherfordClassification.class4;

//constructor with dummy data
  PatientData();
}

enum Sex {
  male(),
  female();
}

enum Activity {
  ambulatory(),
  wheelchair(),
  immobile();
}

enum CKD {
  normal(), //eGFR over 60ml/min.1.73m2
  g3(), // 30 <= eGFR < 60
  g4(), // 15<= eGFR <  30
  g5(), // <15
  g5D(); // < 15 HD
}

enum MalignantNeoplasm {
  no(),
  pastHistory(),
  underTreatment();
}

enum RutherfordClassification {
  class4(),
  class5(),
  class6();
}
