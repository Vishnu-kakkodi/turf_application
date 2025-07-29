class Category {
  final String id;
  final String name;
  final String image;
  final String imageUrl;

  Category({
    required this.id,
    required this.name,
    required this.image,
    required this.imageUrl,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'image': image,
      'imageUrl': imageUrl,
    };
  }
}

class CategoryResponse {
  final bool success;
  final List<Category> categories;

  CategoryResponse({
    required this.success,
    required this.categories,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      success: json['success'] ?? false,
      categories: (json['categories'] as List<dynamic>?)
              ?.map((item) => Category.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}