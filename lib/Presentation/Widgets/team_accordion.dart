import 'package:flutter/material.dart';
import 'custom_button.dart';

class TeamAccordion extends StatefulWidget {
  final dynamic team;

  const TeamAccordion({required this.team});

  @override
  State<TeamAccordion> createState() => _TeamAccordionState();
}

class _TeamAccordionState extends State<TeamAccordion> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final hasMembers = widget.team.members.isNotEmpty;

    return CustomCard(
      child: Column(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: hasMembers ? () => setState(() => _expanded = !_expanded) : null,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  const Icon(Icons.group_outlined),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(widget.team.name,
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                  ),
                  if (hasMembers)
                    AnimatedRotation(
                      turns: _expanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: const Icon(Icons.expand_more),
                    ),
                ],
              ),
            ),
          ),
          if (_expanded && hasMembers)
            Column(
              children: widget.team.members.map<Widget>(
                    (m) => Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Row(
                    children: [
                      const CircleAvatar(radius: 18, child: Icon(Icons.person, size: 18)),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(m.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                          Text(m.role, style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                        ],
                      ),
                    ],
                  ),
                ),
              ).toList(),
            ),
        ],
      ),
    );
  }
}
