// models/team_model.dart

class Player {
  final String name;
  final String? id;

  Player({
    required this.name,
    this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      name: json['name'] ?? '',
      id: json['_id'],
    );
  }
}

class Team {
  final String? id;
  final String teamName;
  final List<Player> players;
  final String? createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Team({
    this.id,
    required this.teamName,
    required this.players,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'teamName': teamName,
      'players': players.map((player) => player.toJson()).toList(),
    };
  }

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['_id'],
      teamName: json['teamName'] ?? '',
      players: (json['players'] as List<dynamic>?)
              ?.map((player) => Player.fromJson(player))
              .toList() ??
          [],
      createdBy: json['createdBy'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
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

class CreateTeamResponse {
  final String message;
  final Team team;

  CreateTeamResponse({
    required this.message,
    required this.team,
  });

  factory CreateTeamResponse.fromJson(Map<String, dynamic> json) {
    return CreateTeamResponse(
      message: json['message'] ?? '',
      team: Team.fromJson(json['team']),
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