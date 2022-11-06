import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/patient_data.dart';
import '../models/patient_risk.dart';
import '../widgets/step_content.dart';

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
  bool canCalculate = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Column(
        children: [
          SizedBox(
            height: constraint.maxHeight - (40 + 24),
            child: Stepper(
                currentStep: _stepIndex,
                onStepCancel: () {
                  if (_stepIndex == 0) return;
                  setState(() {
                    _stepIndex -= 1;
                  });
                },
                onStepContinue: () {
                  if (_stepIndex == inputMaxNumber - 1) {
                    setState(() {
                      canCalculate = true;
                    });
                  } else {
                    setState(() {
                      _stepIndex += 1;
                    });
                  }
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
                        'Sex, Age[years], Height[m], BodyWeight[kg], Albumin[g/dl]'),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Sex'),
                              StepContentWithEnum<Sex>(
                                  values: Sex.values,
                                  item: patientData.sex,
                                  itemWidth: 150,
                                  itemHeight: 40,
                                  onChanged: (v) {
                                    if (v == null) return;
                                    setState(() {
                                      patientData.sex = v;
                                    });
                                  }),
                            ],
                          ),
                        ),
                        const Text('Fill in the following box below'),
                        Form(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: SizedBox(
                                    width: 160,
                                    height: 80,
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
                                    width: 160,
                                    height: 80,
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
                                          patientData.height =
                                              double.parse(value);
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
                                    width: 160,
                                    height: 80,
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
                                          patientData.weight =
                                              double.parse(value);
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
                                      width: 160,
                                      height: 80,
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: TextFormField(
                                          controller: albFormController,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: 'Fill Albumin',
                                            labelText: 'Albumin [g/dl]',
                                          ),
                                          textInputAction: TextInputAction.done,
                                          keyboardType: const TextInputType
                                              .numberWithOptions(
                                            signed: false,
                                            decimal: true,
                                          ),
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'^\d{1}\.?\d{0,1}')),
                                          ],
                                          autovalidateMode:
                                              AutovalidateMode.always,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Fill Albumin';
                                            }
                                            return null;
                                          },
                                          onFieldSubmitted: (String value) {
                                            try {
                                              patientData.alb =
                                                  double.parse(value);
                                            } catch (e) {
                                              //DO Nothing
                                              if (kDebugMode) print(e);
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ))
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
                        'Ambulatory: able to walk, Wheelchair: unable to walk but could stand on their own legs during bed to wheelchair transfer, Immobile: full assistance was indispensable'),
                    content: Container(
                      alignment: Alignment.centerLeft,
                      child: StepContentWithEnum<Activity>(
                        values: Activity.values,
                        item: patientData.activity,
                        itemWidth: 180,
                        itemHeight: 40,
                        onChanged: (v) {
                          if (v == null) return;
                          setState(() {
                            patientData.activity = v;
                          });
                        },
                      ),
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
                    content: Container(
                      alignment: Alignment.centerLeft,
                      child: StepContentWithBoolean(
                        item: patientData.hasCHF,
                        itemWidth: 120,
                        itemHeight: 40,
                        onChanged: (v) {
                          if (v == null) return;
                          setState(() {
                            patientData.hasCHF = v;
                          });
                        },
                      ),
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
                    content: Container(
                      alignment: Alignment.centerLeft,
                      child: StepContentWithBoolean(
                        item: patientData.hasCVD,
                        itemWidth: 120,
                        itemHeight: 40,
                        onChanged: (v) {
                          if (v == null) return;
                          setState(() {
                            patientData.hasCVD = v;
                          });
                        },
                      ),
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
                    content: Container(
                      alignment: Alignment.centerLeft,
                      child: StepContentWithEnum<CKD>(
                        values: CKD.values,
                        item: patientData.ckd,
                        itemWidth: 180,
                        itemHeight: 40,
                        onChanged: (v) {
                          if (v == null) return;
                          setState(() {
                            patientData.ckd = v;
                          });
                        },
                      ),
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
                    content: Container(
                      alignment: Alignment.centerLeft,
                      child: StepContentWithEnum<MalignantNeoplasm>(
                        values: MalignantNeoplasm.values,
                        item: patientData.mn,
                        itemWidth: 240,
                        itemHeight: 40,
                        onChanged: (v) {
                          if (v == null) return;
                          setState(() {
                            patientData.mn = v;
                          });
                        },
                      ),
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
                    content: Container(
                      alignment: Alignment.centerLeft,
                      child: StepContentWithEnum<OcclusiveLesion>(
                        values: OcclusiveLesion.values,
                        item: patientData.occlusiveLesion,
                        itemWidth: 240,
                        itemHeight: 60,
                        onChanged: (v) {
                          if (v == null) return;
                          setState(() {
                            patientData.occlusiveLesion = v;
                          });
                        },
                      ),
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
                    content: Container(
                      alignment: Alignment.centerLeft,
                      child: StepContentWithBoolean(
                        item: patientData.isUrgent,
                        itemWidth: 120,
                        itemHeight: 40,
                        onChanged: (v) {
                          if (v == null) return;
                          setState(() {
                            patientData.isUrgent = v;
                          });
                        },
                      ),
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
                    subtitle:
                        const Text('body temperature is higher than 38°C'),
                    content: Container(
                      alignment: Alignment.centerLeft,
                      child: StepContentWithBoolean(
                        item: patientData.hasFever,
                        itemWidth: 120,
                        itemHeight: 40,
                        onChanged: (v) {
                          if (v == null) return;
                          setState(() {
                            patientData.hasFever = v;
                          });
                        },
                      ),
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
                        'white blood cell count is higher than 8000/ul'),
                    content: Container(
                      alignment: Alignment.centerLeft,
                      child: StepContentWithBoolean(
                        item: patientData.hasLeukocytosis,
                        itemWidth: 120,
                        itemHeight: 40,
                        onChanged: (v) {
                          if (v == null) return;
                          setState(() {
                            patientData.hasLeukocytosis = v;
                          });
                        },
                      ),
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
                    content: Container(
                      alignment: Alignment.centerLeft,
                      child: StepContentWithBoolean(
                        item: patientData.hasLocalInfection,
                        itemWidth: 120,
                        itemHeight: 40,
                        onChanged: (v) {
                          if (v == null) return;
                          setState(() {
                            patientData.hasLocalInfection = v;
                          });
                        },
                      ),
                    ),
                    isActive: _stepIndex == _InputItem.infection.index,
                    state: _stepIndex == _InputItem.infection.index
                        ? StepState.editing
                        : _stepIndex < _InputItem.infection.index
                            ? StepState.indexed
                            : StepState.complete,
                  ),
                ]),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
                height: 40,
                width: 180,
                child: ElevatedButton.icon(
                    icon: const Icon(Icons.analytics_outlined),
                    label: const Text('Predict Risks'),
                    onPressed: !canCalculate
                        ? null
                        : () {
                            if (formKey.currentState != null &&
                                !formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content:
                                    const Text('Error! Missing some data.'),
                                action: SnackBarAction(
                                    textColor: Theme.of(context)
                                        .colorScheme
                                        .onSecondary,
                                    label: 'OK',
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                    }),
                              ));
                              return;
                            }
                            try {
                              patientData
                                ..age = int.parse(ageFormController.text)
                                ..height =
                                    double.parse(heightFormController.text)
                                ..weight =
                                    double.parse(weightFormController.text)
                                ..alb = double.parse(albFormController.text);
                            } catch (e) {
                              if (kDebugMode) print(e);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content:
                                    const Text('Error! Missing some data.'),
                                action: SnackBarAction(
                                    textColor: Theme.of(context)
                                        .colorScheme
                                        .onSecondary,
                                    label: 'OK',
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                    }),
                              ));
                              return;
                            }
                            final PatientRisk pr =
                                PatientRisk(patientData: patientData);
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
                                        child: SelectableText(
                                            'GNRI Risk: ${pr.gnriRisk}'),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0, vertical: 8.0),
                                        child: SelectableText(
                                            '2yr Overall Survival: ${pr.predictedOS.toStringAsFixed(2)}'),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0, vertical: 8.0),
                                        child: SelectableText(
                                            '2y OS Risk: ${pr.osRisk}'),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0, vertical: 8.0),
                                        child: SelectableText(
                                            '2yr Amputation Free Survival: ${pr.predictedAFS.toStringAsFixed(2)}'),
                                      ),
                                    ],
                                  );
                                });
                          })),
          ),
        ],
      );
    });
  }
}
