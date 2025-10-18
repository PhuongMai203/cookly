import 'package:flutter/material.dart';

class LocationHeader extends StatelessWidget {
  const LocationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          'TP. Hồ Chí Minh',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        Text(
          'Xem tất cả',
          style: TextStyle(
            color: Color(0xFFCEA700),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
