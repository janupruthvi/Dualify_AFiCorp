import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final DateTime startDate;
  final int durationMonths;

  const ProgressBar({
    super.key,
    required this.startDate,
    required this.durationMonths,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final endDate = DateTime(
      startDate.year,
      startDate.month + durationMonths,
      startDate.day,
    );
    final totalDays = endDate.difference(startDate).inDays;
    final completedDays =
        now.isBefore(startDate)
            ? 0
            : now.isAfter(endDate)
            ? totalDays
            : now.difference(startDate).inDays;
    final progress = totalDays > 0 ? completedDays / totalDays : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Apprenticeship Progress',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            minHeight: 10,
            color: Colors.orange,
            backgroundColor: Colors.grey.shade300,
          ),
        ),
      ],
    );
  }
}
