import 'package:flutter/material.dart';
import '../models/bmi_data.dart';
import '../widgets/step_indicator.dart';

class WeightScreen extends StatefulWidget {
  final BMIData bmiData;
  final VoidCallback onNext;

  const WeightScreen({
    Key? key,
    required this.bmiData,
    required this.onNext,
  }) : super(key: key);

  @override
  State<WeightScreen> createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
  final TextEditingController _weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize the controller with the current weight
    _weightController.text = widget.bmiData.weight.toStringAsFixed(0);

    // Add listener to update BMI data when text changes
    _weightController.addListener(_updateWeight);
  }

  void _updateWeight() {
    // Only update if the text is a valid number
    if (_weightController.text.isNotEmpty) {
      try {
        double weight = double.parse(_weightController.text);
        if (weight > 0) {
          setState(() {
            widget.bmiData.weight = weight;
          });
        }
      } catch (e) {
        // If parsing fails, don't update
      }
    }
  }

  void _incrementWeight() {
    setState(() {
      widget.bmiData.weight += 1;
      _weightController.text = widget.bmiData.weight.toStringAsFixed(0);
    });
  }

  void _decrementWeight() {
    if (widget.bmiData.weight > 1) {
      setState(() {
        widget.bmiData.weight -= 1;
        _weightController.text = widget.bmiData.weight.toStringAsFixed(0);
      });
    }
  }

  @override
  void dispose() {
    _weightController.removeListener(_updateWeight);
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weight',
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
                buildStepDot('Age', false, true),
                buildStepLine(true),
                buildStepDot('Height', false, true),
                buildStepLine(true),
                buildStepDot('Weight', true, false),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'What is your weight?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle_outline, size: 30),
                onPressed: _decrementWeight,
              ),
              SizedBox(
                width: 120,
                child: TextField(
                  controller: _weightController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle_outline, size: 30),
                onPressed: _incrementWeight,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'kg',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Image.asset(
            'assets/images/weight_scale.png',
            height: 150,
            // Use appropriate placeholder if actual assets are not available
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 150,
                width: 150,
                color: Colors.teal[100],
                child: const Icon(Icons.scale, size: 80, color: Colors.teal),
              );
            },
          ),
          const SizedBox(height: 10),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: widget.onNext,
                child: const Text('SUBMIT'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}