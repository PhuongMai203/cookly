import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/search_bar.dart';
import '../widgets/meal_grid.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  List<dynamic> _meals = [];
  bool _isLoading = false;
  bool _isFocused = false;

  Future<void> _searchMeals(String query) async {
    if (query.isEmpty) {
      setState(() => _meals = []);
      return;
    }

    setState(() => _isLoading = true);
    final url = Uri.parse('https://www.themealdb.com/api/json/v1/1/search.php?s=$query');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _meals = data['meals'] ?? [];
        _isLoading = false;
      });
    } else {
      setState(() {
        _meals = [];
        _isLoading = false;
      });
    }
  }
  void _updateMealsFromFilter(List<dynamic> filteredMeals) {
    setState(() {
      _meals = filteredMeals;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1EFEF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              SearchBarWidget(
                controller: _controller,
                isFocused: _isFocused,
                onFocusChange: (focus) => setState(() => _isFocused = focus),
                onSearch: _searchMeals,
                onSearchByFilter: _updateMealsFromFilter,

              ),
              const SizedBox(height: 20),
              if (_isLoading)
                const Center(child: CircularProgressIndicator())
              else if (_meals.isEmpty)
                const Text('Không có kết quả tìm kiếm.', style: TextStyle(color: Colors.grey))
              else
                Expanded(child: MealGrid(meals: _meals)),
            ],
          ),
        ),
      ),
    );
  }
}
