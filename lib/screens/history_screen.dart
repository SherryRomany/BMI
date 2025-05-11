import 'package:flutter/material.dart';
import '../models/bmi_data.dart';
import '../models/bmi_history_entry.dart';

class HistoryScreen extends StatefulWidget {
  final BMIData bmiData;

  const HistoryScreen({
    Key? key,
    required this.bmiData,
  }) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI History',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF4A4BB2),
        centerTitle: true,
        iconTheme: const IconThemeData(
        color: Colors.white,),
        actions: [
          if (widget.bmiData.history.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep,color: Colors.white,),
              onPressed: () {
                _showClearHistoryDialog();
              },
            ),
        ],
      ),
      body: widget.bmiData.history.isEmpty
          ? const Center(
        child: Text(
          'No history yet',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : ListView.builder(
        itemCount: widget.bmiData.history.length,
        itemBuilder: (context, index) {
          // Display items in reverse chronological order
          final entry = widget.bmiData.history[widget.bmiData.history.length - 1 - index];
          return _buildHistoryCard(entry);
        },
      ),
    );
  }

  Widget _buildHistoryCard(BMIHistoryEntry entry) {
    Color categoryColor;
    switch (entry.category) {
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

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${_formatDate(entry.date)}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'BMI: ${entry.bmi.toStringAsFixed(1)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: categoryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    _capitalizeFirst(entry.category),
                    style: TextStyle(
                      color: categoryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.height, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  '${entry.height.toInt()} cm',
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.line_weight, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  '${entry.weight.toInt()} kg',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    // Simple date formatting without dependencies
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];

    final day = date.day;
    final month = months[date.month - 1];
    final year = date.year;

    final hour = date.hour;
    final minute = date.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';
    final hourFormatted = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);

    return '$month $day, $year - $hourFormatted:$minute $period';
  }

  String _capitalizeFirst(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  void _showClearHistoryDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Clear History'),
          content: const Text('Are you sure you want to clear all BMI history?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('CANCEL'),
            ),
            TextButton(
              onPressed: () {
                widget.bmiData.clearHistory();
                setState(() {});
                Navigator.of(context).pop();
              },
              child: const Text('CLEAR'),
            ),
          ],
        );
      },
    );
  }
}