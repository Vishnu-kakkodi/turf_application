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















class Tournament {
  final String id;
  final String name;
  final int price;
  final String? location;
  final String? image;
  final String? imageUrl;

  Tournament({
    required this.id,
    required this.name,
    required this.price,
    this.location,
    this.image,
    this.imageUrl,
  });

  factory Tournament.fromJson(Map<String, dynamic> json) {
    return Tournament(
      id: json['_id'] ?? '',
      name: json['name'] ?? 'Untitled',
      price: json['price'] ?? 0,
      location: json['location'],
      image: json['image'],
      imageUrl: json['imageUrl'],
    );
  }
}
