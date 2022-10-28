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
}
