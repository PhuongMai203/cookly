import 'dart:convert';
import 'package:http/http.dart' as http;

class Meal {
  final String id;
  final String name;
  final String thumbnail;

  Meal({required this.id, required this.name, required this.thumbnail});

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['idMeal'] ?? '',
      name: json['strMeal'] ?? '',
      thumbnail: json['strMealThumb'] ?? '',
    );
  }
}

class MealApi {
  static const baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  static Future<List<Meal>> searchMeals(String query) async {
    if (query.isEmpty) return [];

    final url = Uri.parse('$baseUrl/search.php?s=$query');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final meals = data['meals'];
      if (meals == null) return [];
      return List<Meal>.from(meals.map((m) => Meal.fromJson(m)));
    } else {
      throw Exception('Failed to load meals');
    }
  }
}
