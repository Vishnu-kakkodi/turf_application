// models/booking_models.dart

class TurfBooking {
  final String bookingId;
  final String turfName;
  final String turfLocation;
  final String date;
  final String timeSlot;
  final String status;
  final String createdAt;
  final List<String> images;

  TurfBooking({
    required this.bookingId,
    required this.turfName,
    required this.turfLocation,
    required this.date,
    required this.timeSlot,
    required this.status,
    required this.createdAt,
    required this.images,
  });

  factory TurfBooking.fromJson(Map<String, dynamic> json) {
    return TurfBooking(
      bookingId: json['bookingId'] ?? '',
      turfName: json['turfName'] ?? '',
      turfLocation: json['turfLocation'] ?? '',
      date: json['date'] ?? '',
      timeSlot: json['timeSlot'] ?? '',
      status: json['status'] ?? '',
      createdAt: json['createdAt'] ?? '',
      images: List<String>.from(json['images'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bookingId': bookingId,
      'turfName': turfName,
      'turfLocation': turfLocation,
      'date': date,
      'timeSlot': timeSlot,
      'status': status,
      'createdAt': createdAt,
      'images': images,
    };
  }
}

class TournamentBooking {
  final String bookingId;
  final String status;
  final String date;
  final String timeSlot;
  final String createdAt;
  final Tournament? tournament;

  TournamentBooking({
    required this.bookingId,
    required this.status,
    required this.date,
    required this.timeSlot,
    required this.createdAt,
    this.tournament,
  });

  factory TournamentBooking.fromJson(Map<String, dynamic> json) {
    return TournamentBooking(
      bookingId: json['bookingId'] ?? '',
      status: json['status'] ?? '',
      date: json['date'] ?? '',
      timeSlot: json['timeSlot'] ?? '',
      createdAt: json['createdAt'] ?? '',
      tournament: json['tournament'] != null 
          ? Tournament.fromJson(json['tournament']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bookingId': bookingId,
      'status': status,
      'date': date,
      'timeSlot': timeSlot,
      'createdAt': createdAt,
      'tournament': tournament?.toJson(),
    };
  }
}

class Tournament {
  final String id;
  final String name;
  final String description;
  final String location;
  final int price;
  final TournamentDetails? details;
  final String imageUrl;

  Tournament({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.price,
    this.details,
    required this.imageUrl,
  });

  factory Tournament.fromJson(Map<String, dynamic> json) {
    return Tournament(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      location: json['location'] ?? '',
      price: json['price'] ?? 0,
      details: json['details'] != null 
          ? TournamentDetails.fromJson(json['details']) 
          : null,
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'location': location,
      'price': price,
      'details': details?.toJson(),
      'imageUrl': imageUrl,
    };
  }
}

class TournamentDetails {
  final String date;
  final String allowedAge;
  final List<TournamentSlot> slots;

  TournamentDetails({
    required this.date,
    required this.allowedAge,
    required this.slots,
  });

  factory TournamentDetails.fromJson(Map<String, dynamic> json) {
    return TournamentDetails(
      date: json['date'] ?? '',
      allowedAge: json['allowedAge'] ?? '',
      slots: (json['slots'] as List<dynamic>?)
          ?.map((slot) => TournamentSlot.fromJson(slot))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'allowedAge': allowedAge,
      'slots': slots.map((slot) => slot.toJson()).toList(),
    };
  }
}

class TournamentSlot {
  final String id;
  final String timeSlot;
  final bool isBooked;

  TournamentSlot({
    required this.id,
    required this.timeSlot,
    required this.isBooked,
  });

  factory TournamentSlot.fromJson(Map<String, dynamic> json) {
    return TournamentSlot(
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

class BookingResponse {
  final bool success;
  final List<TurfBooking>? turfBookings;
  final List<TournamentBooking>? tournamentBookings;
  final String? message;

  BookingResponse({
    required this.success,
    this.turfBookings,
    this.tournamentBookings,
    this.message,
  });

  factory BookingResponse.fromTurfJson(Map<String, dynamic> json) {
    return BookingResponse(
      success: json['success'] ?? false,
      turfBookings: (json['bookings'] as List<dynamic>?)
          ?.map((booking) => TurfBooking.fromJson(booking))
          .toList(),
      message: json['message'],
    );
  }

  factory BookingResponse.fromTournamentJson(Map<String, dynamic> json) {
    return BookingResponse(
      success: json['success'] ?? false,
      tournamentBookings: (json['bookings'] as List<dynamic>?)
          ?.map((booking) => TournamentBooking.fromJson(booking))
          .toList(),
      message: json['message'],
    );
  }
}