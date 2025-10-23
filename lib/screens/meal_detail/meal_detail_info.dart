import 'package:flutter/material.dart';

class MealDetailInfo extends StatelessWidget {
  final Map<String, dynamic> meal;
  const MealDetailInfo({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  meal['strMeal'],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.favorite_border, color: Color(0xFF6E6767)),
                onPressed: () {},
              ),
            ],
          ),
          Text(meal['strCategory'] ?? '', style: const TextStyle(color: Color(0xFF6E6767))),
          const SizedBox(height: 8),
          Row(
            children: const [
              Icon(Icons.star, color: Colors.amber, size: 18),
              SizedBox(width: 4),
              Text("4.2", style: TextStyle(color: Color(0xFF6E6767))),
              SizedBox(width: 8),
              Text("|", style: TextStyle(color: Color(0xFF6E6767))),
              SizedBox(width: 8),
              Text("120 đánh giá", style: TextStyle(color: Color(0xFF6E6767))),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: const [
              CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=12"),
              ),
              SizedBox(width: 8),
              Text("Đinh Trọng Phúc", style: TextStyle(fontWeight: FontWeight.w600)),
              Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
