import 'package:flutter/material.dart';

class InstructionSection extends StatelessWidget {
  final Map<String, dynamic> meal;
  const InstructionSection({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Cách chế biến",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        Text(
          meal['strInstructions'] ?? '',
          textAlign: TextAlign.justify,
          style: const TextStyle(height: 1.5),
        ),
      ],
    );
  }
}
