import 'package:flutter/material.dart';

class MealDetailHeader extends StatelessWidget {
  final Map<String, dynamic> meal;
  const MealDetailHeader({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          meal['strMealThumb'],
          width: double.infinity,
          height: 280,
          fit: BoxFit.cover,
        ),
        Container(
          height: 100,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black54, Colors.transparent],
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).padding.top + 8,
          left: 16,
          child: Row(
            children: [
              InkWell(
                onTap: () => Navigator.pop(context),
                borderRadius: BorderRadius.circular(30),
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(Icons.arrow_back_ios_new, color: Colors.white),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                "Chi tiết",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
