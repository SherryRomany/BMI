import 'package:flutter/material.dart';
import '../models/bmi_data.dart';
import '../widgets/step_indicator.dart';
import 'history_screen.dart';

class GenderScreen extends StatefulWidget {
  final BMIData bmiData;
  final VoidCallback onNext;

  const GenderScreen({
    Key? key,
    required this.bmiData,
    required this.onNext,
  }) : super(key: key);

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Gender',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF4A4BB2),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      // Add drawer here
      drawer: _buildDrawer(context),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildStepDot('Gender', true, true),
                buildStepLine(false),
                buildStepDot('Age', false, false),
                buildStepLine(false),
                buildStepDot('Height', false, false),
                buildStepLine(false),
                buildStepDot('Weight', false, false),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'What is your gender?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildGenderOption('male'),
              _buildGenderOption('female'),
            ],
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: widget.bmiData.gender.isNotEmpty ? widget.onNext : null,
                child: const Text('NEXT'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build the drawer widget
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF4A4BB2),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.monitor_weight_outlined,
                    color: Colors.white,
                    size: 60,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'BMI Calculator',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: Color(0xFF4A4BB2)),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.history, color: Color(0xFF4A4BB2)),
            title: const Text('BMI History'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HistoryScreen(bmiData: widget.bmiData),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info_outline, color: Color(0xFF4A4BB2)),
            title: const Text('About BMI'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              _showAboutBMIDialog(context);
            },
          ),
        ],
      ),
    );
  }

  // Show info dialog about BMI
  void _showAboutBMIDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('About BMI'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'Body Mass Index (BMI) is a value derived from the mass (weight) and height of a person.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  'BMI Categories:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 5),
                Text('• Underweight: BMI less than 18.5'),
                Text('• Normal weight: BMI 18.5–24.9'),
                Text('• Overweight: BMI 25–29.9'),
                Text('• Obesity: BMI 30 or more'),
                SizedBox(height: 10),
                Text(
                  'BMI is a screening tool, but it does not diagnose the body fatness or health of an individual.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('CLOSE'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildGenderOption(String gender) {
    bool isSelected = widget.bmiData.gender == gender;

    return GestureDetector(
      onTap: () {
        setState(() {
          widget.bmiData.gender = gender;
        });
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected ? const Color(0xFFE91E63) : Colors.transparent,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(
              'assets/images/${gender}_avatar.png',
              height: 120,
              width: 100,
              fit: BoxFit.contain,
              // Use appropriate placeholder if actual assets are not available
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 120,
                  width: 100,
                  color: Colors.grey[300],
                  child: gender == 'male'
                      ? const Icon(Icons.man, size: 60, color: Colors.blue)
                      : const Icon(Icons.woman, size: 60, color: Colors.pink),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          if (isSelected)
            const Icon(Icons.check_circle, color: Color(0xFFE91E63), size: 30),
        ],
      ),
    );
  }
}