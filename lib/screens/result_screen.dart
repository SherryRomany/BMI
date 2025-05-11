import 'package:flutter/material.dart';
import '../models/bmi_data.dart';
import '../widgets/bmi_gauge_painter.dart';
import 'history_screen.dart';

class ResultScreen extends StatefulWidget {
  final BMIData bmiData;
  final VoidCallback onReset;

  const ResultScreen({
    Key? key,
    required this.bmiData,
    required this.onReset,
  }) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool _historySaved = false;

  @override
  void initState() {
    super.initState();
    _saveToHistory();
  }

  void _saveToHistory() {
    if (!_historySaved) {
      widget.bmiData.saveToHistory();
      setState(() {
        _historySaved = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double bmi = widget.bmiData.calculateBMI();
    String category = widget.bmiData.getBMICategory();

    Color categoryColor;
    switch (category) {
      case 'underweight':
        categoryColor = Colors.blue;
        break;
      case 'normal':
        categoryColor = Colors.green;
        break;
      case 'overweight':
        categoryColor = Colors.orange;
        break;
      default:
        categoryColor = Colors.red;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculate BMI',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF4A4BB2),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.history,color: Colors.white,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HistoryScreen(bmiData: widget.bmiData),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Image.asset(
                      'assets/images/boy.png',
                      height: 60,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.boy, size: 60, color: Colors.blue);
                      },
                    ),
                    // Add check icon for male selection
                    if (widget.bmiData.gender == 'male')
                      const Icon(Icons.check, color: Colors.green),
                  ],
                ),
                Container(
                  height: 80,
                  width: 2,
                  color: Colors.grey[300],
                ),
                Column(
                  children: [
                    Image.asset(
                      'assets/images/girl.png',
                      height: 60,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.girl, size: 60, color: Colors.pink);
                      },
                    ),
                    if (widget.bmiData.gender == 'female')
                      const Icon(Icons.check, color: Colors.green),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildDataDisplay(
                  icon: Icons.person,
                  value: '${widget.bmiData.age}',
                  unit: 'Years',
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildDataDisplay(
                  icon: Icons.height,
                  value: '${widget.bmiData.height.toInt()}',
                  unit: 'cm',
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildDataDisplay(
                  icon: Icons.line_weight,
                  value: '${widget.bmiData.weight.toInt()}',
                  unit: 'kg',
                ),
              ],
            ),
            const SizedBox(height: 40),
            _buildBMIGauge(bmi),
            const SizedBox(height: 20),
            Text(
              bmi.toStringAsFixed(1),
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'You are ${category}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: categoryColor,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: widget.onReset,
                icon: const Icon(Icons.refresh),
                label: const Text('Try Again'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataDisplay({
    required IconData icon,
    required String value,
    required String unit,
  }) {
    return Row(
      children: [
        Icon(icon, color: Colors.amber, size: 30),
        const SizedBox(width: 10),
        Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          unit,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildBMIGauge(double bmi) {
    return Container(
      width: 300,
      height: 150,
      padding: const EdgeInsets.all(10),
      child: CustomPaint(
        painter: BMIGaugePainter(bmi: bmi),
        child: Container(),
      ),
    );
  }
}