abstract class LoginEvent {}

class SubmitLogin extends LoginEvent {
  final String username;
  final String password;

  SubmitLogin({
    required this.username,
    required this.password,
  });
}

class CheckExistingLogin extends LoginEvent {
  final Function(bool) isLoggedIn;
  CheckExistingLogin(this.isLoggedIn);
}

class LogoutCurrentUser extends LoginEvent {
  LogoutCurrentUser();
}