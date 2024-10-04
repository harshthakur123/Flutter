import 'package:flutter/material.dart';

class AdditionalInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const AdditionalInfoItem(
      {super.key,
      required this.icon,
      required this.label,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color.fromARGB(
            255, 46, 40, 57), // Light purple background for the card
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurpleAccent.withOpacity(0.2),
            offset: const Offset(0, 7),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          // Icon
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Color(0xFF8E2DE2),
                  Color(0xFF4A00E0)
                ], // Purple gradient
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Icon(
              icon,
              size: 36,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),

          // Label
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 255, 255, 255), // Deep purple for text
            ),
          ),
          const SizedBox(height: 8),

          // Humidity value
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color:
                  Color.fromARGB(255, 255, 255, 255), // Dark gray for clarity
            ),
          ),
        ],
      ),
    );
  }
}
