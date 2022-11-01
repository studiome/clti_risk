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
  bool hasFever = false; // BT over 38 deg celsius
  bool hasLeukocytosis = false; //WBC over 8000/ul
  bool hasLocalInfection = false;

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

enum OcclusiveLesion {
  ai('Aorto-Iliac'),
  fpWithoutAI('Femoropopliteal without Aorto-Iliac'),
  belowIP('InfraPopliteal');

  const OcclusiveLesion(this.name);
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
