import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  List<String> categories = [];
  List<String> ingredients = [];
  List<String> areas = [];

  List<Map<String, dynamic>> meals = []; // 👉 Danh sách món ăn sau khi lọc

  String? selectedCategory;
  String? selectedIngredient;
  String? selectedArea;

  bool isLoading = true;
  bool isResultLoading = false; // 👉 Đang tải kết quả lọc

  @override
  void initState() {
    super.initState();
    _fetchFilters();
  }

  Future<void> _fetchFilters() async {
    try {
      final catRes = await http.get(
          Uri.parse('https://www.themealdb.com/api/json/v1/1/list.php?c=list'));
      final ingRes = await http.get(
          Uri.parse('https://www.themealdb.com/api/json/v1/1/list.php?i=list'));
      final areaRes = await http.get(
          Uri.parse('https://www.themealdb.com/api/json/v1/1/list.php?a=list'));

      if (catRes.statusCode == 200 &&
          ingRes.statusCode == 200 &&
          areaRes.statusCode == 200) {
        final catData = jsonDecode(catRes.body);
        final ingData = jsonDecode(ingRes.body);
        final areaData = jsonDecode(areaRes.body);

        setState(() {
          categories = (catData['meals'] as List)
              .map((e) => e['strCategory'] as String)
              .toList();
          ingredients = (ingData['meals'] as List)
              .map((e) => e['strIngredient'] as String)
              .toList();
          areas = (areaData['meals'] as List)
              .map((e) => e['strArea'] as String)
              .toList();
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Lỗi tải dữ liệu: $e');
    }
  }

  /// 👉 Hàm lọc món ăn
  Future<void> _fetchMeals() async {
    setState(() {
      isResultLoading = true;
      meals.clear();
    });

    String? apiUrl;

    if (selectedCategory != null) {
      apiUrl =
      'https://www.themealdb.com/api/json/v1/1/filter.php?c=$selectedCategory';
    } else if (selectedIngredient != null) {
      apiUrl =
      'https://www.themealdb.com/api/json/v1/1/filter.php?i=$selectedIngredient';
    } else if (selectedArea != null) {
      apiUrl =
      'https://www.themealdb.com/api/json/v1/1/filter.php?a=$selectedArea';
    }

    if (apiUrl != null) {
      try {
        final res = await http.get(Uri.parse(apiUrl));
        if (res.statusCode == 200) {
          final data = jsonDecode(res.body);
          setState(() {
            meals = (data['meals'] ?? []).cast<Map<String, dynamic>>();
          });
        }
      } catch (e) {
        debugPrint('Lỗi khi lọc món: $e');
      }
    }

    setState(() => isResultLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
      ),
      child: isLoading
          ? const Center(
          child: CircularProgressIndicator(color: Color(0xFFCEA700)))
          : Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              icon: const Icon(Icons.close_rounded,
                  color: Colors.black87, size: 24),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Lọc',
                style:
                TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFFFDFEE8),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    selectedCategory = null;
                    selectedIngredient = null;
                    selectedArea = null;
                    meals.clear();
                  });
                },
                child: const Text(
                  'Đặt lại',
                  style: TextStyle(
                      color: Color(0xFFCEA700),
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),
          Divider(color: Colors.grey.shade300, thickness: 1, height: 20),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSection(
                    title: 'Danh mục',
                    icon: Icons.category_outlined,
                    items: categories.take(5).toList(),
                    selected: selectedCategory,
                    onSelect: (v) =>
                        setState(() => selectedCategory = v),
                  ),
                  const SizedBox(height: 32),
                  _buildSection(
                    title: 'Nguyên liệu',
                    icon: Icons.fastfood_outlined,
                    items: ingredients.take(5).toList(),
                    selected: selectedIngredient,
                    onSelect: (v) =>
                        setState(() => selectedIngredient = v),
                  ),
                  const SizedBox(height: 32),
                  _buildSection(
                    title: 'Khu vực',
                    icon: Icons.location_on_outlined,
                    items: areas.take(5).toList(),
                    selected: selectedArea,
                    onSelect: (v) => setState(() => selectedArea = v),
                  ),
                  const SizedBox(height: 32),

                  if (isResultLoading)
                    const Center(
                        child: CircularProgressIndicator(
                            color: Color(0xFFCEA700)))
                ],
              ),
            ),
          ),

          Divider(color: Colors.grey.shade300, thickness: 1, height: 20),
          const SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFCEA700),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  await _fetchMeals();
                  if (context.mounted) {
                    Navigator.pop(context, meals); // 👉 Trả danh sách món về SearchPage
                  }
                },

                child: const Text(
                  'Xác nhận',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<String> items,
    required String? selected,
    required Function(String) onSelect,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 24, color: Colors.black54),
            const SizedBox(width: 6),
            Text(title,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.black87)),
          ],
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: items.map((item) {
            final isSelected = item == selected;
            return GestureDetector(
              onTap: () => onSelect(item),
              child: Container(
                width:
                (MediaQuery.of(context).size.width - 16 * 2 - 8 * 2) / 3,
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFCEA700) : Colors.white,
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFFCEA700)
                        : Colors.grey.shade300,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  item,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
