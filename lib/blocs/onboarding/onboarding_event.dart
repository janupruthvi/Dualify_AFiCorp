import '../../models/user.dart';

abstract class OnboardingEvent {}

class SubmitOnboarding extends OnboardingEvent {
  final User user;
  SubmitOnboarding(this.user);
}

class LogoutCurrentUser extends OnboardingEvent {
  LogoutCurrentUser();
}
