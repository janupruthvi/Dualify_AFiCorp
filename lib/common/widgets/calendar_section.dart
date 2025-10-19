import 'package:dualify_apprenticeship_aficorp/common/utils/app_utils.dart';
import 'package:flutter/material.dart';
import '../../models/calendar_day.dart';

class CalendarSection extends StatelessWidget {
  final List<CalendarDay> days;
  final int? todayIndex;
  final DateTime startDate;

  const CalendarSection({
    super.key,
    required this.days,
    this.todayIndex,
    required this.startDate,
  });

  @override
  Widget build(BuildContext context) {
    // Monday of the current week
    final DateTime startOfWeek = DateTime.now().subtract(
      Duration(days: DateTime.now().weekday - 1),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Calendar',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(days.length, (index) {
            final DateTime currentDay = startOfWeek.add(Duration(days: index));
            final int currentTodayIndex = todayIndex ?? DateTime.now().weekday - 1;
            Color borderColor;
            Color fillColor = Colors.transparent;

            if (currentDay.isBefore(startDate)) {
              borderColor = Colors.grey.shade200;
              fillColor = Colors.grey.shade200;
            } else if (index < currentTodayIndex) {
              borderColor = Colors.orange;
            } else if (index == currentTodayIndex) {
              borderColor = Colors.blue.shade200;
              fillColor = Colors.blue.shade100;
            } else {
              borderColor = Colors.grey.shade300;
            }

            return Column(
              children: [
                Text(
                  days[index].dayName,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 6),
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: fillColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: borderColor, width: 2),
                  ),
                  alignment: Alignment.center,
                  child: currentDay.isBefore(startDate)
                      ? const SizedBox.shrink()
                      : AppUtils.buildDayIcon(days[index].type.toString().split('.').last),
                ),
              ],
            );
          }),
        ),
      ],
    );
  }
}
