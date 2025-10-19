import 'package:dualify_apprenticeship_aficorp/blocs/login/login_bloc.dart';
import 'package:dualify_apprenticeship_aficorp/blocs/login/login_event.dart';
import 'package:dualify_apprenticeship_aficorp/common/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppInit extends StatefulWidget {
  const AppInit({super.key});

  @override
  State<AppInit> createState() => _AppInitState();
}

class _AppInitState extends State<AppInit> {
  @override
  void initState() {
    super.initState();
    loadInitScreen();
  }

  void loadInitScreen() async {
    final user = await AppUtils.loadUser();
    if (!mounted) {
      return;
    }
    if (user != null) {
      context.read<LoginBloc>().add(
        CheckExistingLogin((isLoggedIn) {
          if (!isLoggedIn) {
            Navigator.pushReplacementNamed(context, '/login');
          } else {
            Navigator.pushReplacementNamed(context, '/dashboard');
          }
        }),
      );
    } else {
      Navigator.pushReplacementNamed(context, '/onboarding');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text(
          'Dualify AFiCorp',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.amber,
          ),
        ),
      ),
    );
  }
}
