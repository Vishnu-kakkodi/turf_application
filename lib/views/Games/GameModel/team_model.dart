// models/team_model.dart
class Team {
  final String id;
  final String name;
  final List<String> players;
  final String sport;

  Team({
    required this.id,
    required this.name,
    required this.players,
    required this.sport,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      players: List<String>.from(json['players'] ?? []),
      sport: json['sport'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'players': players,
      'sport': sport,
    };
  }
}



class User {
  final String id;
  final String name;
  final String email;
  final String mobile;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      mobile: json['mobile'] ?? '',
    );
  }
}



class SearchUsersResponse {
  final bool success;
  final List<User> users;

  SearchUsersResponse({
    required this.success,
    required this.users,
  });

  factory SearchUsersResponse.fromJson(Map<String, dynamic> json) {
    return SearchUsersResponse(
      success: json['success'] ?? false,
      users: (json['users'] as List<dynamic>?)
              ?.map((user) => User.fromJson(user))
              .toList() ??
          [],
    );
  }
}
