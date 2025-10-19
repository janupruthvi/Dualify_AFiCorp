import 'package:dualify_apprenticeship_aficorp/app_init.dart';
import 'package:dualify_apprenticeship_aficorp/blocs/dashboard/dashboard_bloc.dart';
import 'package:dualify_apprenticeship_aficorp/blocs/login/login_bloc.dart';
import 'package:dualify_apprenticeship_aficorp/blocs/onboarding/onboarding_bloc.dart';
import 'package:dualify_apprenticeship_aficorp/screens/dashboard/dashboard_screen.dart';
import 'package:dualify_apprenticeship_aficorp/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens/onboarding/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DashboardBloc>(create: (context) => DashboardBloc()),
        BlocProvider<LoginBloc>(create: (context) => LoginBloc()),
        BlocProvider<OnboardingBloc>(create: (context) => OnboardingBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Dualify AFiCorp',
        theme: ThemeData(),
        home: AppInit(),
        routes: {
          '/dashboard': (context) => DashboardScreen(),
          '/onboarding': (context) => OnboardingScreen(),
          '/login': (context) => LoginScreen(),
        },
      ),
    );
  }
}
