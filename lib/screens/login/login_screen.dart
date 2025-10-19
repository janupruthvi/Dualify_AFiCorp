import 'package:dualify_apprenticeship_aficorp/blocs/login/login_bloc.dart';
import 'package:dualify_apprenticeship_aficorp/blocs/login/login_event.dart';
import 'package:dualify_apprenticeship_aficorp/blocs/login/login_state.dart';
import 'package:dualify_apprenticeship_aficorp/common/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/onboarding/onboarding_bloc.dart';
import '../../blocs/onboarding/onboarding_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          Navigator.pushReplacementNamed(context, '/dashboard');
        } else if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.error}')),
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F8FA),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // App name
                  Text(
                    "Dualify AFiCorp",
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: Colors.amber[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 24),
    
                  // Card container
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 32),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(15),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(
                              "Please Login",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
    
                          // Username field
                          CustomTextField(
                            controller: _usernameController,
                            label: "Name",
                            hint: "Enter your name you used to onboard",
                            validator: (value) =>
                                value!.isEmpty ? "Enter your name" : null,
                          ),
                          const SizedBox(height: 16),
    
                          // Password field
                          CustomTextField(
                            controller: _passwordController,
                            label: "Password",
                            hint: "Enter password",
                            obscureText: !_showPassword,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _showPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _showPassword = !_showPassword;
                                });
                              },
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter password";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
    
                          // Login button
                          BlocBuilder<OnboardingBloc, OnboardingState>(
                            builder: (context, state) {
                              return SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Colors.amber[800],
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                  ),
                                  onPressed:
                                      state is OnboardingLoading
                                          ? null
                                          : () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              context.read<LoginBloc>().add(
                                                SubmitLogin(
                                                  username:
                                                      _usernameController.text,
                                                  password:
                                                      _passwordController.text,
                                                ),
                                              );
                                            }
                                          },
                                  child: state is LoginLoading
                                      ? const CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : const Text(
                                          "Login",
                                          style:
                                              TextStyle(color: Colors.white),
                                        ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
