import 'package:flutter/material.dart';
import 'meal_card.dart';

class MealGrid extends StatelessWidget {
  final List<dynamic> meals;

  const MealGrid({super.key, required this.meals});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: meals.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.0,
      ),
      itemBuilder: (context, index) {
        return MealCard(meal: meals[index]);
      },
    );
  }
}
