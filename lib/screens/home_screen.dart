import 'package:flutter/material.dart';
import '../widgets/search_box.dart';
import '../widgets/location_header.dart';
import '../widgets/video_card_list.dart';
import '../widgets/category_list.dart';
import '../widgets/recent_list.dart';
import '../widgets/ingredient_chips.dart';
import '../widgets/section_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(height: 30),
              SearchBox(),
              SizedBox(height: 20),
              LocationHeader(),
              SizedBox(height: 12),
              VideoCardList(),
              SizedBox(height: 10),
              SectionHeader(title: 'Danh mục'),
              SizedBox(height: 12),
              IngredientChips(),
              SizedBox(height: 12),
              CategoryList(),
              SizedBox(height: 24),
              SectionHeader(title: 'Công thức gần đây'),
              SizedBox(height: 12),
              RecentList(),
              SectionHeader(title: 'Nguyên liệu'),
              SizedBox(height: 12),
              IngredientChips(),
              SizedBox(height: 12),
              IngredientChips(),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Icon(Icons.home, color: Color(0xFFCEA700), size: 30),
              Icon(Icons.search, color: Colors.grey, size: 30),
              Icon(Icons.bookmark, color: Colors.grey, size: 30),
              Icon(Icons.person, color: Colors.grey, size: 30),
            ],
          ),
        ),
      ),

      floatingActionButton: Container(
        width: 70,
        height: 70,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              Color(0xFFCEA700),
              Color(0xFFEFD503),
            ],
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
          onPressed: () {},
          backgroundColor: Colors.transparent,
          elevation: 0,
          shape: const CircleBorder(),
          child: const Icon(Icons.add, color: Colors.white, size: 36),
        ),
      ),


      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
