import 'package:flutter/material.dart';
import 'filter_bottom_sheet.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool isFocused;
  final ValueChanged<bool> onFocusChange;
  final ValueChanged<String> onSearch;
  final Function(List<dynamic>) onSearchByFilter;

  const SearchBarWidget({
    super.key,
    required this.controller,
    required this.isFocused,
    required this.onFocusChange,
    required this.onSearch,
    required this.onSearchByFilter,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Focus(
            onFocusChange: onFocusChange,
            child: SizedBox(
              height: 40,
              child: TextField(
                controller: controller,
                onChanged: onSearch,
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm món ăn...',
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: isFocused
                      ? const Color(0xFFE0E0E0)
                      : const Color(0xFFF5F5F5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.filter_list_alt,
                color: Color(0xFFCEA700), size: 40),
            onPressed: () async {
              final result = await showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (_) => const FilterBottomSheet(),
              );

              if (result != null && result is List) {
                // Gọi callback ra ngoài để SearchPage xử lý
                onSearchByFilter(result);
              }
            },

          ),
        ),
      ],
    );
  }
}
