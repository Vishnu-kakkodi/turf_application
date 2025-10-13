class GetAllTeamsResponse {
  final bool success;
  final int total;
  final String message;
  final List<Teams> teams;

  GetAllTeamsResponse({
    required this.success,
    required this.total,
    required this.message,
    required this.teams,
  });

  factory GetAllTeamsResponse.fromJson(Map<String, dynamic> json) {
    return GetAllTeamsResponse(
      success: json['success'] ?? false,
      total: json['total'] ?? 0,
      message: json['message'] ?? '',
      teams: (json['teams'] as List<dynamic>?)
              ?.map((team) => Teams.fromJson(team))
              .toList() ??
          [],
    );
  }
}

class Teams {
  final String id;
  final String teamName;
  final List<Player> players;
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  Teams({
    required this.id,
    required this.teamName,
    required this.players,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Teams.fromJson(Map<String, dynamic> json) {
    return Teams(
      id: json['_id'] ?? '',
      teamName: json['teamName'] ?? '',
      players: (json['players'] as List<dynamic>?)
              ?.map((player) => Player.fromJson(player))
              .toList() ??
          [],
      createdBy: json['createdBy'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }
}

class Player {
  final String id;
  final String name;

  Player({
    required this.id,
    required this.name,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
    );
  }
}
