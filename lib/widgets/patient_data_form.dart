import 'package:clti_risk/models/patient_risk.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/patient_data.dart';

class PatientDataForm extends StatefulWidget {
  const PatientDataForm({super.key});

  @override
  State<PatientDataForm> createState() => _PatientDataFormState();
}

enum _InputItem {
  profile,
  activity,
  chf,
  cvd,
  ckd,
  malignant,
  lesion,
  urgent,
  fever,
  leukocytosis,
  infection,
}

class _PatientDataFormState extends State<PatientDataForm> {
  PatientData patientData = PatientData();
  int _stepIndex = 0;
  final int inputMaxNumber = _InputItem.values.length;
  TextEditingController ageFormController = TextEditingController();
  TextEditingController heightFormController = TextEditingController();
  TextEditingController weightFormController = TextEditingController();
  TextEditingController albFormController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stepper(
            currentStep: _stepIndex,
            onStepCancel: () {
              if (_stepIndex == 0) return;
              setState(() {
                _stepIndex -= 1;
              });
            },
            onStepContinue: () {
              if (_stepIndex == inputMaxNumber - 1) return;
              setState(() {
                _stepIndex += 1;
              });
            },
            onStepTapped: (int i) {
              setState(() {
                _stepIndex = i;
              });
            },
            steps: [
              Step(
                title: const Text('Patient Profile'),
                subtitle: const Text(
                    'Sex, Age[yeats], Height[m], BodyWeight[kg], Albumin[g/dl]'),
                content: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text('Sex'),
                          SizedBox(
                            width: 150,
                            child: RadioListTile<Sex>(
                                title: const Text('Male'),
                                value: Sex.male,
                                groupValue: patientData.sex,
                                onChanged: (v) {
                                  if (v == null) return;
                                  setState(() {
                                    patientData.sex = v;
                                  });
                                }),
                          ),
                          SizedBox(
                            width: 150,
                            child: RadioListTile<Sex>(
                                title: const Text('Female'),
                                value: Sex.female,
                                groupValue: patientData.sex,
                                onChanged: (v) {
                                  if (v == null) return;
                                  setState(() {
                                    patientData.sex = v;
                                  });
                                }),
                          ),
                        ],
                      ),
                    ),
                    Form(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: SizedBox(
                                width: 180,
                                child: TextFormField(
                                  controller: ageFormController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Fill Age',
                                    labelText: 'Age [yrs]',
                                  ),
                                  textInputAction: TextInputAction.done,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                    signed: false,
                                    decimal: false,
                                  ),
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  autovalidateMode: AutovalidateMode.always,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Fill Age';
                                    }
                                    return null;
                                  },
                                  onFieldSubmitted: (String value) {
                                    try {
                                      patientData.age = int.parse(value);
                                    } catch (e) {
                                      //DO Nothing
                                      if (kDebugMode) print(e);
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: SizedBox(
                                width: 180,
                                child: TextFormField(
                                  controller: heightFormController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Fill Height',
                                    labelText: 'Height [m]',
                                  ),
                                  textInputAction: TextInputAction.done,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                    signed: false,
                                    decimal: true,
                                  ),
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d{1}\.?\d{0,2}')),
                                  ],
                                  autovalidateMode: AutovalidateMode.always,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Fill Height';
                                    }
                                    return null;
                                  },
                                  onFieldSubmitted: (String value) {
                                    try {
                                      patientData.height = double.parse(value);
                                    } catch (e) {
                                      //DO Nothing
                                      if (kDebugMode) print(e);
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: SizedBox(
                                width: 180,
                                child: TextFormField(
                                  controller: weightFormController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Fill Body Weight',
                                    labelText: 'Body Weight [kg]',
                                  ),
                                  textInputAction: TextInputAction.done,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                    signed: false,
                                    decimal: true,
                                  ),
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d{1,3}\.?\d{0,1}')),
                                  ],
                                  autovalidateMode: AutovalidateMode.always,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Fill Weight';
                                    }
                                    return null;
                                  },
                                  onFieldSubmitted: (String value) {
                                    try {
                                      patientData.weight = double.parse(value);
                                    } catch (e) {
                                      //DO Nothing
                                      if (kDebugMode) print(e);
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: SizedBox(
                                width: 180,
                                child: TextFormField(
                                  controller: albFormController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Fill Albumin',
                                    labelText: 'Albumin [g/dl]',
                                  ),
                                  textInputAction: TextInputAction.done,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                    signed: false,
                                    decimal: true,
                                  ),
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d{1}\.?\d{0,1}')),
                                  ],
                                  autovalidateMode: AutovalidateMode.always,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Fill Albumin';
                                    }
                                    return null;
                                  },
                                  onFieldSubmitted: (String value) {
                                    try {
                                      patientData.alb = double.parse(value);
                                    } catch (e) {
                                      //DO Nothing
                                      if (kDebugMode) print(e);
                                    }
                                  },
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                isActive: _stepIndex == _InputItem.profile.index,
                state: _stepIndex == _InputItem.profile.index
                    ? StepState.editing
                    : StepState.complete,
              ),
              Step(
                title: const Text('Actvity'),
                subtitle: const Text(
                    'ambulatory: able to walk, wheelchair: unable to walk but could stand on their own legs during bed to wheelchair transfer, immobile: full assistance was indispensable'),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 180,
                      child: RadioListTile<Activity>(
                          title: const Text('Ambulatory'),
                          value: Activity.ambulatory,
                          groupValue: patientData.activity,
                          onChanged: (v) {
                            if (v == null) return;
                            setState(() {
                              patientData.activity = v;
                            });
                          }),
                    ),
                    SizedBox(
                      width: 180,
                      child: RadioListTile<Activity>(
                          title: const Text('Wheelchair'),
                          value: Activity.wheelchair,
                          groupValue: patientData.activity,
                          onChanged: (v) {
                            if (v == null) return;
                            setState(() {
                              patientData.activity = v;
                            });
                          }),
                    ),
                    SizedBox(
                      width: 180,
                      child: RadioListTile<Activity>(
                          title: const Text('Immobile'),
                          value: Activity.immobile,
                          groupValue: patientData.activity,
                          onChanged: (v) {
                            if (v == null) return;
                            setState(() {
                              patientData.activity = v;
                            });
                          }),
                    ),
                  ],
                ),
                isActive: _stepIndex == _InputItem.activity.index,
                state: _stepIndex == _InputItem.activity.index
                    ? StepState.editing
                    : _stepIndex < _InputItem.activity.index
                        ? StepState.indexed
                        : StepState.complete,
              ),
              Step(
                title: const Text('Congestive heart failure'),
                subtitle: const Text(
                    'absent or present: a history of admission due to CHF or clinical symptoms of CHF confirmed on echo- cardiography or absence of clinical symptoms but clearly reduced cardiac function on echocardiography'),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 120,
                      child: RadioListTile<bool>(
                          title: const Text('Yes'),
                          value: true,
                          groupValue: patientData.hasCHF,
                          onChanged: (v) {
                            if (v == null) return;
                            setState(() {
                              patientData.hasCHF = v;
                            });
                          }),
                    ),
                    SizedBox(
                      width: 120,
                      child: RadioListTile<bool>(
                          title: const Text('No'),
                          value: false,
                          groupValue: patientData.hasCHF,
                          onChanged: (v) {
                            if (v == null) return;
                            setState(() {
                              patientData.hasCHF = v;
                            });
                          }),
                    ),
                  ],
                ),
                isActive: _stepIndex == _InputItem.chf.index,
                state: _stepIndex == _InputItem.chf.index
                    ? StepState.editing
                    : _stepIndex < _InputItem.chf.index
                        ? StepState.indexed
                        : StepState.complete,
              ),
              Step(
                title: const Text('Cerebral vascular disease'),
                subtitle: const Text(
                    'absent or present: stroke and/or transient ischaemic attacks'),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 120,
                      child: RadioListTile<bool>(
                          title: const Text('Yes'),
                          value: true,
                          groupValue: patientData.hasCVD,
                          onChanged: (v) {
                            if (v == null) return;
                            setState(() {
                              patientData.hasCVD = v;
                            });
                          }),
                    ),
                    SizedBox(
                      width: 120,
                      child: RadioListTile<bool>(
                          title: const Text('No'),
                          value: false,
                          groupValue: patientData.hasCVD,
                          onChanged: (v) {
                            if (v == null) return;
                            setState(() {
                              patientData.hasCVD = v;
                            });
                          }),
                    ),
                  ],
                ),
                isActive: _stepIndex == _InputItem.cvd.index,
                state: _stepIndex == _InputItem.cvd.index
                    ? StepState.editing
                    : _stepIndex < _InputItem.cvd.index
                        ? StepState.indexed
                        : StepState.complete,
              ),
              Step(
                title: const Text('Chronic kidney disease'),
                subtitle: const Text(
                    'absent, G3, G4, G5, or G5D; renal dysfunction was absent when the estimated glomerular filtration rate [eGFR] was 60 ml/min/1.73 m2 or higher, and it was graded as G3, G4, and G5 when eGFR was 30 e 59, 15 e 29, and below 15, respectively. eGFR below 15 in haemodialysis patients was graded as G5D'),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 120,
                      child: RadioListTile<CKD>(
                          title: const Text('No'),
                          value: CKD.normal,
                          groupValue: patientData.ckd,
                          onChanged: (v) {
                            if (v == null) return;
                            setState(() {
                              patientData.ckd = v;
                            });
                          }),
                    ),
                    SizedBox(
                      width: 120,
                      child: RadioListTile<CKD>(
                          title: const Text('G3'),
                          value: CKD.g3,
                          groupValue: patientData.ckd,
                          onChanged: (v) {
                            if (v == null) return;
                            setState(() {
                              patientData.ckd = v;
                            });
                          }),
                    ),
                    SizedBox(
                      width: 120,
                      child: RadioListTile<CKD>(
                          title: const Text('G4'),
                          value: CKD.g4,
                          groupValue: patientData.ckd,
                          onChanged: (v) {
                            if (v == null) return;
                            setState(() {
                              patientData.ckd = v;
                            });
                          }),
                    ),
                    SizedBox(
                      width: 120,
                      child: RadioListTile<CKD>(
                          title: const Text('G5'),
                          value: CKD.g5,
                          groupValue: patientData.ckd,
                          onChanged: (v) {
                            if (v == null) return;
                            setState(() {
                              patientData.ckd = v;
                            });
                          }),
                    ),
                    SizedBox(
                      width: 120,
                      child: RadioListTile<CKD>(
                          title: const Text('G5D'),
                          value: CKD.g5D,
                          groupValue: patientData.ckd,
                          onChanged: (v) {
                            if (v == null) return;
                            setState(() {
                              patientData.ckd = v;
                            });
                          }),
                    ),
                  ],
                ),
                isActive: _stepIndex == _InputItem.ckd.index,
                state: _stepIndex == _InputItem.ckd.index
                    ? StepState.editing
                    : _stepIndex < _InputItem.ckd.index
                        ? StepState.indexed
                        : StepState.complete,
              ),
              Step(
                title: const Text('Malignant neoplasm'),
                subtitle: const Text(
                    'absent, past history of malignant neoplasm, or present under treatment'),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 120,
                      child: RadioListTile<MalignantNeoplasm>(
                          title: const Text('No'),
                          value: MalignantNeoplasm.no,
                          groupValue: patientData.mn,
                          onChanged: (v) {
                            if (v == null) return;
                            setState(() {
                              patientData.mn = v;
                            });
                          }),
                    ),
                    SizedBox(
                      width: 180,
                      child: RadioListTile<MalignantNeoplasm>(
                          title: const Text('Past History'),
                          value: MalignantNeoplasm.pastHistory,
                          groupValue: patientData.mn,
                          onChanged: (v) {
                            if (v == null) return;
                            setState(() {
                              patientData.mn = v;
                            });
                          }),
                    ),
                    SizedBox(
                      width: 240,
                      child: RadioListTile<MalignantNeoplasm>(
                          title: const Text('Under treatment'),
                          value: MalignantNeoplasm.underTreatment,
                          groupValue: patientData.mn,
                          onChanged: (v) {
                            if (v == null) return;
                            setState(() {
                              patientData.mn = v;
                            });
                          }),
                    ),
                  ],
                ),
                isActive: _stepIndex == _InputItem.malignant.index,
                state: _stepIndex == _InputItem.malignant.index
                    ? StepState.editing
                    : _stepIndex < _InputItem.malignant.index
                        ? StepState.indexed
                        : StepState.complete,
              ),
              Step(
                title: const Text('Sites of Occlusive Lesions'),
                subtitle: const Text(
                    'aorto-iliac present, aorto-iliac absent and femoropopliteal present, or aorto-iliac and femoropopliteal absent and infrapopliteal present'),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 180,
                      child: RadioListTile<OcclusiveLesion>(
                          title: const Text('Aorto-iliac'),
                          value: OcclusiveLesion.ai,
                          groupValue: patientData.occlusiveLesion,
                          onChanged: (v) {
                            if (v == null) return;
                            setState(() {
                              patientData.occlusiveLesion = v;
                            });
                          }),
                    ),
                    SizedBox(
                      width: 240,
                      child: RadioListTile<OcclusiveLesion>(
                          title:
                              const Text('Femoropopliteal without Aorto-iliac'),
                          value: OcclusiveLesion.fpWithoutAI,
                          groupValue: patientData.occlusiveLesion,
                          onChanged: (v) {
                            if (v == null) return;
                            setState(() {
                              patientData.occlusiveLesion = v;
                            });
                          }),
                    ),
                    SizedBox(
                      width: 240,
                      child: RadioListTile<OcclusiveLesion>(
                          title: const Text('Infrapopliteal'),
                          value: OcclusiveLesion.belowIP,
                          groupValue: patientData.occlusiveLesion,
                          onChanged: (v) {
                            if (v == null) return;
                            setState(() {
                              patientData.occlusiveLesion = v;
                            });
                          }),
                    ),
                  ],
                ),
                isActive: _stepIndex == _InputItem.lesion.index,
                state: _stepIndex == _InputItem.lesion.index
                    ? StepState.editing
                    : _stepIndex < _InputItem.lesion.index
                        ? StepState.indexed
                        : StepState.complete,
              ),
              Step(
                title: const Text('Urgent revascularisation procedures'),
                subtitle: const Text('no: elective, or yes'),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 120,
                      child: RadioListTile<bool>(
                          title: const Text('Yes'),
                          value: true,
                          groupValue: patientData.isUrgent,
                          onChanged: (v) {
                            if (v == null) return;
                            setState(() {
                              patientData.isUrgent = v;
                            });
                          }),
                    ),
                    SizedBox(
                      width: 120,
                      child: RadioListTile<bool>(
                          title: const Text('No'),
                          value: false,
                          groupValue: patientData.isUrgent,
                          onChanged: (v) {
                            if (v == null) return;
                            setState(() {
                              patientData.isUrgent = v;
                            });
                          }),
                    ),
                  ],
                ),
                isActive: _stepIndex == _InputItem.urgent.index,
                state: _stepIndex == _InputItem.urgent.index
                    ? StepState.editing
                    : _stepIndex < _InputItem.urgent.index
                        ? StepState.indexed
                        : StepState.complete,
              ),
              Step(
                title: const Text('Fever'),
                subtitle: const Text(
                    'body temperature is higher than 38°C, absent or not'),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 120,
                      child: RadioListTile<bool>(
                          title: const Text('Yes'),
                          value: true,
                          groupValue: patientData.hasFever,
                          onChanged: (v) {
                            if (v == null) return;
                            setState(() {
                              patientData.hasFever = v;
                            });
                          }),
                    ),
                    SizedBox(
                      width: 120,
                      child: RadioListTile<bool>(
                          title: const Text('No'),
                          value: false,
                          groupValue: patientData.hasFever,
                          onChanged: (v) {
                            if (v == null) return;
                            setState(() {
                              patientData.hasFever = v;
                            });
                          }),
                    ),
                  ],
                ),
                isActive: _stepIndex == _InputItem.fever.index,
                state: _stepIndex == _InputItem.fever.index
                    ? StepState.editing
                    : _stepIndex < _InputItem.fever.index
                        ? StepState.indexed
                        : StepState.complete,
              ),
              Step(
                title: const Text('Leukocyctosis'),
                subtitle: const Text(
                    'white blood cell count is higher than 8000/ul, absent or not'),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 120,
                      child: RadioListTile<bool>(
                          title: const Text('Yes'),
                          value: true,
                          groupValue: patientData.hasLeukocytosis,
                          onChanged: (v) {
                            if (v == null) return;
                            setState(() {
                              patientData.hasLeukocytosis = v;
                            });
                          }),
                    ),
                    SizedBox(
                      width: 120,
                      child: RadioListTile<bool>(
                          title: const Text('No'),
                          value: false,
                          groupValue: patientData.hasLeukocytosis,
                          onChanged: (v) {
                            if (v == null) return;
                            setState(() {
                              patientData.hasLeukocytosis = v;
                            });
                          }),
                    ),
                  ],
                ),
                isActive: _stepIndex == _InputItem.leukocytosis.index,
                state: _stepIndex == _InputItem.leukocytosis.index
                    ? StepState.editing
                    : _stepIndex < _InputItem.lesion.index
                        ? StepState.indexed
                        : StepState.complete,
              ),
              Step(
                title: const Text('Local Infection'),
                subtitle: const Text(
                    'absent or present: the wound was suppurative or showed at least two of the following findings: heat, erythema, lymphangitis, lymph node swelling, oedema, and pain'),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 120,
                      child: RadioListTile<bool>(
                          title: const Text('Yes'),
                          value: true,
                          groupValue: patientData.hasLocalInfection,
                          onChanged: (v) {
                            if (v == null) return;
                            setState(() {
                              patientData.hasLocalInfection = v;
                            });
                          }),
                    ),
                    SizedBox(
                      width: 120,
                      child: RadioListTile<bool>(
                          title: const Text('No'),
                          value: false,
                          groupValue: patientData.hasLocalInfection,
                          onChanged: (v) {
                            if (v == null) return;
                            setState(() {
                              patientData.hasLocalInfection = v;
                            });
                          }),
                    ),
                  ],
                ),
                isActive: _stepIndex == _InputItem.infection.index,
                state: _stepIndex == _InputItem.infection.index
                    ? StepState.editing
                    : _stepIndex < _InputItem.infection.index
                        ? StepState.indexed
                        : StepState.complete,
              ),
            ]),
        SizedBox(
            height: 40,
            width: 180,
            child: ElevatedButton.icon(
                icon: const Icon(Icons.analytics_outlined),
                label: const Text('Predict Risks'),
                onPressed: () {
                  if (formKey.currentState == null ||
                      !formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: const Text('Error! Missing some data.'),
                      action: SnackBarAction(
                          textColor: Theme.of(context).colorScheme.onSecondary,
                          label: 'OK',
                          onPressed: () {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          }),
                    ));
                    return;
                  }
                  try {
                    patientData
                      ..age = int.parse(ageFormController.text)
                      ..height = double.parse(heightFormController.text)
                      ..weight = double.parse(weightFormController.text)
                      ..alb = double.parse(albFormController.text);
                  } catch (e) {
                    if (kDebugMode) print(e);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: const Text('Error! Missing some data.'),
                      action: SnackBarAction(
                          textColor: Theme.of(context).colorScheme.onSecondary,
                          label: 'OK',
                          onPressed: () {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          }),
                    ));
                    return;
                  }
                  final PatientRisk pr = PatientRisk(patientData: patientData);
                  showDialog(
                      context: context,
                      builder: (context) {
                        return SimpleDialog(
                          title: const Text('Risk'),
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: SelectableText(
                                  'GNRI: ${pr.gnri.toStringAsFixed(1)}'),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child:
                                  SelectableText('GNRI Risk: ${pr.gnriRisk}'),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: SelectableText(
                                  '2yr OS ${pr.predictedOS.toStringAsFixed(2)}'),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: SelectableText('2y OS Risk: ${pr.osRisk}'),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: SelectableText(
                                  '2yr Amputation Free Risk: ${pr.predictedAFS.toStringAsFixed(2)}'),
                            ),
                          ],
                        );
                      });
                })),
      ],
    );
  }
}
