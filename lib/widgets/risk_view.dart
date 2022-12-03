import 'package:flutter/material.dart';

import '../models/patient_risk.dart';

class RiskView extends StatelessWidget {
  final PatientRisk risk;
  final String title;
  const RiskView({super.key, required this.risk, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: ListView(
          children: [
            InfoCard(
              title: 'GNRI',
              subtitle: 'Geriatric Nutritional Risk Index',
              children: [
                SelectableText(
                  risk.gnri.toStringAsFixed(1),
                  style: Theme.of(context).textTheme.headline1,
                ),
                SelectableText(
                  risk.gnriRisk.toString(),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
            InfoCard(
              title: 'Probability of 30 days Amputation/Death',
              subtitle:
                  'Probability of major amputation and/or death 30 days after revascularization',
              children: [
                SelectableText(
                  ('${(risk.predicted30DDeathOrAmputation * 100.0).toStringAsFixed(1)}%'),
                  style: Theme.of(context).textTheme.headline1,
                ),
              ],
            ),
            InfoCard(
              title: 'Probability of 30 days MALE',
              subtitle:
                  'Probability of major adverse limb event 30 days after revascularization',
              children: [
                SelectableText(
                  ('${(risk.predicted30DMALE * 100.0).toStringAsFixed(1)}%'),
                  style: Theme.of(context).textTheme.headline1,
                ),
              ],
            ),
            InfoCard(
              title: 'Predicted OS',
              subtitle:
                  'Predicted 2 year Overall Survival post-revascularisation',
              children: [
                SelectableText(
                  ('${(risk.predictedOS * 100.0).toStringAsFixed(0)}%'),
                  style: Theme.of(context).textTheme.headline1,
                ),
                SelectableText(
                  risk.osRisk.toString(),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
            InfoCard(
              title: 'Predicted AFS',
              subtitle:
                  'Predicted 2 year Amputation Free Survival post-revascularisation',
              children: [
                SelectableText(
                  ('${(risk.predictedAFS * 100.0).toStringAsFixed(0)}%'),
                  style: Theme.of(context).textTheme.headline1,
                ),
              ],
            ),
          ],
        ));
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
