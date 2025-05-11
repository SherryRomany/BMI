import 'package:flutter/material.dart';
import '../../models/bmi_data.dart';
import 'gender_screen.dart';
import 'age_screen.dart';
import 'height_screen.dart';
import 'weight_screen.dart';
import 'result_screen.dart';

class BMIWizard extends StatefulWidget {
  const BMIWizard({Key? key}) : super(key: key);

  @override
  State<BMIWizard> createState() => _BMIWizardState();
}

class _BMIWizardState extends State<BMIWizard> {
  final BMIData _bmiData = BMIData();
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getStepScreen(),
    );
  }

  Widget _getStepScreen() {
    switch (_currentStep) {
      case 0:
        return GenderScreen(
          bmiData: _bmiData,
          onNext: () {
            setState(() {
              _currentStep = 1;
            });
          },
        );
      case 1:
        return AgeScreen(
          bmiData: _bmiData,
          onNext: () {
            setState(() {
              _currentStep = 2;
            });
          },
        );
      case 2:
        return HeightScreen(
          bmiData: _bmiData,
          onNext: () {
            setState(() {
              _currentStep = 3;
            });
          },
        );
      case 3:
        return WeightScreen(
          bmiData: _bmiData,
          onNext: () {
            setState(() {
              _currentStep = 4;
            });
          },
        );
      case 4:
        return ResultScreen(
          bmiData: _bmiData,
          onReset: () {
            setState(() {
              _bmiData.gender = '';
              _bmiData.age = 25;
              _bmiData.height = 170;
              _bmiData.weight = 50;
              _currentStep = 0;
            });
          },
        );
      default:
        return GenderScreen(
          bmiData: _bmiData,
          onNext: () {
            setState(() {
              _currentStep = 1;
            });
          },
        );
    }
  }
}