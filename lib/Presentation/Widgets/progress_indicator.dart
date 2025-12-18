import 'package:flutter/material.dart';

// --------------
// Reusable progress indicator widget.
// Displays linear bar with percentage label, colored based on value (green >70%, orange 40-70%, red <40%).
// Accepts value 0.0-1.0.
// --------------
class CustomProgressIndicator extends StatelessWidget {
final double value;
final String? label;

const CustomProgressIndicator({required this.value, this.label});

@override
Widget build(BuildContext context) {
final percentage = (value * 100).toStringAsFixed(0);
Color color;
if (value >= 0.7) {
color = Colors.green;
} else if (value >= 0.4) {
color = Colors.orange;
} else {
color = Colors.red;
}

return Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
if (label != null) Text(label!),
LinearProgressIndicator(
value: value,
backgroundColor: Colors.grey[300],
valueColor: AlwaysStoppedAnimation<Color>(color),
),
Text('$percentage%'),
],
);
}
}