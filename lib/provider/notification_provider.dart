// import 'package:booking_application/helper/storage_helper.dart';
// import 'package:booking_application/services/notification_service.dart';
// import 'package:flutter/material.dart';


// class NotificationProvider extends ChangeNotifier {
//   final NotificationService _notificationService = NotificationService();
  
//   List<Map<String, dynamic>> _notifications = [];
//   bool _isLoading = false;
//   String? _error;
//   int _unreadCount = 0;

//   // Getters
//   List<Map<String, dynamic>> get notifications => _notifications;
//   bool get isLoading => _isLoading;
//   String? get error => _error;
//   int get unreadCount => _unreadCount;

//   // Get notifications for current user
//   Future<void> fetchNotifications() async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();

//     try {
//       final user = await UserPreferences.getUser();
//       if (user != null && user.id != null) {
//         _notifications = await _notificationService.getNotifications(user.id!);
//         await _fetchUnreadCount();
//       } else {
//         _error = 'User not found';
//       }
//     } catch (e) {
//       _error = e.toString();
//       print('Error in fetchNotifications: $e');
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   // Mark notification as read
//   Future<bool> markAsRead(String notificationId) async {
//     try {
//       final user = await UserPreferences.getUser();
//       if (user != null && user.id != null) {
//         final success = await _notificationService.markAsRead(user.id!, notificationId);
//         if (success) {
//           // Update local notification status
//           final index = _notifications.indexWhere((notification) => 
//             notification['id'] == notificationId || notification['_id'] == notificationId);
//           if (index != -1) {
//             _notifications[index]['isRead'] = true;
//             _unreadCount = (_unreadCount > 0) ? _unreadCount - 1 : 0;
//             notifyListeners();
//           }
//           return true;
//         }
//       }
//       return false;
//     } catch (e) {
//       _error = e.toString();
//       notifyListeners();
//       return false;
//     }
//   }

//   // Delete notification
//   Future<bool> deleteNotification(String notificationId) async {
//     try {
//       final user = await UserPreferences.getUser();
//       if (user != null && user.id != null) {
//         final success = await _notificationService.deleteNotification(user.id!, notificationId);
//         if (success) {
//           // Remove from local list
//           final index = _notifications.indexWhere((notification) => 
//             notification['id'] == notificationId || notification['_id'] == notificationId);
//           if (index != -1) {
//             final wasUnread = _notifications[index]['isRead'] != true;
//             _notifications.removeAt(index);
//             if (wasUnread) {
//               _unreadCount = (_unreadCount > 0) ? _unreadCount - 1 : 0;
//             }
//             notifyListeners();
//           }
//           return true;
//         }
//       }
//       return false;
//     } catch (e) {
//       _error = e.toString();
//       notifyListeners();
//       return false;
//     }
//   }

//   // Get unread count
//   Future<void> _fetchUnreadCount() async {
//     try {
//       final user = await UserPreferences.getUser();
//       if (user != null && user.id != null) {
//         _unreadCount = await _notificationService.getUnreadCount(user.id!);
//       }
//     } catch (e) {
//       print('Error fetching unread count: $e');
//     }
//   }

//   // Mark all notifications as read
//   Future<bool> markAllAsRead() async {
//     try {
//       final user = await UserPreferences.getUser();
//       if (user != null && user.id != null) {
//         final success = await _notificationService.markAllAsRead(user.id!);
//         if (success) {
//           // Update all local notifications
//           for (var notification in _notifications) {
//             notification['isRead'] = true;
//           }
//           _unreadCount = 0;
//           notifyListeners();
//           return true;
//         }
//       }
//       return false;
//     } catch (e) {
//       _error = e.toString();
//       notifyListeners();
//       return false;
//     }
//   }

//   // Clear error
//   void clearError() {
//     _error = null;
//     notifyListeners();
//   }

//   // Refresh notifications
//   Future<void> refreshNotifications() async {
//     await fetchNotifications();
//   }

//   // Get filtered notifications
//   List<Map<String, dynamic>> getFilteredNotifications({bool? isRead}) {
//     if (isRead == null) return _notifications;
//     return _notifications.where((notification) => 
//       (notification['isRead'] == true) == isRead).toList();
//   }

//   // Get unread notifications
//   List<Map<String, dynamic>> get unreadNotifications {
//     return getFilteredNotifications(isRead: false);
//   }

//   // Get read notifications
//   List<Map<String, dynamic>> get readNotifications {
//     return getFilteredNotifications(isRead: true);
//   }
// }
















import 'package:booking_application/helper/storage_helper.dart';
import 'package:booking_application/services/notification_service.dart';
import 'package:flutter/material.dart';

class NotificationProvider extends ChangeNotifier {
  final NotificationService _notificationService = NotificationService();
  
  List<Map<String, dynamic>> _notifications = [];
  bool _isLoading = false;
  String? _error;
  int _unreadCount = 0;

  // Getters
  List<Map<String, dynamic>> get notifications => _notifications;
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get unreadCount => _unreadCount;

  // Get notifications for current user
  Future<void> fetchNotifications() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final user = await UserPreferences.getUser();
      print('User from preferences: ${user?.id}');
      
      if (user != null && user.id != null && user.id!.isNotEmpty) {
        print('Attempting to fetch notifications for user: ${user.id}');
        
        _notifications = await _notificationService.getNotifications(user.id!);
        print('Successfully fetched ${_notifications.length} notifications');
        
        await _fetchUnreadCount();
        
        _error = null; // Clear any previous errors
      } else {
        _error = 'User not found or invalid user ID';
        _notifications = [];
        _unreadCount = 0;
        print('Error: User not found or invalid user ID');
      }
    } catch (e) {
      _error = _getReadableError(e.toString());
      _notifications = [];
      _unreadCount = 0;
      print('Error in fetchNotifications: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Convert technical errors to user-friendly messages
  String _getReadableError(String error) {
    if (error.contains('Authentication failed')) {
      return 'Please login again to view notifications';
    } else if (error.contains('User not found')) {
      return 'User account not found';
    } else if (error.contains('Invalid response format')) {
      return 'Server returned invalid data';
    } else if (error.contains('Connection refused') || error.contains('Network')) {
      return 'Unable to connect to server. Please check your internet connection';
    } else if (error.contains('Server error')) {
      return 'Server is currently unavailable. Please try again later';
    } else if (error.contains('timeout')) {
      return 'Request timed out. Please try again';
    } else {
      return 'Failed to load notifications. Please try again';
    }
  }

  // Mark notification as read
  Future<bool> markAsRead(String notificationId) async {
    try {
      final user = await UserPreferences.getUser();
      if (user != null && user.id != null && user.id!.isNotEmpty) {
        // For string-based notifications, we might not have server-side mark as read
        // So we'll just update locally for now
        final index = _notifications.indexWhere((notification) => 
          notification['id'] == notificationId || notification['_id'] == notificationId);
        
        if (index != -1) {
          // Try to mark as read on server if possible
          bool serverSuccess = true;
          try {
            if (!notificationId.startsWith('notification_')) {
              // Only call server if it's not a generated ID
              serverSuccess = await _notificationService.markAsRead(user.id!, notificationId);
            }
          } catch (e) {
            print('Server markAsRead failed, updating locally: $e');
            serverSuccess = true; // Continue with local update
          }
          
          if (serverSuccess) {
            _notifications[index]['isRead'] = true;
            _unreadCount = (_unreadCount > 0) ? _unreadCount - 1 : 0;
            notifyListeners();
            return true;
          }
        }
      }
      return false;
    } catch (e) {
      _error = _getReadableError(e.toString());
      notifyListeners();
      print('Error marking notification as read: $e');
      return false;
    }
  }

  // Delete notification
  Future<bool> deleteNotification(String notificationId) async {
    try {
      final user = await UserPreferences.getUser();
      if (user != null && user.id != null && user.id!.isNotEmpty) {
        // For string-based notifications, we might not have server-side delete
        // So we'll handle it locally for generated IDs
        final index = _notifications.indexWhere((notification) => 
          notification['id'] == notificationId || notification['_id'] == notificationId);
        
        if (index != -1) {
          bool serverSuccess = true;
          
          try {
            if (!notificationId.startsWith('notification_')) {
              // Only call server if it's not a generated ID
              serverSuccess = await _notificationService.deleteNotification(user.id!, notificationId);
            }
          } catch (e) {
            print('Server deleteNotification failed, updating locally: $e');
            serverSuccess = true; // Continue with local update
          }
          
          if (serverSuccess) {
            final wasUnread = _notifications[index]['isRead'] != true;
            _notifications.removeAt(index);
            if (wasUnread) {
              _unreadCount = (_unreadCount > 0) ? _unreadCount - 1 : 0;
            }
            notifyListeners();
            return true;
          }
        }
      }
      return false;
    } catch (e) {
      _error = _getReadableError(e.toString());
      notifyListeners();
      print('Error deleting notification: $e');
      return false;
    }
  }

  // Get unread count
  Future<void> _fetchUnreadCount() async {
    try {
      final user = await UserPreferences.getUser();
      if (user != null && user.id != null && user.id!.isNotEmpty) {
        _unreadCount = await _notificationService.getUnreadCount(user.id!);
        print('Unread count: $_unreadCount');
      }
    } catch (e) {
      print('Error fetching unread count: $e');
      // Don't show error to user for unread count failure
    }
  }

  // Mark all notifications as read
  Future<bool> markAllAsRead() async {
    try {
      final user = await UserPreferences.getUser();
      if (user != null && user.id != null && user.id!.isNotEmpty) {
        final success = await _notificationService.markAllAsRead(user.id!);
        if (success) {
          // Update all local notifications
          for (var notification in _notifications) {
            notification['isRead'] = true;
          }
          _unreadCount = 0;
          notifyListeners();
          return true;
        }
      }
      return false;
    } catch (e) {
      _error = _getReadableError(e.toString());
      notifyListeners();
      print('Error marking all notifications as read: $e');
      return false;
    }
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }

  // Refresh notifications
  Future<void> refreshNotifications() async {
    await fetchNotifications();
  }

  // Get filtered notifications
  List<Map<String, dynamic>> getFilteredNotifications({bool? isRead}) {
    if (isRead == null) return _notifications;
    return _notifications.where((notification) => 
      (notification['isRead'] == true) == isRead).toList();
  }

  // Get unread notifications
  List<Map<String, dynamic>> get unreadNotifications {
    return getFilteredNotifications(isRead: false);
  }

  // Get read notifications
  List<Map<String, dynamic>> get readNotifications {
    return getFilteredNotifications(isRead: true);
  }
}