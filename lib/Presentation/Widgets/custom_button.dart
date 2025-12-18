// ------------------------------------------------------------
// Custom Card Widget
//
// - Wrapper around Material Card with theme-aware surface color
// - Applies consistent margin and internal padding
// - Used as the base container for lists, summaries, and details
// - Ensures visual consistency across all ERP screens
// ------------------------------------------------------------


import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;

  const CustomCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}