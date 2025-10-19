import 'package:dualify_apprenticeship_aficorp/common/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/user.dart';
import '../../blocs/onboarding/onboarding_bloc.dart';
import '../../blocs/onboarding/onboarding_event.dart';
import '../../blocs/onboarding/onboarding_state.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _tradeController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  DateTime? _startDate;

  bool _showPassword = false;
  bool _showConfirmPassword = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (_) => OnboardingBloc(),
      child: BlocListener<OnboardingBloc, OnboardingState>(
        listener: (context, state) {
          if (state is OnboardingSuccess) {
            Navigator.pushReplacementNamed(context, '/dashboard');
          } else if (state is OnboardingFailure) {
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
                                "Please Onboard",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Name field
                            CustomTextField(
                              controller: _nameController,
                              label: "Name",
                              hint: "Enter your name",
                              validator: (value) =>
                                  value!.isEmpty ? "Enter your name" : null,
                            ),
                            const SizedBox(height: 16),

                            // Trade field
                            CustomTextField(
                              controller: _tradeController,
                              label: "Trade",
                              hint: "Enter your trade",
                              validator: (value) =>
                                  value!.isEmpty ? "Enter your trade" : null,
                            ),
                            const SizedBox(height: 16),

                            // Start date picker
                            GestureDetector(
                              onTap: () async {
                                final picked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                );
                                if (picked != null) {
                                  setState(() => _startDate = picked);
                                }
                              },
                              child: AbsorbPointer(
                                child: CustomTextField(
                                  label: _startDate == null
                                      ? "Select start date"
                                      : _startDate!
                                          .toLocal()
                                          .toString()
                                          .split(' ')[0],
                                  suffixIcon:
                                      const Icon(Icons.calendar_today_outlined),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Duration field
                            CustomTextField(
                              controller: _durationController,
                              label: "Duration (months)",
                              hint: "e.g. 12",
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) return "Enter duration";
                                final n = int.tryParse(value);
                                if (n == null || n <= 0) {
                                  return "Enter valid number";
                                }
                                return null;
                              },
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
                                if (value.length < 6) {
                                  return "Password must be at least 6 characters";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),

                            // Confirm Password field
                            CustomTextField(
                              controller: _confirmPasswordController,
                              label: "Confirm Password",
                              hint: "Re-enter password",
                              obscureText: !_showConfirmPassword,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _showConfirmPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _showConfirmPassword = !_showConfirmPassword;
                                  });
                                },
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Confirm your password";
                                }
                                if (value != _passwordController.text) {
                                  return "Passwords do not match";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 24),

                            // Continue button
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
                                    onPressed: state is OnboardingLoading
                                        ? null
                                        : () {
                                            if (_formKey.currentState!
                                                    .validate() &&
                                                _startDate != null) {
                                              final user = User(
                                                name: _nameController.text,
                                                trade: _tradeController.text,
                                                startDate: _startDate!,
                                                durationMonths: int.parse(
                                                    _durationController.text),
                                                password: _passwordController.text,
                                              );
                                              context
                                                  .read<OnboardingBloc>()
                                                  .add(SubmitOnboarding(user));
                                            } else if (_startDate == null) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          "Please select a start date")));
                                            }
                                          },
                                    child: state is OnboardingLoading
                                        ? const CircularProgressIndicator(
                                            color: Colors.white,
                                          )
                                        : const Text(
                                            "Onboard User",
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
      ),
    );
  }

}
