
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:booking_application/modal/registration_model.dart';

class LoginService {
  final String baseUrl = 'http://31.97.206.144:3081/users';
  final String loginEndpoint = '/login';
  final String verifyOtpEndpoint = '/verify-otp';

  // Login with mobile number
  Future<Map<String, dynamic>> loginWithMobile(String mobile) async {
    try {
      final url = Uri.parse('$baseUrl$loginEndpoint');
      final headers = {
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({
        'mobile': mobile,
      });

      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );




      print('tttttttttttttttttttttttttttttttttttttttttttttttttttt${response.body}');
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'message': 'OTP sent successfully'
        };
      } else {
        final errorData = jsonDecode(response.body);
        return {
          'success': false,
          'message': errorData['message'] ?? 'Login failed',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Network error: ${e.toString()}',
        'data': null
      };
    }
  }

  // Verify OTP
  Future<Map<String, dynamic>> verifyOtp(String otp, String mobileNumber) async {
    try {
      final url = Uri.parse('$baseUrl$verifyOtpEndpoint');
      final headers = {
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({
        'otp': otp,
        'mobile': mobileNumber
      });

            print('tttttttttttttttttttttttttttttttttttttttttttttttttttt$url');

            print('tttttttttttttttttttttttttttttttttttttttttttttttttttt$body');


      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

            print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh${response.body}');


      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        return {
          'success': true,
          'data': responseData,
          'message': 'OTP verified successfully'
        };
      } else {
        final errorData = jsonDecode(response.body);
        return {
          'success': false,
          'message': errorData['message'] ?? 'OTP verification failed',
          'data': null
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Network error: ${e.toString()}',
        'data': null
      };
    }
  }

  // Register user (if needed)
  Future<Map<String, dynamic>> registerUser(RegistrationRequest request) async {
    try {
      final url = Uri.parse('$baseUrl/register');
      final headers = {
        'Content-Type': 'application/json',
      };
      final body = jsonEncode(request.toJson());

      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        return {
          'success': true,
          'data': responseData,
          'message': 'Registration successful'
        };
      } else {
        final errorData = jsonDecode(response.body);
        return {
          'success': false,
          'message': errorData['message'] ?? 'Registration failed',
          'data': null
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Network error: ${e.toString()}',
        'data': null
      };
    }
  }
}