import 'package:clti_risk/widgets/label_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/patient_risk.dart';

class RiskView extends StatelessWidget {
  final PatientRisk risk;
  const RiskView({super.key, required this.risk});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).result),
        ),
        body: RiskViewPage(risk: risk));
  }
}

class RiskViewPage extends StatelessWidget {
  final PatientRisk risk;
  const RiskViewPage({
    super.key,
    required this.risk,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ListView(
      children: [
        InfoCard(
          title: l10n.gnri,
          subtitle: l10n.gnriDesctiption,
          children: [
            SelectableText(
              risk.gnri.toStringAsFixed(1),
              style: Theme.of(context).textTheme.displayMedium,
            ),
            SelectableText(
              LabelBuilder(context: context, item: risk.gnriRisk!).text,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
        InfoCard(
          title: l10n.predicted30DAD,
          subtitle: l10n.predicted30DADDescription,
          children: [
            SelectableText(
              ('${(risk.predicted30DDeathOrAmputation * 100.0).toStringAsFixed(1)}%'),
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ],
        ),
        InfoCard(
          title: l10n.predicted30DMALE,
          subtitle: l10n.predicted30DMALEDescription,
          children: [
            SelectableText(
              ('${(risk.predicted30DMALE * 100.0).toStringAsFixed(1)}%'),
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ],
        ),
        InfoCard(
          title: l10n.predicted2yrOS,
          subtitle: l10n.predicted2yrOSDescription,
          children: [
            SelectableText(
              ('${(risk.predictedOS * 100.0).toStringAsFixed(0)}%'),
              style: Theme.of(context).textTheme.displayMedium,
            ),
            SelectableText(
              LabelBuilder(context: context, item: risk.osRisk!).text,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
        InfoCard(
          title: l10n.predicted2yrAFS,
          subtitle: l10n.predicted2yrAFSDescription,
          children: [
            SelectableText(
              ('${(risk.predictedAFS * 100.0).toStringAsFixed(0)}%'),
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ],
        ),
      ],
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Widget> children;

  const InfoCard(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListTile(
              title: SelectableText(
                title,
              ),
              subtitle: SelectableText(
                subtitle,
              ),
            ),
            Column(children: children),
          ],
        ));
  }
}
