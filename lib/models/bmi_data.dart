import 'bmi_history_entry.dart';

class BMIData {
  String gender = '';
  int age = 25;
  double height = 170;
  double weight = 50;
  List<BMIHistoryEntry> history = [];

  double calculateBMI() {
    double heightInMeters = height / 100;
    return weight / (heightInMeters * heightInMeters);
  }

  String getBMICategory() {
    double bmi = calculateBMI();
    if (bmi < 18.5) {
      return 'underweight';
    } else if (bmi >= 18.5 && bmi < 25) {
      return 'normal';
    } else if (bmi >= 25 && bmi < 30) {
      return 'overweight';
    } else {
      return 'obese';
    }
  }

  // Save current BMI to history
  void saveToHistory() {
    final entry = BMIHistoryEntry(
      date: DateTime.now(),
      height: height,
      weight: weight,
      bmi: calculateBMI(),
      category: getBMICategory(),
    );

    history.add(entry);
  }

  // Clear history
  void clearHistory() {
    history.clear();
  }
}