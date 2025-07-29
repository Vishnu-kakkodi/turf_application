import 'dart:convert';
import 'package:booking_application/helper/storage_helper.dart';
import 'package:http/http.dart' as http;
import 'package:booking_application/modal/registration_model.dart';

class UserDetailService {
  static const String baseUrl = 'http://31.97.206.144:3081/users/updateprofile';

  // Update user profile method
  Future<ApiResponse<User>> updateUserProfile({
    required String userId,
    String? city,
    String? gender,
    String? dob,
  }) async {
    try {
      // Get auth token
      final token = await UserPreferences.getToken();
      
   
      final url = Uri.parse('$baseUrl/$userId');
      
    
      final Map<String, dynamic> requestBody = {};
      if (city != null) requestBody['city'] = city;
      if (gender != null) requestBody['gender'] = gender;
      if (dob != null) requestBody['dob'] = dob;

      // Make HTTP request
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
        body: jsonEncode(requestBody),
      );

      // Handle response
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        
        if (responseData['success'] == true) {
          final updatedUser = User.fromJson(responseData['user']);
          
          // Update user in local storage
          await UserPreferences.updateUser(updatedUser);
          
          return ApiResponse<User>(
            success: true,
            data: updatedUser,
            message: responseData['message'] ?? 'Profile updated successfully',
          );
        } else {
          return ApiResponse<User>(
            success: false,
            message: responseData['message'] ?? 'Failed to update profile',
          );
        }
      } else {
        return ApiResponse<User>(
          success: false,
          message: 'Server error: ${response.statusCode}',
        );
      }
    } catch (e) {
      return ApiResponse<User>(
        success: false,
        message: 'Network error: ${e.toString()}',
      );
    }
  }

  // Get user profile method
  Future<ApiResponse<User>> getUserProfile(String userId) async {
    try {
      final token = await UserPreferences.getToken();
      
      final url = Uri.parse('http://31.97.206.144:3081/users/$userId');
      
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        
        if (responseData['success'] == true) {
          final user = User.fromJson(responseData['user']);
          
          return ApiResponse<User>(
            success: true,
            data: user,
            message: responseData['message'] ?? 'Profile fetched successfully',
          );
        } else {
          return ApiResponse<User>(
            success: false,
            message: responseData['message'] ?? 'Failed to fetch profile',
          );
        }
      } else {
        return ApiResponse<User>(
          success: false,
          message: 'Server error: ${response.statusCode}',
        );
      }
    } catch (e) {
      return ApiResponse<User>(
        success: false,
        message: 'Network error: ${e.toString()}',
      );
    }
  }
}


class ApiResponse<T> {
  final bool success;
  final T? data;
  final String? message;

  ApiResponse({
    required this.success,
    this.data,
    this.message,
  });
}

class UserProfileUpdateRequest {
  final String? city;
  final String? gender;
  final String? dob;

  UserProfileUpdateRequest({
    this.city,
    this.gender,
    this.dob,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (city != null) data['city'] = city;
    if (gender != null) data['gender'] = gender;
    if (dob != null) data['dob'] = dob;
    return data;
  }
}