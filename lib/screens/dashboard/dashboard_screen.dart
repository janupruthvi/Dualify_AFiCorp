import 'package:dualify_apprenticeship_aficorp/blocs/dashboard/dashboard_event.dart';
import 'package:dualify_apprenticeship_aficorp/blocs/login/login_bloc.dart';
import 'package:dualify_apprenticeship_aficorp/blocs/login/login_event.dart';
import 'package:dualify_apprenticeship_aficorp/common/utils/app_utils.dart';
import 'package:dualify_apprenticeship_aficorp/screens/dashboard/dashboard_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/dashboard/dashboard_bloc.dart';
import '../../blocs/dashboard/dashboard_state.dart';
import '../../common/widgets/progress_bar.dart';
import '../../common/widgets/training_areas.dart';
import '../../common/widgets/calendar_section.dart';
import '../../common/widgets/question_of_the_day.dart';
import '../../models/user.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  User? _user;

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
    _loadUser();
  }

  void _loadUser() async {
    _user = await AppUtils.loadUser();
  }

  void _loadDashboardData() {
    context.read<DashboardBloc>().add(LoadDashboardData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: DashboardAppBar(
        onLogout: () {
          context.read<LoginBloc>().add(LogoutCurrentUser());
          Navigator.of(context).pushReplacementNamed('/login');
        },
      ),
      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DashboardFailure) {
            return Center(child: Text('Error: ${state.error}'));
          } else if (state is DashboardLoaded) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Progress Bar
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Builder(
                      builder: (context) {
                        if (_user == null) {
                          return const SizedBox.shrink();
                        } else {
                          return Padding(
                            padding: const EdgeInsets.all(17),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Welcome, ${_user?.name}!',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(height: 30),
                                ProgressBar(
                                  startDate: _user?.startDate ?? DateTime.now(),
                                  durationMonths: _user?.durationMonths ?? 0,
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Company Section
                  Container(
                    color: Colors.grey.shade300,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 25.0,
                      ),
                      child: TrainingAreasSection(
                        company: state.company,
                        school: state.school,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // 7-Day Emoji Calendar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: CalendarSection(
                      days: state.calendar,
                      startDate: _user?.startDate ?? DateTime.now(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Question of the Day
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: QuestionOfTheDay(
                      question: state.question,
                      onAnswer: (answer) {
                        // Optionally handle answer (e.g., save locally)
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Answer submitted!')),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
