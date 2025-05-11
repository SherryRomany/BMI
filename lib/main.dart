import 'package:flutter/material.dart';
import 'screens/bmi_wizard.dart';

void main() {
  runApp(const BMICalculatorApp());
}

class BMICalculatorApp extends StatelessWidget {
  const BMICalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI Calculator',
      theme: ThemeData(
        primaryColor: const Color(0xFF4A4BB2),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFE91E63),
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          ),
        ),
      ),
      home: const BMIWizard(),
    );
  }
}