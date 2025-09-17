// models/match_models.dart

class MatchResponse {
  final bool success;
  final MatchData match;

  MatchResponse({required this.success, required this.match});

  factory MatchResponse.fromJson(Map<String, dynamic> json) {
    return MatchResponse(
      success: json['success'] ?? false,
      match: MatchData.fromJson(json['match']),
    );
  }
}

class MatchData {
  final String id;
  final String matchName;
  final String matchType;
  final String location;
  final double price;
  final String description;
  final String matchMode;
  final String status;
  final int over;
  final List<TeamData> teams;
  final CategoryData categoryId;
  final TournamentData tournamentId;
  final ScheduleData schedule;

  MatchData({
    required this.id,
    required this.matchName,
    required this.matchType,
    required this.location,
    required this.price,
    required this.description,
    required this.matchMode,
    required this.status,
    required this.over,
    required this.teams,
    required this.categoryId,
    required this.tournamentId,
    required this.schedule,
  });

  factory MatchData.fromJson(Map<String, dynamic> json) {
    return MatchData(
      id: json['_id'] ?? '',
      matchName: json['matchName'] ?? '',
      matchType: json['matchType'] ?? '',
      location: json['location'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      description: json['description'] ?? '',
      matchMode: json['matchMode'] ?? '',
      status: json['status'] ?? '',
      over: json['over'] ?? 0,
      teams: (json['teams'] as List? ?? [])
          .map((team) => TeamData.fromJson(team))
          .toList(),
      categoryId: CategoryData.fromJson(json['categoryId'] ?? {}),
      tournamentId: TournamentData.fromJson(json['tournamentId'] ?? {}),
      schedule: ScheduleData.fromJson(json['schedule'] ?? {}),
    );
  }
}

class TeamData {
  final String id;
  final String teamName;
  final String categoryId;
  final String tournamentId;
  final List<PlayerData> players;
  final DateTime createdAt;
  final DateTime updatedAt;

  TeamData({
    required this.id,
    required this.teamName,
    required this.categoryId,
    required this.tournamentId,
    required this.players,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TeamData.fromJson(Map<String, dynamic> json) {
    return TeamData(
      id: json['_id'] ?? '',
      teamName: json['teamName'] ?? '',
      categoryId: json['categoryId'] ?? '',
      tournamentId: json['tournamentId'] ?? '',
      players: (json['players'] as List? ?? [])
          .map((player) => PlayerData.fromJson(player))
          .toList(),
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }
}

class PlayerData {
  final String id;
  final String name;
  final String role;
  final String subRole;
  final String designation;

  PlayerData({
    required this.id,
    required this.name,
    required this.role,
    required this.subRole,
    required this.designation,
  });

  factory PlayerData.fromJson(Map<String, dynamic> json) {
    return PlayerData(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      role: json['role'] ?? '',
      subRole: json['subRole'] ?? '',
      designation: json['designation'] ?? '',
    );
  }
}

class CategoryData {
  final String id;
  final String name;

  CategoryData({required this.id, required this.name});

  factory CategoryData.fromJson(Map<String, dynamic> json) {
    return CategoryData(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
    );
  }
}

class TournamentData {
  final String id;
  final String name;

  TournamentData({required this.id, required this.name});

  factory TournamentData.fromJson(Map<String, dynamic> json) {
    return TournamentData(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
    );
  }
}

class ScheduleData {
  final String date;
  final String time;
  final DateTime dateTime;

  ScheduleData({
    required this.date,
    required this.time,
    required this.dateTime,
  });

  factory ScheduleData.fromJson(Map<String, dynamic> json) {
    return ScheduleData(
      date: json['date'] ?? '',
      time: json['time'] ?? '',
      dateTime: DateTime.tryParse(json['dateTime'] ?? '') ?? DateTime.now(),
    );
  }
}

class StartMatchRequest {
  final String tossWinner;
  final String electedTo;
  final String striker;
  final String nonStriker;
  final String bowler;
  final String bowlingStyle;
  final String over;

  StartMatchRequest({
    required this.tossWinner,
    required this.electedTo,
    required this.striker,
    required this.nonStriker,
    required this.bowler,
    required this.bowlingStyle,
    required this.over,
  });

  Map<String, dynamic> toJson() {
    return {
      'tossWinner': tossWinner,
      'electedTo': electedTo,
      'striker': striker,
      'nonStriker': nonStriker,
      'bowler': bowler,
      'bowlingStyle': bowlingStyle,
      'over': over,
    };
  }
}