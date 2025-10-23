import 'package:flutter/material.dart';

class MealDetailTabs extends StatelessWidget {
  final bool showIngredients;
  final ValueChanged<bool> onTabChange;

  const MealDetailTabs({
    super.key,
    required this.showIngredients,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () => onTabChange(true),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: showIngredients ? const Color(0xFFCEA700) : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'Nguyên liệu',
                    style: TextStyle(
                      color: showIngredients ? Colors.white : const Color(0xFFCEA700),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: InkWell(
              onTap: () => onTabChange(false),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: !showIngredients ? const Color(0xFFCEA700) : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'Chế biến',
                    style: TextStyle(
                      color: !showIngredients ? Colors.white : const Color(0xFFCEA700),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
