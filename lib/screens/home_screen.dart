import 'package:cookly/screens/search_page.dart';
import 'package:cookly/widgets/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:cookly/widgets/custom_bottom_nav_bar.dart';
import 'package:cookly/screens/bookmark_page.dart';
import 'profile_page.dart';
import '../widgets/search_box.dart';
import '../widgets/location_header.dart';
import '../widgets/video_card_list.dart';
import '../widgets/category_list.dart';
import '../widgets/recent_list.dart';
import '../widgets/ingredient_chips.dart';
import '../widgets/section_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const _HomeContent(),
    const SearchPage(),
    const BookmarkPage(),
    const ProfilePage(),

  ];

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1EFEF),
      body: _pages[_currentIndex],

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
        currentIndex: _currentIndex,
        onTabSelected: _onTabSelected,
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
    );
  }
}
