class AppUser {
  final String uid;
  final String phone;
  final String role; // 'user', 'admin', or 'evaluator'
  final DateTime joined;

  AppUser({
    required this.uid,
    required this.phone,
    required this.role,
    required this.joined,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      uid: json['uid'],
      phone: json['phone'],
      role: json['role'],
      joined: DateTime.parse(json['joined']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'phone': phone,
      'role': role,
      'joined': joined.toIso8601String(),
    };
  }
}
