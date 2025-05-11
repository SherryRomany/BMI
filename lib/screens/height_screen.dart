import 'package:flutter/material.dart';
import '../models/bmi_data.dart';
import '../widgets/step_indicator.dart';

class HeightScreen extends StatefulWidget {
  final BMIData bmiData;
  final VoidCallback onNext;

  const HeightScreen({
    Key? key,
    required this.bmiData,
    required this.onNext,
  }) : super(key: key);

  @override
  State<HeightScreen> createState() => _HeightScreenState();
}

class _HeightScreenState extends State<HeightScreen> {
  final TextEditingController _heightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize the controller with the current height
    _heightController.text = widget.bmiData.height.toStringAsFixed(0);

    // Add listener to update BMI data when text changes
    _heightController.addListener(_updateHeight);
  }

  void _updateHeight() {
    // Only update if the text is a valid number
    if (_heightController.text.isNotEmpty) {
      try {
        double height = double.parse(_heightController.text);
        if (height > 0) {
          setState(() {
            widget.bmiData.height = height;
          });
        }
      } catch (e) {
        // If parsing fails, don't update
      }
    }
  }

  void _incrementHeight() {
    if (widget.bmiData.height < 250) {
      setState(() {
        widget.bmiData.height += 1;
        _heightController.text = widget.bmiData.height.toStringAsFixed(0);
      });
    }
  }

  void _decrementHeight() {
    if (widget.bmiData.height > 50) {
      setState(() {
        widget.bmiData.height -= 1;
        _heightController.text = widget.bmiData.height.toStringAsFixed(0);
      });
    }
  }

  @override
  void dispose() {
    _heightController.removeListener(_updateHeight);
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Height',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold),),
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
                buildStepDot('Height', true, false),
                buildStepLine(false),
                buildStepDot('Weight', false, false),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'What is your height?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle_outline, size: 30),
                onPressed: _decrementHeight,
              ),
              SizedBox(
                width: 120,
                child: TextField(
                  controller: _heightController,
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
                onPressed: _incrementHeight,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'cm',
                style: TextStyle(fontSize: 18),
              ),
            ],
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