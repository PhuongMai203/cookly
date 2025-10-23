import 'package:flutter/material.dart';

class IngredientsSection extends StatelessWidget {
  final Map<String, dynamic> meal;
  const IngredientsSection({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    final List<String> mainIngredients = [];
    final List<String> spices = [];

    for (int i = 1; i <= 20; i++) {
      final ingredient = meal['strIngredient$i'];
      final measure = meal['strMeasure$i'];

      if (ingredient != null && ingredient.isNotEmpty) {
        final lower = ingredient.toLowerCase();
        final isSpice = lower.contains('salt') ||
            lower.contains('sugar') ||
            lower.contains('oil') ||
            lower.contains('pepper') ||
            lower.contains('sauce') ||
            lower.contains('garlic') ||
            lower.contains('onion') ||
            lower.contains('flour') ||
            lower.contains('butter') ||
            lower.contains('vinegar') ||
            lower.contains('spice') ||
            lower.contains('powder');

        if (isSpice) {
          spices.add('$ingredient ${measure ?? ''}');
        } else {
          mainIngredients.add('$ingredient ${measure ?? ''}');
        }
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (mainIngredients.isNotEmpty)
          _buildGroup("Dành cho 2–4 người ăn", mainIngredients),
        if (spices.isNotEmpty)
          _buildGroup("Đối với bột gia vị", spices),
      ],
    );
  }

  Widget _buildGroup(String title, List<String> items) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          ...items.map(
                (e) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Text('• $e', style: const TextStyle(fontSize: 14)),
            ),
          ),
        ],
      ),
    );
  }
}
