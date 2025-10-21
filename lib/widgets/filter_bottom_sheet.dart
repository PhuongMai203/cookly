import 'package:flutter/material.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  // Danh sách mẫu
  final List<String> categories = ['Danh mục 1', 'Danh mục 2', 'Danh mục 3', 'Danh mục 4'];
  final List<String> ingredients = ['Thịt gà', 'Thịt heo', 'Danh mục', 'Ức gà', 'Chân gà'];
  final List<String> areas = ['TP.HCM', 'Bình Phước', 'Đồng Nai', 'An Giang', 'Long An'];

  // Giá trị chọn
  String? selectedCategory;
  String? selectedIngredient;
  String? selectedArea;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thanh tiêu đề
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Lọc', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextButton(
                onPressed: () {
                  setState(() {
                    selectedCategory = null;
                    selectedIngredient = null;
                    selectedArea = null;
                  });
                },
                child: const Text('Đặt lại',
                    style: TextStyle(color: Color(0xFFCEA700), fontWeight: FontWeight.w500)),
              ),
            ],
          ),

          const SizedBox(height: 8),
          _buildSection(
            title: 'Danh mục',
            icon: Icons.category_outlined,
            items: categories,
            selected: selectedCategory,
            onSelect: (v) => setState(() => selectedCategory = v),
          ),

          const SizedBox(height: 12),
          _buildSection(
            title: 'Nguyên liệu',
            icon: Icons.fastfood_outlined,
            items: ingredients,
            selected: selectedIngredient,
            onSelect: (v) => setState(() => selectedIngredient = v),
          ),

          const SizedBox(height: 12),
          _buildSection(
            title: 'Khu vực',
            icon: Icons.location_on_outlined,
            items: areas,
            selected: selectedArea,
            onSelect: (v) => setState(() => selectedArea = v),
          ),

          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 45,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFCEA700),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Xác nhận',
                  style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  // Hàm dựng từng mục (danh mục, nguyên liệu, khu vực)
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
            Icon(icon, size: 18, color: Colors.black54),
            const SizedBox(width: 4),
            Text(title,
                style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black87)),
          ],
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: items.map((item) {
            final isSelected = item == selected;
            return GestureDetector(
              onTap: () => onSelect(item),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFFFF4CC) : Colors.white,
                  border: Border.all(
                    color: isSelected ? const Color(0xFFCEA700) : Colors.grey.shade300,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  item,
                  style: TextStyle(
                    color: isSelected ? const Color(0xFFCEA700) : Colors.black87,
                    fontSize: 13,
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
