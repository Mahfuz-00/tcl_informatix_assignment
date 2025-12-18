import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../Domain/Entities/budget_entity.dart';
import 'custom_button.dart';

class BudgetBreakdown extends StatelessWidget {
  final List<CategoryEntity> categories;

  const BudgetBreakdown({required this.categories, super.key});

  @override
  Widget build(BuildContext context) {
    final numberFormatter = NumberFormat(',##,###');

    return Column(
      children: categories.map((cat) {
        final double utilization = cat.allocated > 0 ? cat.spent / cat.allocated : 0.0;
        final hasSub = cat.subCategories != null && cat.subCategories!.isNotEmpty;

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: CustomCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category header
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${cat.name}\nBDT ${numberFormatter.format(cat.spent)}/${numberFormatter.format(cat.allocated)}',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 6),
                        LinearProgressIndicator(
                          value: utilization,
                          minHeight: 6,
                          backgroundColor: Colors.grey[300],
                          valueColor: AlwaysStoppedAnimation<Color>(
                            utilization > 0.9 ? Colors.red : Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Subcategories
                if (hasSub)
                  Column(
                    children: cat.subCategories!.map((sub) {
                      final double subUtil = sub.allocated > 0 ? sub.spent / sub.allocated : 0.0;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(sub.name),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('${(subUtil * 100).toStringAsFixed(0)}%'),
                                const SizedBox(height: 4),
                                SizedBox(
                                  width: 100,
                                  child: LinearProgressIndicator(
                                    value: subUtil,
                                    minHeight: 6,
                                    backgroundColor: Colors.grey[300],
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      subUtil > 0.9 ? Colors.red : Colors.green,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
