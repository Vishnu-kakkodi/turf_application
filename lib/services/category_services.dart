import 'dart:convert';
import 'package:booking_application/modal/category_model.dart';
import 'package:http/http.dart' as http;

class CategoryService {
  final String baseUrl = 'http://31.97.206.144:3081/category/categories';

  Future<CategoryResponse> getCategories() async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return CategoryResponse.fromJson(jsonData);
      } else {
        throw Exception('Failed to load categories: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching categories: $e');
    }
  }

  String getFullImageUrl(String imageUrl) {
    const String baseImageUrl = 'http://31.97.206.144:3081';
    return '$baseImageUrl$imageUrl';
  }
}