// ------------------------------------------------------------
// Info Row Widget
//
// - Displays a single line of labeled information with icon
// - Commonly used for metadata such as dates, timelines, IDs
// - Automatically wraps long text using Expanded
// - Ensures consistent spacing and typography across screens
// ------------------------------------------------------------


import 'package:flutter/material.dart';

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey.shade600),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
