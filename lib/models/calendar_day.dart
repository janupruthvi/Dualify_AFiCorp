// CalendarDay model for 7-day calendar

enum CalendarDayType { school, work, off }

class CalendarDay {
  final String dayName;
  final CalendarDayType type;
  final String emoji;

  CalendarDay({
    required this.dayName,
    required this.type,
    required this.emoji,
  });

  factory CalendarDay.fromJson(Map<String, dynamic> json) {
    return CalendarDay(
      dayName: json['dayName'],
      type: CalendarDayType.values.firstWhere(
        (e) => e.toString() == 'CalendarDayType.${json['type']}',
      ),
      emoji: json['emoji'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dayName': dayName,
      'type': type.toString().split('.').last,
      'emoji': emoji,
    };
  }
}
