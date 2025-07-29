class VenueModel {
  final String id;
  final String name;
  final int pricePerHour;
  final String location;
  final double latitude;
  final double longitude;
  final String openingTime;
  final String description;
  final List<String> facilities;
  final List<String> images;
  final List<String> imageUrls;
  final List<Slot> slots;

  VenueModel({
    required this.id,
    required this.name,
    required this.pricePerHour,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.openingTime,
    required this.description,
    required this.facilities,
    required this.images,
    required this.imageUrls,
    required this.slots,
  });

  factory VenueModel.fromJson(Map<String, dynamic> json) {
    return VenueModel(
      id: json['_id'],
      name: json['name'],
      pricePerHour: json['pricePerHour'],
      location: json['location'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      openingTime: json['openingTime'],
      description: json['description'],
      facilities: List<String>.from(json['facilities']),
      images: List<String>.from(json['images']),
      imageUrls: List<String>.from(json['imageUrls']),
      slots: (json['slots'] as List)
          .map((slot) => Slot.fromJson(slot))
          .toList(),
    );
  }
}

class Slot {
  final String date;
  final String timeSlot;
  final String id;

  Slot({
    required this.date,
    required this.timeSlot,
    required this.id,
  });

  factory Slot.fromJson(Map<String, dynamic> json) {
    return Slot(
      date: json['date'],
      timeSlot: json['timeSlot'],
      id: json['_id'],
    );
  }
}
