import 'package:flutter/material.dart';
import '../models/bmi_data.dart';
import '../widgets/step_indicator.dart';

class AgeScreen extends StatefulWidget {
  final BMIData bmiData;
  final VoidCallback onNext;

  const AgeScreen({
    Key? key,
    required this.bmiData,
    required this.onNext,
  }) : super(key: key);

  @override
  State<AgeScreen> createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Age',
        style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF4A4BB2),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildStepDot('Gender', false, true),
                buildStepLine(true),
                buildStepDot('Age', true, false),
                buildStepLine(false),
                buildStepDot('Height', false, false),
                buildStepLine(false),
                buildStepDot('Weight', false, false),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'What is your age?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle_outline, size: 30),
                onPressed: () {
                  setState(() {
                    if (widget.bmiData.age > 1) {
                      widget.bmiData.age -= 1;
                    }
                  });
                },
              ),
              const SizedBox(width: 20),
              Text(
                widget.bmiData.age.toString(),
                style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 20),
              IconButton(
                icon: const Icon(Icons.add_circle_outline, size: 30),
                onPressed: () {
                  setState(() {
                    if (widget.bmiData.age < 120) {
                      widget.bmiData.age += 1;
                    }
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Years',
            style: TextStyle(fontSize: 18),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: widget.onNext,
                child: const Text('NEXT'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}