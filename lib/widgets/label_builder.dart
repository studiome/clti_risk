import 'package:clti_risk/models/patient_risk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/patient_data.dart';
import '../models/yes_no.dart';

class LabelBuilder<T extends Enum> {
  final BuildContext context;
  final T item;
  late String _label;
  LabelBuilder({required this.context, required this.item}) {
    final l10n = AppLocalizations.of(context);
    _label = _getLabelText(item, l10n);
  }

  String _getLabelText(T item, AppLocalizations l10n) {
    switch (item.runtimeType) {
      case Sex:
        switch (item as Sex) {
          case Sex.male:
            return l10n.male;
          case Sex.female:
            return l10n.female;
        }
      case Activity:
        switch (item as Activity) {
          case Activity.ambulatory:
            return l10n.ambulatory;
          case Activity.wheelchair:
            return l10n.wheelchair;
          case Activity.immobile:
            return l10n.immobile;
        }
      case CKD:
        switch (item as CKD) {
          case CKD.normal:
            return l10n.normal;
          case CKD.g3:
            return l10n.g3;
          case CKD.g4:
            return l10n.g4;
          case CKD.g5:
            return l10n.g5;
          case CKD.g5D:
            return l10n.g5D;
        }
      case MalignantNeoplasm:
        switch (item as MalignantNeoplasm) {
          case MalignantNeoplasm.no:
            return l10n.noMalignancy;
          case MalignantNeoplasm.pastHistory:
            return l10n.pastHistory;
          case MalignantNeoplasm.underTreatment:
            return l10n.underTreatment;
        }
      case RutherfordClassification:
        switch (item as RutherfordClassification) {
          case RutherfordClassification.class4:
            return l10n.class4;
          case RutherfordClassification.class5:
            return l10n.class5;
          case RutherfordClassification.class6:
            return l10n.class6;
        }
      case YesNo:
        switch (item as YesNo) {
          case YesNo.yes:
            return l10n.yes;
          case YesNo.no:
            return l10n.no;
        }
      case GNRIRisk:
        switch (item as GNRIRisk) {
          case GNRIRisk.noRisk:
            return l10n.gnriNoRisk;
          case GNRIRisk.low:
            return l10n.gnriLowRisk;
          case GNRIRisk.moderate:
            return l10n.gnriModerateRisk;
          case GNRIRisk.major:
            return l10n.gntiMajorRisk;
        }
      case OSRisk:
        switch (item as OSRisk) {
          case OSRisk.low:
            return l10n.osLowRisk;
          case OSRisk.medium:
            return l10n.osMediumRisk;
          case OSRisk.high:
            return l10n.osHighRisk;
        }
      default:
        throw ArgumentError('wrong choice type');
    }
  }

  get text => _label;
}
