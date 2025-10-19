import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/data_loader.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<LoadDashboardData>(_onLoadDashboardData);
  }

  Future<void> _onLoadDashboardData(
    LoadDashboardData event,
    Emitter<DashboardState> emit,
  ) async {
    emit(DashboardLoading());
    try {
      final company = await DataLoader.loadCompany();
      final school = await DataLoader.loadSchool();
      final calendar = await DataLoader.loadCalendar();
      final question = await DataLoader.loadQuestion();
      emit(DashboardLoaded(
        company: company,
        school: school,
        calendar: calendar,
        question: question,
      ));
    } catch (e) {
      emit(DashboardFailure(e.toString()));
    }
  }
}
