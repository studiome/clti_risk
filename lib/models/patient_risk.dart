import 'dart:math';

import 'package:clti_risk/models/patient_data.dart';

class PatientRisk {
  PatientData patientData;
  PatientRisk({required this.patientData});

  double predictedOS = 0.0; //2yr OS;
  double predictedAFS = 0.0; //2yr AFS;
  double _gnri = 100.0; // geriatric nutritional risk index

  GNRIRisk gnriRisk = GNRIRisk.low; //GNRI Risk
  OSRisk osRisk = OSRisk.low; // 2Yr OS risk

  double _calcGNRI() {
    _gnri = 14.89 * patientData.alb +
        41.7 * patientData.weight / (22 * pow(patientData.height, 2));
    return _gnri;
  }

  double get gnri => _calcGNRI();
}

enum OSRisk {
  high, // risk < 50%
  medium, // 50% <= risk < 70%
  low, // 70% <= risk
}

enum GNRIRisk {
  major, // gnri < 82
  moderate, // 82<= gnri < 92
  low, // 98<= gnri
}
