// Company model for dashboard section

class Company {
  final String name;
  final bool isVerified;

  Company({
    required this.name,
    required this.isVerified,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      name: json['name'],
      isVerified: json['isVerified'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'isVerified': isVerified,
    };
  }
}
