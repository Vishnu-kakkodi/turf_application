// // class Tournament {
// //   final String id;
// //   final String name;
// //   final DateTime date;
// //   final int price;
// //   final String image;
// //   final String imageUrl;

// //   Tournament({
// //     required this.id,
// //     required this.name,
// //     required this.date,
// //     required this.price,
// //     required this.image,
// //     required this.imageUrl,
// //   });

// //   factory Tournament.fromJson(Map<String, dynamic> json) {
// //     return Tournament(
// //       id: json['_id'],
// //       name: json['name'],
// //       date: DateTime.parse(json['date']),
// //       price: json['price'],
// //       image: json['image'],
// //       imageUrl: json['imageUrl'],
// //     );
// //   }
// // }












// class Tournament {
//   final String id;
//   final String name;
//   final DateTime date;
//   final int price;
//   final String? image;
//   final String? imageUrl;

//   Tournament({
//     required this.id,
//     required this.name,
//     required this.date,
//     required this.price,
//     this.image,
//     this.imageUrl,
//   });

//   factory Tournament.fromJson(Map<String, dynamic> json) {
//     return Tournament(
//       id: json['_id'] ?? '',
//       name: json['name'] ?? 'Untitled',
//       date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
//       price: json['price'] ?? 0,
//       image: json['image'],
//       imageUrl: json['imageUrl'],
//     );
//   }
// }















// class Tournament {
//   final String id;
//   final String name;
//   final int price;
//   final String? location;
//   final String? image;
//   final String? imageUrl;

//   Tournament({
//     required this.id,
//     required this.name,
//     required this.price,
//     this.location,
//     this.image,
//     this.imageUrl,
//   });

//   factory Tournament.fromJson(Map<String, dynamic> json) {
//     return Tournament(
//       id: json['_id'] ?? '',
//       name: json['name'] ?? 'Untitled',
//       price: json['price'] ?? 0,
//       location: json['location'],
//       image: json['image'],
//       imageUrl: json['imageUrl'],
//     );
//   }
// }














class Tournament {
  final String id;
  final String name;
  final int price;
  final String? location;
  final String? description;
  final String? image;
  final String? imageUrl;
  final TournamentDetails? details;

  Tournament({
    required this.id,
    required this.name,
    required this.price,
    this.location,
    this.description,
    this.image,
    this.imageUrl,
    this.details,
  });

  factory Tournament.fromJson(Map<String, dynamic> json) {
    return Tournament(
      id: json['_id'] ?? '',
      name: json['name'] ?? 'Untitled',
      price: json['price'] ?? 0,
      location: json['location'],
      description: json['description'],
      image: json['image'],
      imageUrl: json['imageUrl'],
      details: json['details'] != null 
          ? TournamentDetails.fromJson(json['details']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'price': price,
      'location': location,
      'description': description,
      'image': image,
      'imageUrl': imageUrl,
      'details': details?.toJson(),
    };
  }
}

class TournamentDetails {
  final String? date;
  final String? time;

  TournamentDetails({
    this.date,
    this.time,
  });

  factory TournamentDetails.fromJson(Map<String, dynamic> json) {
    return TournamentDetails(
      date: json['date'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'time': time,
    };
  }
}