import 'package:clti_risk/models/patient_data.dart';
import 'package:clti_risk/models/patient_risk.dart';
import 'package:test/test.dart';

void main() {
  test('GNRI NaN', () {
    final pd = PatientData(
        sex: Sex.male,
        age: 70,
        height: 0.0,
        weight: 50.0,
        alb: 3.0,
        activity: Activity.wheelchair);
    final pr = PatientRisk(patientData: pd);
    expect(pr.gnri.toStringAsFixed(1), 'NaN');
    expect(pr.gnriRisk, null);
  });
  test('GNRI major', () {
    final pd = PatientData(
        sex: Sex.male,
        age: 70,
        height: 1.75,
        weight: 50.0,
        alb: 3.0,
        activity: Activity.wheelchair);
    final pr = PatientRisk(patientData: pd);
    expect(pr.gnri.toStringAsFixed(1), '75.6');
    expect(pr.gnriRisk, GNRIRisk.major);
  });
  test('GNRI moderate', () {
    final pd = PatientData(
        sex: Sex.female,
        age: 65,
        height: 1.55,
        weight: 40.0,
        alb: 3.8,
        activity: Activity.ambulatory);
    final pr = PatientRisk(patientData: pd);
    expect(pr.gnri.toStringAsFixed(1), '88.1');
    expect(pr.gnriRisk, GNRIRisk.moderate);
  });
  test('GNRI low', () {
    final pd = PatientData(
        sex: Sex.female,
        age: 60,
        height: 1.45,
        weight: 30.0,
        alb: 4.5,
        activity: Activity.ambulatory);
    final pr = PatientRisk(patientData: pd);
    expect(pr.gnri.toStringAsFixed(1), '94.1');
    expect(pr.gnriRisk, GNRIRisk.low);
  });
  test('GNRI no risk', () {
    final pd = PatientData(
        sex: Sex.female,
        age: 60,
        height: 1.65,
        weight: 60.0,
        alb: 4.0,
        activity: Activity.ambulatory);
    final pr = PatientRisk(patientData: pd);
    expect(pr.gnri.toStringAsFixed(1), '101.3');
    expect(pr.gnriRisk, GNRIRisk.noRisk);
  });
  test("OS case1", () {
    final pd = PatientData(
        sex: Sex.male,
        age: 50,
        height: 1.65,
        weight: 60.0,
        alb: 4.0,
        activity: Activity.ambulatory)
      ..hasCHF = false
      ..ckd = CKD.g3
      ..mn = MalignantNeoplasm.no
      ..occlusiveLesion = OcclusiveLesion.fpWithoutAI
      ..isUrgent = true
      ..hasFeverUp = true
      ..hasLeukocytosis = true
      ..hasLocalInfection = true;
    final pr = PatientRisk(patientData: pd);
    expect((pr.predictedOS * 100.0).round(), 91);
    expect((pr.predictedAFS * 100).round(), 66);
    expect(pr.osRisk, OSRisk.low);
  });
}
