// models/tournament_model.dart

class TournamentResponse {
  final bool success;
  final List<Tournament> tournaments;

  TournamentResponse({
    required this.success,
    required this.tournaments,
  });

  factory TournamentResponse.fromJson(Map<String, dynamic> json) {
    return TournamentResponse(
      success: json['success'] ?? false,
      tournaments: (json['tournaments'] as List<dynamic>?)
              ?.map((e) => Tournament.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'tournaments': tournaments.map((e) => e.toJson()).toList(),
    };
  }
}

class Tournament {
  final String id;
  final String name;
  final String? description;
  final String location;
  final int price;
  final TournamentDetails details;
  final String image;

  Tournament({
    required this.id,
    required this.name,
    this.description,
    required this.location,
    required this.price,
    required this.details,
    required this.image,
  });

  factory Tournament.fromJson(Map<String, dynamic> json) {
    return Tournament(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'],
      location: json['location'] ?? '',
      price: json['price'] ?? 0,
      details: TournamentDetails.fromJson(json['details'] ?? {}),
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'location': location,
      'price': price,
      'details': details.toJson(),
      'image': image,
    };
  }
}

class TournamentDetails {
  final String date;
  final String? time;
  final String allowedAge;
  final List<TimeSlot> slots;

  TournamentDetails({
    required this.date,
    this.time,
    required this.allowedAge,
    required this.slots,
  });

  factory TournamentDetails.fromJson(Map<String, dynamic> json) {
    return TournamentDetails(
      date: json['date'] ?? '',
      time: json['time'],
      allowedAge: json['allowedAge'] ?? '',
      slots: (json['slots'] as List<dynamic>?)
              ?.map((e) => TimeSlot.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'time': time,
      'allowedAge': allowedAge,
      'slots': slots.map((e) => e.toJson()).toList(),
    };
  }
}

class TimeSlot {
  final String id;
  final String timeSlot;
  final bool isBooked;

  TimeSlot({
    required this.id,
    required this.timeSlot,
    required this.isBooked,
  });

  factory TimeSlot.fromJson(Map<String, dynamic> json) {
    return TimeSlot(
      id: json['_id'] ?? '',
      timeSlot: json['timeSlot'] ?? '',
      isBooked: json['isBooked'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'timeSlot': timeSlot,
      'isBooked': isBooked,
    };
  }
}