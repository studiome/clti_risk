import 'package:clti_risk/models/patient_data.dart';
import 'package:clti_risk/models/patient_risk.dart';
import 'package:test/test.dart';

void main() {
  //Test Cases, dummy data
  test('Error Case', () {
    final pd = PatientData(
        sex: Sex.male,
        age: 70,
        height: 0.0,
        weight: 50.0,
        alb: 3.0,
        activity: Activity.wheelchair);
    const want = _WantData(
        gnri: 'NaN',
        gnriRisk: null,
        predictedOS: 'NaN',
        predictedAFS: 'NaN',
        osRisk: null);

    _testCase(pd, want);
  });

  test('Low Risk Case', () {
    final pd = PatientData(
        sex: Sex.male,
        age: 50,
        height: 1.65,
        weight: 60.0,
        alb: 4.0,
        activity: Activity.ambulatory)
      ..hasCHF = false
      ..hasCVD = true
      ..ckd = CKD.g3
      ..mn = MalignantNeoplasm.no
      ..occlusiveLesion = OcclusiveLesion.fpWithoutAI
      ..isUrgent = true
      ..hasFeverUp = true
      ..hasLeukocytosis = true
      ..hasLocalInfection = true;

    const want = _WantData(
        gnri: '101.3',
        gnriRisk: GNRIRisk.noRisk,
        predictedOS: '0.91',
        predictedAFS: '0.64',
        osRisk: OSRisk.low);

    _testCase(pd, want);
  });
}

//expected data struct
class _WantData {
  final String gnri;
  final GNRIRisk? gnriRisk;
  final String predictedOS;
  final String predictedAFS;
  final OSRisk? osRisk;

  const _WantData(
      {required this.gnri,
      required this.gnriRisk,
      required this.predictedOS,
      required this.predictedAFS,
      required this.osRisk});
}

void _testCase(PatientData pd, _WantData want) {
  final pr = PatientRisk(patientData: pd);
  expect(pr.gnri.toStringAsFixed(1), want.gnri.toString());
  expect(pr.gnriRisk, want.gnriRisk);
  expect(pr.predictedOS.toStringAsFixed(2), equals(want.predictedOS));
  expect(pr.predictedAFS.toStringAsFixed(2), equals(want.predictedAFS));
  expect(pr.osRisk, want.osRisk);
}
