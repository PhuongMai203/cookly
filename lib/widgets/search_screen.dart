import 'dart:convert';
import 'package:cookly/widgets/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  List<dynamic> _results = [];
  bool _isLoading = false;
  bool _isFocused = false;

  Future<void> _searchMeals(String query) async {
    if (query.isEmpty) {
      setState(() => _results = []);
      return;
    }

    setState(() => _isLoading = true);
    final url = Uri.parse('https://www.themealdb.com/api/json/v1/1/search.php?s=$query');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _results = data['meals'] ?? [];
        _isLoading = false;
      });
    } else {
      setState(() {
        _results = [];
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1EFEF),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(height: 40),
            Focus(
              onFocusChange: (hasFocus) {
                setState(() => _isFocused = hasFocus);
              },
              child: SizedBox(
                height: 40,
                child: TextField(
                  controller: _controller,
                  onChanged: _searchMeals,
                  decoration: InputDecoration(
                    hintText: 'Tìm kiếm món ăn...',
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                    filled: true,
                    fillColor: const Color(0xFFE5E3E3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                  ),
                ),
              ),

            ),
            if (_isLoading) const CircularProgressIndicator(),
            if (!_isLoading)
              Expanded(
                child: ListView.builder(
                  itemCount: _results.length,
                  itemBuilder: (context, index) {
                    final meal = _results[index];
                    return ListTile(
                      title: Text(
                        meal['strMeal'],
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: Color(0xFFCEA700),
                        size: 16,
                      ),
                      onTap: () {
                        // TODO: Mở chi tiết món ăn
                      },
                    );
                  },
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: Container(
        width: 80,
        height: 80,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [Color(0xFFCEA700), Color(0xFFEFD503)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () {
            // hành động khi bấm "+"
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          shape: const CircleBorder(),
          child: const Icon(Icons.add, color: Colors.white, size: 36),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 0,
        onTabSelected: (index) {
          Navigator.pop(context); // trở lại Home khi đổi tab
        },
      ),
    );

  }
}
