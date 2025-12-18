import 'package:flutter/material.dart';

// --------------
// Reusable card with theme-aware styling.
// Adds padding and child.
// --------------
class CustomCard extends StatelessWidget {
  final Widget child;

  const CustomCard({required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      color: colorScheme.surface,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}