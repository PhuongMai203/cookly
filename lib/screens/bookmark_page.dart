import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  int _selectedTab = 0;
  List<dynamic> _meals = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMeals();
  }

  Future<void> fetchMeals() async {
    setState(() => _isLoading = true);
    final url = Uri.parse('https://www.themealdb.com/api/json/v1/1/search.php?s=');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final allMeals = data['meals'] ?? [];

      setState(() {
        _meals = allMeals;
        _isLoading = false;
      });
    } else {
      setState(() => _isLoading = false);
    }
  }

  List<dynamic> get filteredMeals {
    if (_selectedTab == 0) {
      // Tab Video: chỉ món có video YouTube
      return _meals.where((m) => (m['strYoutube'] ?? '').isNotEmpty).toList();
    } else {
      // Tab Công thức: món không có video
      return _meals.where((m) => (m['strYoutube'] ?? '').isEmpty).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final displayedMeals = filteredMeals;

    return Scaffold(
      backgroundColor: const Color(0xFFF1EFEF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFCEA700)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Công thức",
          style: TextStyle(
            color: Color(0xFFA47804),
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            color: Color(0xFFDDDDDD),
            thickness: 1,
            height: 1,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedTab = 0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: _selectedTab == 0
                            ? const Color(0xFFCEA700)
                            : const Color(0xFFFCFFC2),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Video",
                        style: TextStyle(
                          color: _selectedTab == 0
                              ? Colors.white
                              : const Color(0xFFCEA700),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedTab = 1),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: _selectedTab == 1
                            ? const Color(0xFFCEA700)
                            : const Color(0xFFFCFFC2),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Công thức",
                        style: TextStyle(
                          color: _selectedTab == 1
                              ? Colors.white
                              : const Color(0xFFCEA700),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator(color: Color(0xFFCEA700)))
                : displayedMeals.isEmpty
                ? const Center(
              child: Text(
                "Không có món ăn nào.",
                style: TextStyle(color: Colors.grey),
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: displayedMeals.length,
              itemBuilder: (context, index) {
                final meal = displayedMeals[index];
                return _buildMealCard(meal);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMealCard(dynamic meal) {
    final imageUrl = meal['strMealThumb'];
    final title = meal['strMeal'];
    final youtube = meal['strYoutube'];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ảnh + nút play
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  imageUrl,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFD503),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.star,
                          color: Colors.white, size: 14),
                      SizedBox(width: 2),
                      Text(
                        '5',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if ((youtube ?? '').isNotEmpty)
                Positioned.fill(
                  child: Center(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFB8B1B1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.play_arrow, color: Colors.white, size: 40),
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Row(
                    children: const [

                      Text(
                        '1 tiếng 20 phút',
                        style: TextStyle(
                          color: Color(0xFF0435A1),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 230),

                      Icon(
                        Icons.favorite_border,
                        size: 22,
                      ),
                    ],
                  ),
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 6),
                const Row(
                  children: [
                    CircleAvatar(
                      radius: 10,
                      backgroundImage: AssetImage('assets/images/user.jpg'),
                    ),
                    SizedBox(width: 6),
                    Text(
                      "Đinh Trọng Phúc",
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFFA47804),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
