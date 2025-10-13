// tournament_model.dart

class Tournament {
  final String id;
  final String name;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime registrationEndDate;
  final TournamentLocation location;
  final int numberOfTeams;
  final String format;
  final String tournamentType;
  final double? price;
  final String locationName;
  final String? rules;
  final String? prizes;
  final String createdBy;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Tournament({
    required this.id,
    required this.name,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.registrationEndDate,
    required this.location,
    required this.numberOfTeams,
    required this.format,
    required this.tournamentType,
    this.price,
    required this.locationName,
    this.rules,
    this.prizes,
    required this.createdBy,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Tournament.fromJson(Map<String, dynamic> json) {
    return Tournament(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      registrationEndDate: DateTime.parse(json['registrationEndDate']),
      location: TournamentLocation.fromJson(json['location'] ?? {}),
      numberOfTeams: json['numberOfTeams'] ?? 0,
      format: json['format'] ?? '',
      tournamentType: json['tournamentType'] ?? 'free',
      price: json['price']?.toDouble(),
      locationName: json['locationName'] ?? '',
      rules: json['rules'],
      prizes: json['prizes'],
      createdBy: json['createdBy'] ?? '',
      status: json['status'] ?? 'upcoming',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'startDate': startDate.toIso8601String().split('T')[0],
      'endDate': endDate.toIso8601String().split('T')[0],
      'registrationEndDate': registrationEndDate.toIso8601String().split('T')[0],
      'location': location.toJson(),
      'numberOfTeams': numberOfTeams,
      'format': format,
      'tournamentType': tournamentType,
      'price': price ?? 0,
      'locationName': locationName,
      'rules': rules ?? '',
      'prizes': prizes ?? '',
    };
  }

  // Helper method to get status enum
  TournamentStatus get tournamentStatus {
    switch (status.toLowerCase()) {
      case 'upcoming':
        return TournamentStatus.registrationOpen;
      case 'live':
        return TournamentStatus.live;
      case 'completed':
        return TournamentStatus.completed;
      default:
        return TournamentStatus.registrationOpen;
    }
  }
}

class TournamentLocation {
  final double lat;
  final double lng;

  TournamentLocation({
    required this.lat,
    required this.lng,
  });

  factory TournamentLocation.fromJson(Map<String, dynamic> json) {
    return TournamentLocation(
      lat: (json['lat'] ?? 0).toDouble(),
      lng: (json['lng'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }
}

enum TournamentStatus {
  registrationOpen,
  live,
  completed,
}