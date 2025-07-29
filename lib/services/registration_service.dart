import 'package:booking_application/modal/registration_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegistrationService {
  final String baseUrl = 'http://31.97.206.144:3081/users/register';

  Future<RegistrationResponse> registerUser(RegistrationRequest request) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        return RegistrationResponse.fromJson(jsonResponse);
      } else {
        throw Exception('Registration failed: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}