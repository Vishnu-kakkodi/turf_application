class Turf {
  final String id;
  final String name;
  final int pricePerHour;
  final String location;
  final String openingTime;
  final List<String> images;

  Turf({
    required this.id,
    required this.name,
    required this.pricePerHour,
    required this.location,
    required this.openingTime,
    required this.images,
  });

  factory Turf.fromJson(Map<String, dynamic> json) {
    return Turf(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      pricePerHour: json['pricePerHour'] ?? 0,
      location: json['location'] ?? '',
      openingTime: json['openingTime'] ?? '',
      images: List<String>.from(json['images'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'pricePerHour': pricePerHour,
      'location': location,
      'openingTime': openingTime,
      'images': images,
    };
  }
}

// location_model.dart
class UserLocation {
  final double latitude;
  final double longitude;
  final DateTime? timestamp;

  UserLocation({
    required this.latitude,
    required this.longitude,
    this.timestamp,
  });

  factory UserLocation.fromJson(Map<String, dynamic> json) {
    return UserLocation(
      latitude: json['latitude']?.toDouble() ?? 0.0,
      longitude: json['longitude']?.toDouble() ?? 0.0,
      timestamp: json['timestamp'] != null 
          ? DateTime.parse(json['timestamp']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      if (timestamp != null) 'timestamp': timestamp!.toIso8601String(),
    };
  }
}
