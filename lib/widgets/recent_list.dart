import 'package:flutter/material.dart';

class RecentList extends StatelessWidget {
  const RecentList({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        'image': 'assets/images/salads.jpg',
        'title': 'Trứng chiên',
        'author': 'Trần Đình Trọng',
      },
      {
        'image': 'assets/images/salads.jpg',
        'title': 'Trứng chiên',
        'author': 'Trần Đình Trọng',
      },
      {
        'image': 'assets/images/salads.jpg',
        'title': 'Trứng chiên',
        'author': 'Trần Đình Trọng',
      },
    ];

    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Container(
            width: 150,
            margin: const EdgeInsets.only(right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🖼 Ảnh món ăn
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    item['image']!,
                    height: 120,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 6),

                // 🍳 Tên món ăn
                Text(
                  item['title']!,
                  style: const TextStyle(
                    color: Color(0xFF885D0B),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 4),

                // 👩‍🍳 Avatar + tên người tạo
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 12,
                      backgroundImage: AssetImage('assets/images/user.jpg'),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        item['author']!,
                        style: const TextStyle(
                          color: Color(0xFF0043B3),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
