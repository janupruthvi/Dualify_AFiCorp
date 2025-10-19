import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import '../models/company.dart';
import '../models/school.dart';
import '../models/calendar_day.dart';
import '../models/question.dart';

class DataLoader {
  static Future<Map<String, dynamic>> _loadJson() async {
    final String jsonString = await rootBundle.loadString('assets/mock_data.json');
    return json.decode(jsonString);
  }

  static Future<Company> loadCompany() async {
    final data = await _loadJson();
    return Company.fromJson(data['company']);
  }

  static Future<School> loadSchool() async {
    final data = await _loadJson();
    return School.fromJson(data['school']);
  }

  static Future<List<CalendarDay>> loadCalendar() async {
    final data = await _loadJson();
    return (data['calendar'] as List)
        .map((e) => CalendarDay.fromJson(e))
        .toList();
  }

  static Future<Question> loadQuestion() async {
    final data = await _loadJson();
    return Question.fromJson(data['question']);
  }
}
