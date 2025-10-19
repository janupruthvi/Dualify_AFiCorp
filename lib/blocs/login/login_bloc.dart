import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dualify_apprenticeship_aficorp/common/utils/app_constants.dart';
import 'package:dualify_apprenticeship_aficorp/models/user.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<CheckExistingLogin>(_onCheckExistingLogin);
    on<SubmitLogin>(_onSubmitLogin);
    on<LogoutCurrentUser>(_onLogoutCurrentUser);
  }

  /// Checks if a user is already logged in
  Future<void> _onCheckExistingLogin(
    CheckExistingLogin event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString(AppConstants.userStorageKey);

      if (userJson != null) {
        final user = User.fromJson(json.decode(userJson));
        if (user.isLoggedIn) {
          event.isLoggedIn(true);
          emit(LoginSuccess(user));
          return;
        } else {
          event.isLoggedIn(false);
          emit(LoginInitial());
          return;
        }
      }

      emit(LoginInitial());
    } catch (e) {
      emit(LoginFailure("Failed to check login: ${e.toString()}"));
    }
  }

  /// Handles user login
  Future<void> _onSubmitLogin(
    SubmitLogin event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString(AppConstants.userStorageKey);

      if (userJson == null) {
        emit(LoginFailure("No registered user found. Please sign up first."));
        return;
      }

      final storedUser = User.fromJson(json.decode(userJson));

      // Simple validation - you can replace this with API call or backend logic
      if (storedUser.name == event.username &&
          storedUser.password == event.password) {
        storedUser.setLoggedIn(true);
        await prefs.setString(
          AppConstants.userStorageKey,
          json.encode(storedUser.toJson()),
        );

        emit(LoginSuccess(storedUser));
      } else {
        emit(LoginFailure("Invalid credentials. Please try again."));
      }
    } catch (e) {
      emit(LoginFailure("Error during login: ${e.toString()}"));
    }
  }

  /// Logs out current user
  Future<void> _onLogoutCurrentUser(
    LogoutCurrentUser event,
    Emitter<LoginState> emit,
  ) async {
    emit(UserLoggingOut());
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString(AppConstants.userStorageKey);

      if (userJson != null) {
        final user = User.fromJson(json.decode(userJson));
        user.setLoggedIn(false);
        await prefs.setString(
          AppConstants.userStorageKey,
          json.encode(user.toJson()),
        );
      }

      emit(UserLoggedOut());
    } catch (e) {
      emit(LoginFailure("Error logging out: ${e.toString()}"));
    }
  }
}
