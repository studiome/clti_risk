import 'package:clti_risk/models/patient_data.dart';
import 'package:clti_risk/models/patient_risk.dart';
import 'package:clti_risk/widgets/risk_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late PatientData pd;
  group('Risk Viewer Test, [locale:en] ', () {
    setUp(() {
      pd = PatientData();
    });

    testWidgets('normal case,', (tester) async {
      pd
        ..age = 65
        ..height = 1.50
        ..weight = 50.0
        ..alb = 4.0;
      await tester.pumpWidget(TestApp(
        risk: PatientRisk(patientData: pd),
        locale: const Locale('en'),
      ));
      await tester.pumpAndSettle();
      // GNRI
      expect(find.text('101.3'), findsOneWidget);
      // GNRI risk
      expect(find.text('No Risk'), findsOneWidget);
      // 30D Amputation/Death
      expect(find.text('1.3%'), findsOneWidget);
      // 30D MALE

      //drag
      expect(find.text('3.2%'), findsOneWidget);
      await tester.dragUntilVisible(find.text('Predicted 2-year OS'),
          find.byType(ListView), const Offset(0.0, -100.0));
      await tester.pumpAndSettle();

      // 2y OS
      expect(find.text('92%'), findsOneWidget);
      // 2y OS risk
      expect(find.text('Low Risk'), findsOneWidget);
      // 2y AFS
      expect(find.text('88%'), findsOneWidget);
    });

    testWidgets('low risk case,', (tester) async {
      pd
        ..sex = Sex.male
        ..age = 50
        ..height = 1.65
        ..weight = 60.0
        ..alb = 4.0
        ..activity = Activity.ambulatory
        ..hasCHF = false
        ..hasCVD = true
        ..ckd = CKD.g3
        ..malignant = MalignantNeoplasm.no
        ..hasAILesion = false
        ..hasFPLesion = true
        ..hasBKLesion = false
        ..isUrgent = true
        ..hasFever = true
        ..hasAbnormalWBC = true
        ..hasLocalInfection = true
        ..hasCAD = true
        ..hasDyslipidemia = false
        ..isSmoking = true
        ..hasContraLateralLesion = false
        ..hasOtherVD = true
        ..rutherford = RutherfordClassification.class4;

      await tester.pumpWidget(TestApp(
        risk: PatientRisk(patientData: pd),
        locale: const Locale('en'),
      ));
      await tester.pumpAndSettle();
      // GNRI
      expect(find.text('101.3'), findsOneWidget);
      // GNRI risk
      expect(find.text('No Risk'), findsOneWidget);
      // 30D Amputation/Death
      expect(find.text('8.8%'), findsOneWidget);
      //drag
      expect(find.text('15.2%'), findsOneWidget);
      // 30D MALE
      await tester.dragUntilVisible(find.text('Predicted 2-year OS'),
          find.byType(ListView), const Offset(0.0, -100.0));
      await tester.pumpAndSettle();

      // 2y OS
      expect(find.text('91%'), findsOneWidget);
      // 2y OS risk
      expect(find.text('Low Risk'), findsOneWidget);
      // 2y AFS
      expect(find.text('64%'), findsOneWidget);
    });

    testWidgets('medium risk case,', (tester) async {
      pd
        ..sex = Sex.female
        ..age = 70
        ..height = 1.53
        ..weight = 55.0
        ..alb = 3.5
        ..activity = Activity.wheelchair
        ..hasCHF = true
        ..hasCVD = true
        ..ckd = CKD.g4
        ..malignant = MalignantNeoplasm.pastHistory
        ..hasAILesion = false
        ..hasFPLesion = true
        ..hasBKLesion = true
        ..isUrgent = true
        ..hasFever = true
        ..hasAbnormalWBC = true
        ..hasLocalInfection = true
        ..hasCAD = false
        ..hasDyslipidemia = true
        ..isSmoking = false
        ..hasContraLateralLesion = true
        ..hasOtherVD = false
        ..rutherford = RutherfordClassification.class5;

      await tester.pumpWidget(TestApp(
        risk: PatientRisk(patientData: pd),
        locale: const Locale('en'),
      ));
      await tester.pumpAndSettle();
      // GNRI
      expect(find.text('93.8'), findsOneWidget);
      // GNRI risk
      expect(find.text('Low Risk'), findsOneWidget);
      // 30D Amputation/Death
      expect(find.text('17.0%'), findsOneWidget);
      //drag
      expect(find.text('17.5%'), findsOneWidget);
      // 30D MALE
      await tester.dragUntilVisible(find.text('Predicted 2-year OS'),
          find.byType(ListView), const Offset(0.0, -100.0));
      await tester.pumpAndSettle();

      // 2y OS
      expect(find.text('67%'), findsOneWidget);
      // 2y OS risk
      expect(find.text('Medium Risk'), findsOneWidget);
      // 2y AFS
      expect(find.text('25%'), findsOneWidget);
    });

    testWidgets('high risk case,', (tester) async {
      pd
        ..sex = Sex.male
        ..age = 85
        ..height = 1.75
        ..weight = 55.1
        ..alb = 3.5
        ..activity = Activity.immobile
        ..hasCHF = false
        ..hasCVD = false
        ..ckd = CKD.g5
        ..malignant = MalignantNeoplasm.underTreatment
        ..hasAILesion = false
        ..hasFPLesion = false
        ..hasBKLesion = true
        ..isUrgent = true
        ..hasFever = false
        ..hasAbnormalWBC = true
        ..hasLocalInfection = false
        ..hasCAD = true
        ..hasDyslipidemia = true
        ..isSmoking = true
        ..hasContraLateralLesion = true
        ..hasOtherVD = false
        ..rutherford = RutherfordClassification.class5;

      await tester.pumpWidget(TestApp(
        risk: PatientRisk(patientData: pd),
        locale: const Locale('en'),
      ));
      await tester.pumpAndSettle();
      // GNRI
      expect(find.text('86.2'), findsOneWidget);
      // GNRI risk
      expect(find.text('Moderate Risk'), findsOneWidget);
      // 30D Amputation/Death
      expect(find.text('10.0%'), findsOneWidget);
      //drag
      expect(find.text('4.3%'), findsOneWidget);
      // 30D MALE
      await tester.dragUntilVisible(find.text('Predicted 2-year OS'),
          find.byType(ListView), const Offset(0.0, -100.0));
      await tester.pumpAndSettle();

      // 2y OS
      expect(find.text('8%'), findsOneWidget);
      // 2y OS risk
      expect(find.text('High Risk'), findsOneWidget);
      // 2y AFS
      expect(find.text('3%'), findsOneWidget);
    });

    testWidgets('high risk case 2,', (tester) async {
      pd
        ..sex = Sex.female
        ..age = 90
        ..height = 1.55
        ..weight = 30.0
        ..alb = 3.2
        ..activity = Activity.immobile
        ..hasCHF = true
        ..hasCVD = true
        ..ckd = CKD.g5D
        ..malignant = MalignantNeoplasm.underTreatment
        ..hasAILesion = false
        ..hasFPLesion = false
        ..hasBKLesion = true
        ..isUrgent = true
        ..hasFever = true
        ..hasAbnormalWBC = true
        ..hasLocalInfection = true
        ..hasCAD = true
        ..hasDyslipidemia = true
        ..isSmoking = true
        ..hasContraLateralLesion = false
        ..hasOtherVD = true
        ..rutherford = RutherfordClassification.class6;

      await tester.pumpWidget(TestApp(
        risk: PatientRisk(patientData: pd),
        locale: const Locale('en'),
      ));
      await tester.pumpAndSettle();
      // GNRI
      expect(find.text('71.3'), findsOneWidget);
      // GNRI risk
      expect(find.text('Major Risk'), findsOneWidget);
      // 30D Amputation/Death
      expect(find.text('37.0%'), findsOneWidget);
      //drag
      expect(find.text('12.2%'), findsOneWidget);
      // 30D MALE
      await tester.dragUntilVisible(find.text('Predicted 2-year OS'),
          find.byType(ListView), const Offset(0.0, -100.0));
      await tester.pumpAndSettle();

      // 2y OS, 2y AFS
      expect(find.text('0%'), findsNWidgets(2));
      // 2y OS risk
      expect(find.text('High Risk'), findsOneWidget);
    });
  });
}

class TestApp extends StatelessWidget {
  final PatientRisk risk;
  final Locale locale;
  const TestApp({super.key, required this.risk, required this.locale});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: locale,
        home: RiskView(
          risk: risk,
        ));
  }
}
