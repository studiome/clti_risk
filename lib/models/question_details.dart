import 'questions.dart';

enum Description {
  title,
  subtitle,
}

const Map<Questions, Map<Description, String>> questionDetail = {
  Questions.sex: {
    Description.title: 'Sex',
    Description.subtitle: 'Male or Female'
  },
  Questions.height: {
    Description.title: 'Body Height',
    Description.subtitle: 'Enter body height [m]'
  },
  Questions.weight: {
    Description.title: 'Body Weight',
    Description.subtitle: 'Enter body weight [kg]'
  },
  Questions.albumin: {
    Description.title: 'Serum Albumin',
    Description.subtitle: 'Enter albumin [g/dl]'
  },
  Questions.activity: {
    Description.title: 'Activity',
    Description.subtitle:
        'Ambulatory: able to walk, Wheelchair: unable to walk but could stand on their own legs during bed to wheelchair transfer, Immobile: full assistance is indispensable',
  },
  Questions.chf: {
    Description.title: 'Congestive heart failure',
    Description.subtitle:
        'absent or present: a history of admission due to CHF or clinical symptoms of CHF confirmed on echocardiography or absence of clinical symptoms but clearly reduced cardiac function on echocardiography',
  },
  Questions.cad: {
    Description.title: 'Coronary artery disease',
    Description.subtitle:
        'absent or present: myocardial infarction and/or ongoing angina or previous endovascular coronary intervention and/or coronary artery bypass surgery',
  },
  Questions.cvd: {
    Description.title: 'Cerebral vascular disease',
    Description.subtitle:
        'absent or present: stroke and/or transient ischemic attacks',
  },
  Questions.ckd: {
    Description.title: 'Chronic kidney disease (eGFR*: mL/min/1.73m\u00B2)',
    Description.subtitle:
        'absent: 60 or higher, G3: 30-59, G4: 15-29, G5: below 15, G5D: below 15 in haemodialysis.\n *eGFR: the estimated glomerular filtration rate',
  },
  Questions.malingnantNeoplasm: {
    Description.title: 'Malignant neoplasm',
    Description.subtitle:
        'absent, past history of malignant neoplasm, or present under treatment',
  },
  Questions.leasionAI: {
    Description.title: 'Sites of artery occlusive lesions: Aorto-Iliac',
    Description.subtitle: 'aorto-iliac occlusive lesion present or absent',
  },
  Questions.leasionFP: {
    Description.title: 'Sites of artery occlusive lesions: Femoro-Popliteal',
    Description.subtitle: 'femoro-popliteal present or absent',
  },
  Questions.leasionBK: {
    Description.title: 'Sites of artery occlusive lesions: Infrapopliteal',
    Description.subtitle: 'infrapopliteal present or absent',
  },
  Questions.urgentProcedure: {
    Description.title: 'Urgent revascularisation procedures',
    Description.subtitle: 'no: elective or yes',
  },
  Questions.fever: {
    Description.title: 'Fever',
    Description.subtitle: 'body temperature is higher than 38\u2103',
  },
  Questions.abnormalWBC: {
    Description.title: 'Abnormal WBC',
    Description.subtitle:
        'white blood cell count: abnormal: > 8000 [/ml] or absent',
  },
  Questions.localInfection: {
    Description.title: 'Local Infection',
    Description.subtitle:
        'absent or present: the wound was suppurative or showed at least two of the following findings: heat, erythema, lymphangitis, lymph node swelling, oedema, and pain',
  },
  Questions.dl: {
    Description.title: 'Dyslipidemia',
    Description.subtitle:
        'absent or present:serum low density lipoprotein (LDL-C) > 140 [mg/dl]',
  },
  Questions.smoking: {
    Description.title: 'Smoking Status',
    Description.subtitle: 'no or yes: smoker or ex-smoker',
  },
  Questions.contralateral: {
    Description.title: 'Contralateral limb arterial occlusive lesions',
    Description.subtitle: 'absent or present: including post-treatment,',
  },
  Questions.others: {
    Description.title: 'Other vascular lesions except contralateral limb',
    Description.subtitle: 'absent or present',
  },
  Questions.rutherford: {
    Description.title: 'Rutherford Classification',
    Description.subtitle: 'classes 4, 5, or 6',
  },
};
