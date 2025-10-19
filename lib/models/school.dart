// School model for dashboard section

class School {
  final String name;
  final bool isVerified;

  School({
    required this.name,
    required this.isVerified,
  });

  factory School.fromJson(Map<String, dynamic> json) {
    return School(
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
