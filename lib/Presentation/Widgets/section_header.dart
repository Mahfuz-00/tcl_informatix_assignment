// ------------------------------------------------------------
// Section Header Widget
//
// - Displays a bold section title using theme typography
// - Used to separate logical sections in detail screens
//   (e.g. Budget, Tasks, Team, Payments)
// - Keeps section titles visually consistent across the app
// ------------------------------------------------------------


import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}
