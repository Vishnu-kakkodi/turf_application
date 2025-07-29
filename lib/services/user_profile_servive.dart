import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:booking_application/modal/registration_model.dart';

class UserProfileService {
  final String baseUrl = 'http://31.97.206.144:3081/users/userprofile';

  // Get user profile by ID
  Future<User?> getUserProfile(String userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/$userId'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          return User.fromJson(data['user']);
        }
      }
      return null;
    } catch (e) {
      print('Error fetching user profile: $e');
      return null;
    }
  }

  // Update user profile
  Future<bool> updateUserProfile(String userId, Map<String, dynamic> userData) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$userId'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(userData),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['success'] == true;
      }
      return false;
    } catch (e) {
      print('Error updating user profile: $e');
      return false;
    }
  }

  // Upload profile image
  Future<String?> uploadProfileImage(String userId, String imagePath) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/$userId/upload-image'),
      );
      
      request.files.add(await http.MultipartFile.fromPath('image', imagePath));
      
      var response = await request.send();
      
      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var data = jsonDecode(responseData);
        if (data['success'] == true) {
          return data['imageUrl'];
        }
      }
      return null;
    } catch (e) {
      print('Error uploading profile image: $e');
      return null;
    }
  }
}