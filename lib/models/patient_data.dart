class PatientData {
  //basic info
  Sex sex = Sex.female;
  int age = 65; //years
  double weight = 50.0; //kg
  double height = 1.50; //m
  double alb = 4.0; //albumin g/dl
  Activity activity = Activity.ambulatory;

  //clinical info

  // congestive heart failure
  bool hasCHF = false;

  // cerebral vasuclar disease
  bool hasCVD = false;

  // chroic kidney disease classification
  CKD ckd = CKD.normal;

  // malignant neoplasm
  MalignantNeoplasm mn = MalignantNeoplasm.no;

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
  bool hasLeukocytosis = false;

  // infection
  bool hasLocalInfection = false;

  // high LDL-C or TG
  bool hasDislipidemia = false;

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
  male('Male'),
  female('Female');

  final String name;
  const Sex(this.name);

  @override
  String toString() => name;
}

enum Activity {
  ambulatory('Ambulatory'),
  wheelchair('Wheelchair'),
  immobile('Immobile');

  const Activity(this.name);
  final String name;

  @override
  String toString() => name;
}

enum CKD {
  normal('No'), //eGFR over 60ml/min.1.73m2
  g3('G3'), // 30 <= eGFR < 60
  g4('G4'), // 15<= eGFR <  30
  g5('G5'), // <15
  g5D('G5D'); // < 15 HD

  const CKD(this.name);
  final String name;

  @override
  String toString() => name;
}

enum MalignantNeoplasm {
  no('No'),
  pastHistory('Past History'),
  underTreatment('Under Treatment');

  const MalignantNeoplasm(this.name);
  final String name;

  @override
  String toString() => name;
}

enum RutherfordClassification {
  class4('Class 4'),
  class5('Class 5'),
  class6('Class 6');

  const RutherfordClassification(this.name);
  final String name;

  @override
  String toString() => name;
}
