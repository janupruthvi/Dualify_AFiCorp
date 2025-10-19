// User model for onboarding and dashboard

class User {
  final String name;
  final String trade;
  final DateTime startDate;
  final int durationMonths;
  final String? password;
  bool isLoggedIn;

  User({
    required this.name,
    required this.trade,
    required this.startDate,
    required this.durationMonths,
    this.password,
    this.isLoggedIn = false,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      trade: json['trade'],
      startDate: DateTime.parse(json['startDate']),
      durationMonths: json['durationMonths'],
      password: json['password'],
      isLoggedIn: json['isLoggedIn'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'trade': trade,
      'startDate': startDate.toIso8601String(),
      'durationMonths': durationMonths,
      'password': password,
      'isLoggedIn': isLoggedIn,
    };
  }

  void setLoggedIn(bool value) {
    isLoggedIn = value;
  }
}
