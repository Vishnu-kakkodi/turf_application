// import 'dart:convert';
// import 'package:booking_application/helper/storage_helper.dart';
// import 'package:http/http.dart' as http;
// import 'package:booking_application/modal/registration_model.dart';


// class NotificationService {
//   final String baseUrl = 'http://31.97.206.144:3081/users/mynotifications';

//   // Get notifications for a specific user
//   Future<List<Map<String, dynamic>>> getNotifications(String userId) async {
//     try {

//       print('ttttttttttttttttttttttttttttttttt$userId');
//       final token = await UserPreferences.getToken();
      
//       final response = await http.get(
//         Uri.parse('$baseUrl/$userId'),
//         headers: {
//           'Content-Type': 'application/json',
//           if (token != null) 'Authorization': 'Bearer $token',
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         if (data['success'] == true) {
//           return List<Map<String, dynamic>>.from(data['notifications'] ?? []);
//         } else {
//           throw Exception(data['message'] ?? 'Failed to fetch notifications');
//         }
//       } else {
//         throw Exception('Failed to load notifications: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error fetching notifications: $e');
//       throw Exception('Error fetching notifications: $e');
//     }
//   }

//   // Mark notification as read
//   Future<bool> markAsRead(String userId, String notificationId) async {
//     try {
//       final token = await UserPreferences.getToken();
      
//       final response = await http.put(
//         Uri.parse('$baseUrl/$userId/read/$notificationId'),
//         headers: {
//           'Content-Type': 'application/json',
//           if (token != null) 'Authorization': 'Bearer $token',
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         return data['success'] == true;
//       } else {
//         print('Failed to mark notification as read: ${response.statusCode}');
//         return false;
//       }
//     } catch (e) {
//       print('Error marking notification as read: $e');
//       return false;
//     }
//   }

//   // Delete notification
//   Future<bool> deleteNotification(String userId, String notificationId) async {
//     try {
//       final token = await UserPreferences.getToken();
      
//       final response = await http.delete(
//         Uri.parse('$baseUrl/$userId/$notificationId'),
//         headers: {
//           'Content-Type': 'application/json',
//           if (token != null) 'Authorization': 'Bearer $token',
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         return data['success'] == true;
//       } else {
//         print('Failed to delete notification: ${response.statusCode}');
//         return false;
//       }
//     } catch (e) {
//       print('Error deleting notification: $e');
//       return false;
//     }
//   }

//   // Get unread notifications count
//   Future<int> getUnreadCount(String userId) async {
//     try {
//       final token = await UserPreferences.getToken();
      
//       final response = await http.get(
//         Uri.parse('$baseUrl/$userId/unread-count'),
//         headers: {
//           'Content-Type': 'application/json',
//           if (token != null) 'Authorization': 'Bearer $token',
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         if (data['success'] == true) {
//           return data['count'] ?? 0;
//         }
//       }
//       return 0;
//     } catch (e) {
//       print('Error getting unread count: $e');
//       return 0;
//     }
//   }

//   // Mark all notifications as read
//   Future<bool> markAllAsRead(String userId) async {
//     try {
//       final token = await UserPreferences.getToken();
      
//       final response = await http.put(
//         Uri.parse('$baseUrl/$userId/read-all'),
//         headers: {
//           'Content-Type': 'application/json',
//           if (token != null) 'Authorization': 'Bearer $token',
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         return data['success'] == true;
//       } else {
//         print('Failed to mark all notifications as read: ${response.statusCode}');
//         return false;
//       }
//     } catch (e) {
//       print('Error marking all notifications as read: $e');
//       return false;
//     }
//   }
// }





















import 'dart:convert';
import 'package:booking_application/helper/storage_helper.dart';
import 'package:http/http.dart' as http;
import 'package:booking_application/modal/registration_model.dart';

class NotificationService {
  final String baseUrl = 'http://31.97.206.144:3081/users/mynotifications';

  // Get notifications for a specific user
  Future<List<Map<String, dynamic>>> getNotifications(String userId) async {
    try {
      print('Fetching notifications for user: $userId');
      final token = await UserPreferences.getToken();
      print('Token available: ${token != null}');
      
      final response = await http.get(
        Uri.parse('$baseUrl/$userId'),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        // Check if response body is valid JSON
        try {
          final data = jsonDecode(response.body);
          if (data is Map<String, dynamic> && data['success'] == true) {
            final notifications = data['notifications'];
            if (notifications is List) {
              // Convert string notifications to Map format
              List<Map<String, dynamic>> formattedNotifications = [];
              
              for (int i = 0; i < notifications.length; i++) {
                final notification = notifications[i];
                
                if (notification is Map<String, dynamic>) {
                  // Already in correct format
                  formattedNotifications.add(notification);
                } else if (notification is String) {
                  // Convert string to Map format
                  formattedNotifications.add({
                    'id': 'notification_$i', // Generate unique ID
                    '_id': 'notification_$i',
                    'title': 'Notification',
                    'message': notification,
                    'body': notification,
                    'description': notification,
                    'isRead': false,
                    'createdAt': DateTime.now().toIso8601String(),
                    'timestamp': DateTime.now().toIso8601String(),
                  });
                } else {
                  // Handle other types
                  formattedNotifications.add({
                    'id': 'notification_$i',
                    '_id': 'notification_$i',
                    'title': 'Notification',
                    'message': notification.toString(),
                    'body': notification.toString(),
                    'description': notification.toString(),
                    'isRead': false,
                    'createdAt': DateTime.now().toIso8601String(),
                    'timestamp': DateTime.now().toIso8601String(),
                  });
                }
              }
              
              return formattedNotifications;
            } else {
              print('Notifications field is not a list: $notifications');
              return [];
            }
          } else {
            throw Exception(data['message'] ?? 'Failed to fetch notifications');
          }
        } catch (jsonError) {
          print('JSON decode error: $jsonError');
          print('Response is not valid JSON: ${response.body}');
          throw Exception('Invalid response format from server');
        }
      } else if (response.statusCode == 401) {
        throw Exception('Authentication failed. Please login again.');
      } else if (response.statusCode == 404) {
        throw Exception('User not found or notifications endpoint not available.');
      } else {
        print('HTTP Error ${response.statusCode}: ${response.body}');
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching notifications: $e');
      rethrow; // Re-throw the original exception
    }
  }

  // Mark notification as read
  Future<bool> markAsRead(String userId, String notificationId) async {
    try {
      final token = await UserPreferences.getToken();
      
      final response = await http.put(
        Uri.parse('$baseUrl/$userId/read/$notificationId'),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );

      print('Mark as read response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        try {
          final data = jsonDecode(response.body);
          return data['success'] == true;
        } catch (e) {
          print('JSON decode error in markAsRead: $e');
          return false;
        }
      } else {
        print('Failed to mark notification as read: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error marking notification as read: $e');
      return false;
    }
  }

  // Delete notification
  Future<bool> deleteNotification(String userId, String notificationId) async {
    try {
      final token = await UserPreferences.getToken();
      
      final response = await http.delete(
        Uri.parse('$baseUrl/$userId/$notificationId'),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );

      print('Delete notification response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        try {
          final data = jsonDecode(response.body);
          return data['success'] == true;
        } catch (e) {
          print('JSON decode error in deleteNotification: $e');
          return false;
        }
      } else {
        print('Failed to delete notification: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error deleting notification: $e');
      return false;
    }
  }

  // Get unread notifications count
  Future<int> getUnreadCount(String userId) async {
    try {
      final token = await UserPreferences.getToken();
      
      final response = await http.get(
        Uri.parse('$baseUrl/$userId/unread-count'),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );

      print('Unread count response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        try {
          final data = jsonDecode(response.body);
          if (data['success'] == true) {
            return data['count'] ?? 0;
          }
        } catch (e) {
          print('JSON decode error in getUnreadCount: $e');
        }
      }
      return 0;
    } catch (e) {
      print('Error getting unread count: $e');
      return 0;
    }
  }

  // Mark all notifications as read
  Future<bool> markAllAsRead(String userId) async {
    try {
      final token = await UserPreferences.getToken();
      
      final response = await http.put(
        Uri.parse('$baseUrl/$userId/read-all'),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );

      print('Mark all as read response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        try {
          final data = jsonDecode(response.body);
          return data['success'] == true;
        } catch (e) {
          print('JSON decode error in markAllAsRead: $e');
          return false;
        }
      } else {
        print('Failed to mark all notifications as read: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error marking all notifications as read: $e');
      return false;
    }
  }
}