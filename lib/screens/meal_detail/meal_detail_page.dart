import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'meal_detail_header.dart';
import 'meal_detail_info.dart';
import 'meal_detail_tabs.dart';
import 'ingredients_section.dart';
import 'instruction_section.dart';

class MealDetailPage extends StatefulWidget {
  final String mealId;

  const MealDetailPage({super.key, required this.mealId});

  @override
  State<MealDetailPage> createState() => _MealDetailPageState();
}

class _MealDetailPageState extends State<MealDetailPage> {
  Map<String, dynamic>? meal;
  bool isLoading = true;
  bool showIngredients = true;

  @override
  void initState() {
    super.initState();
    fetchMealDetail();
  }

  Future<void> fetchMealDetail() async {
    final url = Uri.parse(
        'https://www.themealdb.com/api/json/v1/1/lookup.php?i=${widget.mealId}');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        meal = data['meals'][0];
        isLoading = false;
      });
    } else {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (meal == null) {
      return const Scaffold(
        body: Center(child: Text('Không tìm thấy món ăn')),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MealDetailHeader(meal: meal!),
            MealDetailInfo(meal: meal!),
            MealDetailTabs(
              showIngredients: showIngredients,
              onTabChange: (val) => setState(() => showIngredients = val),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: showIngredients
                  ? IngredientsSection(meal: meal!)
                  : InstructionSection(meal: meal!),
            ),
          ],
        ),
      ),
    );
  }
}
