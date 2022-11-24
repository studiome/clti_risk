//Questions List definition, also defines list order
enum Questions {
  sex('Sex'), // boolean
  bodyMeasurement('Height/Weight'), // form
  albumin('Alb'), // form
  activity('Activity'), // enum
  chf('Congestive heart failure'), // boolean
  cad('Coronary artery disease'), // boolean
  cvd('Cerebral vascular disease'), // boolean
  ckd('Chronic kidney disease'), // boolean
  malingnantNeoplasm('Malignant neoplasm'), // enum
  leasionAI('Aorto-Iliac artery occlusion'), // boolean
  leasionFP('Femoro-Popliteal artery artery occlusion'), // boolean
  leasionBK('Infrapopliteal artery occlusion'), // boolean
  urgentProcedure('Urgent proceure'), // boolean
  fever('Fever'), // boolean
  abnormalWBC('Abnormal WBC'), // boolean
  localInfection('Local infection'),
  dl('Dyslipidemia'), //boolean
  smoking('Smoking status'), //boolean
  contralateral('Contralateral limb arterial occlusion'), // boolean
  others('Other vascular lesions except contralateral limb'), // boolean
  rutherford('Rutherford Classification'); // enum

  final String name;
  const Questions(this.name);

  @override
  String toString() => name;
}
