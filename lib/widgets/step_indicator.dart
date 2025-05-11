import 'package:flutter/material.dart';

Widget buildStepDot(String label, bool isActive, bool isCompleted) {
  return Column(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: isActive || isCompleted ? const Color(0xFFE91E63) : Colors.grey[300],
          shape: BoxShape.circle,
        ),
        child: isCompleted
            ? const Icon(Icons.check, color: Colors.white, size: 20)
            : null,
      ),
      const SizedBox(height: 5),
      Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: isActive || isCompleted ? Colors.black : Colors.grey,
        ),
      ),
    ],
  );
}

Widget buildStepLine(bool isActive) {
  return Container(
    width: 30,
    height: 2,
    color: isActive ? const Color(0xFFE91E63) : Colors.grey[300],
  );
}