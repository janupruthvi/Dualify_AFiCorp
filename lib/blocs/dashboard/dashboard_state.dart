import '../../models/company.dart';
import '../../models/school.dart';
import '../../models/calendar_day.dart';
import '../../models/question.dart';

abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final Company company;
  final School school;
  final List<CalendarDay> calendar;
  final Question question;

  DashboardLoaded({
    required this.company,
    required this.school,
    required this.calendar,
    required this.question,
  });
}

class DashboardFailure extends DashboardState {
  final String error;
  DashboardFailure(this.error);
}
