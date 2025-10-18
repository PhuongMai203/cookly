import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        'image': 'assets/images/fied_egg.jpg',
        'title': 'Trứng chiên',
        'author': 'Trần Đình Trọng',
        'time': '20 phút',
      },
      {
        'image': 'assets/images/fied_egg.jpg',
        'title': 'Trứng chiên',
        'author': 'Nguyễn Thị Hoa',
        'time': '15 phút',
      },
      {
        'image': 'assets/images/fied_egg.jpg',
        'title': 'Trứng chiên',
        'author': 'Phạm Văn Nam',
        'time': '25 phút',
      },
    ];

    return SizedBox(
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Container(
            width: 150,
            margin: const EdgeInsets.only(right: 16),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned.fill(
                  top: 40,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF9E5),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.only(
                      top: 48,
                      left: 12,
                      right: 12,
                      bottom: 12,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          item['title']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF885D0B),
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                        const SizedBox(height: 2),

                        Column(
                          children: [
                            const Text(
                              'Tạo bởi',
                              style: TextStyle(
                                color: Color(0xFF432805),
                                fontSize: 11.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              item['author']!,
                              style: const TextStyle(
                                color: Color(0xFF432805),
                                fontSize: 12.5,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),

                        const SizedBox(height: 40),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item['time']!,
                              style: const TextStyle(
                                color: Color(0xFF885D0B),
                                fontSize: 12.5,
                              ),
                            ),
                            const Icon(
                              Icons.library_books_outlined,
                              size: 25,
                              color: Color(0xFF885D0B),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // 🟡 Ảnh tròn nổi phía trên
                Positioned(
                  top: 0,
                  left: 35,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(item['image']!),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
