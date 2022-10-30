import 'package:flutter/material.dart';

import '../models/patient_data.dart';

class PatientDataForm extends StatefulWidget {
  const PatientDataForm({super.key});

  @override
  State<PatientDataForm> createState() => _PatientDataFormState();
}

class _PatientDataFormState extends State<PatientDataForm> {
  PatientData patientData = PatientData();
  int _stepIndex = 0;
  final int inputMaxNumber = 15;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 640,
            child: Stepper(
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
                    title: const Text('Sex'),
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
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
                  Step(
                    title: const Text('Age'),
                    subtitle: const Text('[years]'),
                    content: TextFormField(
                      onFieldSubmitted: (String value) {},
                    ),
                  ),
                  Step(
                    title: const Text('Height'),
                    subtitle: const Text('[m]'),
                    content: TextFormField(
                      onFieldSubmitted: (String value) {},
                    ),
                  ),
                  Step(
                    title: const Text('Body weight'),
                    subtitle: const Text('[kg]'),
                    content: TextFormField(
                      onFieldSubmitted: (String value) {},
                    ),
                  ),
                  Step(
                    title: const Text('Albumin'),
                    subtitle: const Text('[g/dl]'),
                    content: TextFormField(
                      onFieldSubmitted: (String value) {},
                    ),
                  ),
                  const Step(
                    title: Text('Actvity'),
                    subtitle: Text(
                        'ambulatory: able to walk, wheelchair: unable to walk but could stand on their own legs during bed to wheelchair transfer, immobile: full assistance was indispensable'),
                    content: Text('activity'),
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
                  ),
                  const Step(
                    title: Text('Chronic kidney disease'),
                    subtitle: Text(
                        'absent, G3, G4, G5, or G5D; renal dysfunction was absent when the estimated glomerular filtration rate [eGFR] was 60 ml/min/1.73 m2 or higher, and it was graded as G3, G4, and G5 when eGFR was 30 e 59, 15 e 29, and below 15, respectively. eGFR below 15 in haemodialysis patients was graded as G5D'),
                    content: Text('grade'),
                  ),
                  const Step(
                    title: Text('Malignant neoplasm'),
                    subtitle: Text(
                        'absent, past history of malignant neoplasm, or present under treatment'),
                    content: Text('cancer'),
                  ),
                  const Step(
                    title: Text('Sites of Occlusive Lesions'),
                    subtitle: Text(
                        'aorto-iliac present, aorto-iliac absent and femoropopliteal present, or aorto-iliac and femoropopliteal absent and infrapopliteal present'),
                    content: Text('occlusive'),
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
                                  patientData.hasCHF = v;
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
                                  patientData.hasCHF = v;
                                });
                              }),
                        ),
                      ],
                    ),
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
                  ),
                ]),
          )
        ],
      ),
    );
  }
}
