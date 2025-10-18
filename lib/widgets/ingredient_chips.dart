import 'package:flutter/material.dart';

class IngredientChips extends StatefulWidget {
  const IngredientChips({super.key});

  @override
  State<IngredientChips> createState() => _IngredientChipsState();
}

class _IngredientChipsState extends State<IngredientChips> {
  final List<String> ingredients = [
    'Danh mục 1',
    'Danh mục 2',
    'Danh mục 3',
    'Danh mục 4',
  ];

  int selectedIndex = 0; // Mặc định chọn Danh mục 1

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(ingredients.length, (index) {
        final bool isSelected = selectedIndex == index;

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 30,
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFCEA700) : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFFCEA700)
                        : Colors.grey.shade400,
                    width: 1,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  ingredients[index],
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey[800],
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
