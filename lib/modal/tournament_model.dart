// Model Class
class Tournament {
  final String id;
  final String name;
  final DateTime date;
  final String timeSlot;
  final int price;
  final String image;
  final String imageUrl;

  Tournament({
    required this.id,
    required this.name,
    required this.date,
    required this.timeSlot,
    required this.price,
    required this.image,
    required this.imageUrl,
  });

  factory Tournament.fromJson(Map<String, dynamic> json) {
    return Tournament(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
      timeSlot: json['timeSlot'] ?? '',
      price: json['price'] ?? 0,
      image: json['image'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'date': date.toIso8601String(),
      'timeSlot': timeSlot,
      'price': price,
      'image': image,
      'imageUrl': imageUrl,
    };
  }
}

class TournamentResponse {
  final bool success;
  final Tournament? tournament;
  final String? message;

  TournamentResponse({
    required this.success,
    this.tournament,
    this.message,
  });

  factory TournamentResponse.fromJson(Map<String, dynamic> json) {
    return TournamentResponse(
      success: json['success'] ?? false,
      tournament: json['tournament'] != null 
          ? Tournament.fromJson(json['tournament']) 
          : null,
      message: json['message'],
    );
  }
}