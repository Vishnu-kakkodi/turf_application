// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:booking_application/modal/registration_model.dart';

// class UserProfileService {
//   final String baseUrl = 'http://31.97.206.144:3081/users/userprofile';

//   // Get user profile by ID
//   Future<User?> getUserProfile(String userId) async {
//     try {
//       final response = await http.get(
//         Uri.parse('$baseUrl/$userId'),
//         headers: {
//           'Content-Type': 'application/json',
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         if (data['success'] == true) {
//           return User.fromJson(data['user']);
//         }
//       }
//       return null;
//     } catch (e) {
//       print('Error fetching user profile: $e');
//       return null;
//     }
//   }

//   // Update user profile
//   Future<bool> updateUserProfile(String userId, Map<String, dynamic> userData) async {
//     try {
//       final response = await http.put(
//         Uri.parse('$baseUrl/$userId'),
//         headers: {
//           'Content-Type': 'application/json',
//         },
//         body: jsonEncode(userData),
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         return data['success'] == true;
//       }
//       return false;
//     } catch (e) {
//       print('Error updating user profile: $e');
//       return false;
//     }
//   }

//   // Upload profile image
//   Future<String?> uploadProfileImage(String userId, String imagePath) async {
//     try {
//       var request = http.MultipartRequest(
//         'POST',
//         Uri.parse('$baseUrl/$userId/upload-image'),
//       );
      
//       request.files.add(await http.MultipartFile.fromPath('image', imagePath));
      
//       var response = await request.send();
      
//       if (response.statusCode == 200) {
//         var responseData = await response.stream.bytesToString();
//         var data = jsonDecode(responseData);
//         if (data['success'] == true) {
//           return data['imageUrl'];
//         }
//       }
//       return null;
//     } catch (e) {
//       print('Error uploading profile image: $e');
//       return null;
//     }
//   }
// }






















import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:booking_application/modal/registration_model.dart';

class UserProfileService {
  final String baseUrl = 'http://31.97.206.144:3081/users';

  // Get user profile by ID
  Future<User?> getUserProfile(String userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/userprofile/$userId'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      print('Get Profile Response: ${response.statusCode}');
      print('Get Profile Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true && data['user'] != null) {
          return User.fromJson(data['user']);
        }
      }
      return null;
    } catch (e) {
      print('Error fetching user profile: $e');
      return null;
    }
  }

  // Update user profile (existing method - keeping for backward compatibility)
  Future<bool> updateUserProfile(String userId, Map<String, dynamic> userData) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/userprofile/$userId'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(userData),
      );

      print('Update Profile Response: ${response.statusCode}');
      print('Update Profile Body: ${response.body}');

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

  // NEW: Update user info using the new API endpoint
  Future<bool> updateUserInfo(String userId, {
    required String name,
    required String email,
    required String phone,
  }) async {
    try {
      final requestBody = {
        'name': name,
        'email': email,
        'phone': phone,
      };

      print('Update Info Request Body: ${jsonEncode(requestBody)}');

      final response = await http.put(
        Uri.parse('$baseUrl/update-info/$userId'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      print('Update Info Response: ${response.statusCode}');
      print('Update Info Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['success'] == true;
      }
      return false;
    } catch (e) {
      print('Error updating user info: $e');
      return false;
    }
  }
  
  Future<String?> updateProfileImage(String userId, String imagePath) async {
  try {
    // Check if file exists
    final file = File(imagePath);
    if (!await file.exists()) {
      print('Image file does not exist: $imagePath');
      return null;
    }

    var request = http.MultipartRequest(
      'PUT',
      Uri.parse('$baseUrl/profile-image/$userId'),
    );

    // Fix: Use correct field name expected by backend
    request.files.add(await http.MultipartFile.fromPath('profileImage', imagePath));

    print('Updating profile image to: $baseUrl/profile-image/$userId');

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    print('Update Profile Image Response: ${response.statusCode}');
    print('Update Profile Image Body: ${response.body}');

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['success'] == true) {
        return data['imageUrl'] ?? data['profileImageUrl'] ?? data['url'];
      } else {
        print('API returned success: false. Message: ${data['message']}');
      }
    } else {
      print('HTTP Error: ${response.statusCode} - ${response.body}');
    }
    return null;
  } catch (e) {
    print('Error updating profile image: $e');
    return null;
  }
}

}