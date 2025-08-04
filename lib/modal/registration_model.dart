class User {
  final String id;
  final String name;
  final String email;
  final String mobile;
  final String? password;
  final String? otp;
  final String?profileImage;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    this.password,
    this.otp,
    this.profileImage,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      mobile: json['mobile'] ?? '',
      password: json['password'],
      otp: json['otp'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      profileImage: json['profileImageUrl'] ?? json['profileImage'] ?? json['imageUrl'], // 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'mobile': mobile,
      'password': password,
      'otp': otp,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'profileImage':profileImage
    };
  }
}

// Registration Request Model
class RegistrationRequest {
  final String name;
  final String email;
  final String mobile;
  final String password;

  RegistrationRequest({
    required this.name,
    required this.email,
    required this.mobile,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'mobile': mobile,
      'password': password,
    };
  }
}

// Registration Response Model
class RegistrationResponse {
  final bool success;
  final User user;
  final String? message;

  RegistrationResponse({
    required this.success,
    required this.user,
    this.message,
  });

  factory RegistrationResponse.fromJson(Map<String, dynamic> json) {
    return RegistrationResponse(
      success: json['success'] ?? false,
      user: User.fromJson(json['user']),
      message: json['message'],
    );
  }
}