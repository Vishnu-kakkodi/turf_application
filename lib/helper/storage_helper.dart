// import 'dart:convert';
// import 'package:booking_application/modal/registration_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SharedPreferencesHelper {
//   static const String _keyUserId = 'user_id';
//   static const String _keyUserName = 'user_name';
//   static const String _keyUserEmail = 'user_email';
//   static const String _keyUserMobile = 'user_mobile';
//   static const String _keyUserToken = 'user_token';
//   static const String _keyIsLoggedIn = 'is_logged_in';
//   static const String _keyUserData = 'user_data';

//   // Save user ID
//   static Future<bool> saveUserId(String userId) async {
//     final prefs = await SharedPreferences.getInstance();
//     return await prefs.setString(_keyUserId, userId);
//   }

//   // Get user ID
//   static Future<String?> getUserId() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_keyUserId);
//   }

//   // Save user name
//   static Future<bool> saveUserName(String name) async {
//     final prefs = await SharedPreferences.getInstance();
//     return await prefs.setString(_keyUserName, name);
//   }

//   // Get user name
//   static Future<String?> getUserName() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_keyUserName);
//   }

//   // Save user email
//   static Future<bool> saveUserEmail(String email) async {
//     final prefs = await SharedPreferences.getInstance();
//     return await prefs.setString(_keyUserEmail, email);
//   }

//   // Get user email
//   static Future<String?> getUserEmail() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_keyUserEmail);
//   }

//   // Save user mobile
//   static Future<bool> saveUserMobile(String mobile) async {
//     final prefs = await SharedPreferences.getInstance();
//     return await prefs.setString(_keyUserMobile, mobile);
//   }

//   // Get user mobile
//   static Future<String?> getUserMobile() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_keyUserMobile);
//   }

//   // Save user token
//   static Future<bool> saveUserToken(String token) async {
//     final prefs = await SharedPreferences.getInstance();
//     return await prefs.setString(_keyUserToken, token);
//   }

//   // Get user token
//   static Future<String?> getUserToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_keyUserToken);
//   }

//   // Save login status
//   static Future<bool> saveLoginStatus(bool isLoggedIn) async {
//     final prefs = await SharedPreferences.getInstance();
//     return await prefs.setBool(_keyIsLoggedIn, isLoggedIn);
//   }

//   // Get login status
//   static Future<bool> isLoggedIn() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getBool(_keyIsLoggedIn) ?? false;
//   }

//   // Save complete user data as JSON
//   static Future<bool> saveUserData(User user) async {
//     final prefs = await SharedPreferences.getInstance();
//     final userJson = json.encode(user.toJson());
//     return await prefs.setString(_keyUserData, userJson);
//   }

//   // Get complete user data from JSON
//   static Future<User?> getUserData() async {
//     final prefs = await SharedPreferences.getInstance();
//     final userJson = prefs.getString(_keyUserData);
//     if (userJson != null) {
//       try {
//         final userMap = json.decode(userJson) as Map<String, dynamic>;
//         return User.fromJson(userMap);
//       } catch (e) {
//         print('Error parsing user data: $e');
//         return null;
//       }
//     }
//     return null;
//   }

//   // Save all user details at once
//   static Future<bool> saveAllUserDetails({
//     required String userId,
//     required String name,
//     required String email,
//     required String mobile,
//     String? token,
//   }) async {
//     try {
//       await Future.wait([
//         saveUserId(userId),
//         saveUserName(name),
//         saveUserEmail(email),
//         saveUserMobile(mobile),
//         saveLoginStatus(true),
//         if (token != null) saveUserToken(token),
//       ]);
//       return true;
//     } catch (e) {
//       print('Error saving user details: $e');
//       return false;
//     }
//   }

//   // Clear all user data (logout)
//   static Future<bool> clearUserData() async {
//     final prefs = await SharedPreferences.getInstance();
//     try {
//       await Future.wait([
//         prefs.remove(_keyUserId),
//         prefs.remove(_keyUserName),
//         prefs.remove(_keyUserEmail),
//         prefs.remove(_keyUserMobile),
//         prefs.remove(_keyUserToken),
//         prefs.remove(_keyUserData),
//         prefs.setBool(_keyIsLoggedIn, false),
//       ]);
//       return true;
//     } catch (e) {
//       print('Error clearing user data: $e');
//       return false;
//     }
//   }

//   // Get all user details as a map
//   static Future<Map<String, String?>> getAllUserDetails() async {
//     return {
//       'userId': await getUserId(),
//       'name': await getUserName(),
//       'email': await getUserEmail(),
//       'mobile': await getUserMobile(),
//       'token': await getUserToken(),
//     };
//   }
// }





















import 'package:booking_application/modal/registration_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UserPreferences {
  static const String _userKey = 'user_data';
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _tokenKey = 'auth_token';


  static Future<bool> saveUser(User user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = jsonEncode(user.toJson());
      await prefs.setString(_userKey, userJson);
      await prefs.setBool(_isLoggedInKey, true);
      return true;
    } catch (e) {
      print('Error saving user: $e');
      return false;
    }
  }

 
  static Future<User?> getUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString(_userKey);
      if (userJson != null) {
        return User.fromJson(jsonDecode(userJson));
      }
      return null;
    } catch (e) {
      print('Error getting user: $e');
      return null;
    }
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_isLoggedInKey) ?? false;
    } catch (e) {
      print('Error checking login status: $e');
      return false;
    }
  }

  // Save auth token
  static Future<bool> saveToken(String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.setString(_tokenKey, token);
    } catch (e) {
      print('Error saving token: $e');
      return false;
    }
  }

  
  static Future<String?> getToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_tokenKey);
    } catch (e) {
      print('Error getting token: $e');
      return null;
    }
  }

  // Clear all user data
  static Future<bool> clearUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_userKey);
      await prefs.remove(_isLoggedInKey);
      await prefs.remove(_tokenKey);
      return true;
    } catch (e) {
      print('Error clearing user data: $e');
      return false;
    }
  }

 
  static Future<bool> updateUser(User user) async {
    return await saveUser(user);
  }
}
