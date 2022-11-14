import 'package:clti_risk/models/patient_data.dart';
import 'package:clti_risk/models/patient_risk.dart';
import 'package:test/test.dart';

void main() {
  //Test Cases, dummy data
  test('Default Case', () {
    final pd = PatientData();

    const want = _Want(
        gnri: '101.3',
        gnriRisk: GNRIRisk.noRisk,
        predictedOS: '0.92',
        predictedAFS: '0.88',
        osRisk: OSRisk.low,
        predicted30DDorA: '0.013',
        predicted30DMALE: '0.044');

    _testCase(pd, want);
  });

  test('Error Case', () {
    final pd = PatientData()
      ..sex = Sex.male
      ..age = 70
      ..height = 0.0
      ..weight = 50.0
      ..alb = 3.0
      ..activity = Activity.wheelchair;

    const want = _Want(
        gnri: 'NaN',
        gnriRisk: null,
        predictedOS: 'NaN',
        predictedAFS: 'NaN',
        osRisk: null,
        predicted30DDorA: 'NaN',
        predicted30DMALE: 'NaN');

    _testCase(pd, want);
  });

  test('Low Risk Case', () {
    final pd = PatientData()
      ..sex = Sex.male
      ..age = 50
      ..height = 1.65
      ..weight = 60.0
      ..alb = 4.0
      ..activity = Activity.ambulatory
      ..hasCHF = false
      ..hasCVD = true
      ..ckd = CKD.g3
      ..mn = MalignantNeoplasm.no
      ..occlusiveLesion = OcclusiveLesion.fpWithoutAI
      ..isUrgent = true
      ..hasFever = true
      ..hasLeukocytosis = true
      ..hasLocalInfection = true;

    const want = _Want(
        gnri: '101.3',
        gnriRisk: GNRIRisk.noRisk,
        predictedOS: '0.91',
        predictedAFS: '0.64',
        osRisk: OSRisk.low,
        predicted30DDorA: '',
        predicted30DMALE: '');

    _testCase(pd, want);
  });

  test('medium Risk Case', () {
    final pd = PatientData()
      ..sex = Sex.female
      ..age = 70
      ..height = 1.53
      ..weight = 55.0
      ..alb = 3.5
      ..activity = Activity.wheelchair
      ..hasCHF = true
      ..hasCVD = true
      ..ckd = CKD.g4
      ..mn = MalignantNeoplasm.pastHistory
      ..occlusiveLesion = OcclusiveLesion.fpWithoutAI
      ..isUrgent = true
      ..hasFever = true
      ..hasLeukocytosis = true
      ..hasLocalInfection = true;

    const want = _Want(
        gnri: '93.8',
        gnriRisk: GNRIRisk.low,
        predictedOS: '0.67',
        predictedAFS: '0.25',
        osRisk: OSRisk.medium,
        predicted30DDorA: '',
        predicted30DMALE: '');

    _testCase(pd, want);
  });

  test('high Risk Case', () {
    final pd = PatientData()
      ..sex = Sex.male
      ..age = 85
      ..height = 1.75
      ..weight = 55.1
      ..alb = 3.5
      ..activity = Activity.immobile
      ..hasCHF = false
      ..hasCVD = false
      ..ckd = CKD.g5
      ..mn = MalignantNeoplasm.underTreatment
      ..occlusiveLesion = OcclusiveLesion.belowIP
      ..isUrgent = true
      ..hasFever = false
      ..hasLeukocytosis = true
      ..hasLocalInfection = false;

    const want = _Want(
        gnri: '86.2',
        gnriRisk: GNRIRisk.moderate,
        predictedOS: '0.08',
        predictedAFS: '0.03',
        osRisk: OSRisk.high,
        predicted30DDorA: '',
        predicted30DMALE: '');

    _testCase(pd, want);
  });

  test('high Risk Case 2', () {
    final pd = PatientData()
      ..sex = Sex.female
      ..age = 90
      ..height = 1.55
      ..weight = 30.0
      ..alb = 3.2
      ..activity = Activity.immobile
      ..hasCHF = true
      ..hasCVD = true
      ..ckd = CKD.g5D
      ..mn = MalignantNeoplasm.underTreatment
      ..occlusiveLesion = OcclusiveLesion.belowIP
      ..isUrgent = true
      ..hasFever = true
      ..hasLeukocytosis = true
      ..hasLocalInfection = true;

    const want = _Want(
        gnri: '71.3',
        gnriRisk: GNRIRisk.major,
        predictedOS: '0.00',
        predictedAFS: '0.00',
        osRisk: OSRisk.high,
        predicted30DDorA: '',
        predicted30DMALE: '');

    _testCase(pd, want);
  });
}

//expected data struct
class _Want {
  final String gnri;
  final GNRIRisk? gnriRisk;
  final String predictedOS;
  final String predictedAFS;
  final OSRisk? osRisk;
  final String predicted30DDorA;
  final String predicted30DMALE;

  const _Want(
      {required this.gnri,
      required this.gnriRisk,
      required this.predictedOS,
      required this.predictedAFS,
      required this.osRisk,
      required this.predicted30DDorA,
      required this.predicted30DMALE});
}

void _testCase(PatientData pd, _Want want) {
  final pr = PatientRisk(patientData: pd);
  expect(pr.gnri.toStringAsFixed(1), want.gnri.toString());
  expect(pr.gnriRisk, want.gnriRisk);
  expect(pr.predictedOS.toStringAsFixed(2), equals(want.predictedOS));
  expect(pr.predictedAFS.toStringAsFixed(2), equals(want.predictedAFS));
  expect(pr.osRisk, want.osRisk);
  expect(pr.predicted30DDeathOrAmputation.toStringAsFixed(3),
      equals(want.predicted30DDorA));
  expect(pr.predicted30DMALE.toStringAsFixed(3), equals(want.predicted30DMALE));
}
