import 'package:flutter/material.dart';
import 'package:my_portfolio/features/projects/models/bullet_texts.dart';

class FeaturesList extends StatelessWidget {
  final List<String> features;
  const FeaturesList({super.key, required this.features});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        children:
            features.map((feature) => BulletTexts(text: feature)).toList(),
      ),
    );
  }
}
