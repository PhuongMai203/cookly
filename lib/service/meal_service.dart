import 'dart:convert';
import 'package:cookly/model/meal_model.dart';
import 'package:http/http.dart' as http;

class MealService {
  static Future<List<Meal>> searchMeals(String query) async {
    final url = Uri.parse(
        'https://www.themealdb.com/api/json/v1/1/search.php?s=$query');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final meals = data['meals'];
      if (meals == null) return [];
      return (meals as List).map((e) => Meal.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load meals');
    }
  }
}
