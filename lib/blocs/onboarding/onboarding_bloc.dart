import 'package:dualify_apprenticeship_aficorp/common/utils/app_constants.dart';
import 'package:dualify_apprenticeship_aficorp/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'onboarding_event.dart';
import 'onboarding_state.dart';
import 'dart:convert';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(OnboardingInitial()) {
    on<SubmitOnboarding>(_onSubmitOnboarding);
    on<LogoutCurrentUser>(_onLogoutCurrentUser);
  }

  Future<void> _onSubmitOnboarding(
    SubmitOnboarding event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(OnboardingLoading());
    try {
      event.user.setLoggedIn(true);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(AppConstants.userStorageKey, json.encode(event.user.toJson()));
      emit(OnboardingSuccess());
    } catch (e) {
      emit(OnboardingFailure(e.toString()));
    }
  }

  Future<void> _onLogoutCurrentUser(
    LogoutCurrentUser event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(UserLoggingOut());
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString(AppConstants.userStorageKey);
      if (userJson != null) {
        final user = User.fromJson(json.decode(userJson));
        user.setLoggedIn(false);
        await prefs.setString(AppConstants.userStorageKey, json.encode(user.toJson()));
      }
      emit(UserLoggedOut());
    } catch (e) {
      print("Error logging out user: ${e.toString()}");
    }
  }
}
