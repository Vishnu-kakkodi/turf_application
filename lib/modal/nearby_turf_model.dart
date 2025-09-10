class NearbyTurfModel {
  final String id;
  final String name;
  final double pricePerHour;
  final String location;
  final String openingTime;
  final List<String> images;

  NearbyTurfModel({
    required this.id,
    required this.name,
    required this.pricePerHour,
    required this.location,
    required this.openingTime,
    required this.images,
  });

  factory NearbyTurfModel.fromJson(Map<String, dynamic> json) {
    return NearbyTurfModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      pricePerHour: (json['pricePerHour'] ?? 0).toDouble(),
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

class NearbyTurfsResponse {
  final bool success;
  final List<NearbyTurfModel> turfs;

  NearbyTurfsResponse({
    required this.success,
    required this.turfs,
  });

  factory NearbyTurfsResponse.fromJson(Map<String, dynamic> json) {
    return NearbyTurfsResponse(
      success: json['success'] ?? false,
      turfs: (json['turfs'] as List<dynamic>? ?? [])
          .map((turfJson) => NearbyTurfModel.fromJson(turfJson))
          .toList(),
    );
  }
}