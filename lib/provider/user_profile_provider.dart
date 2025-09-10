// import 'package:booking_application/helper/storage_helper.dart';
// import 'package:booking_application/services/user_profile_servive.dart';
// import 'package:flutter/material.dart';
// import 'package:booking_application/modal/registration_model.dart';


// class UserProfileProvider extends ChangeNotifier {
//   final UserProfileService _userProfileService = UserProfileService();
  
//   User? _currentUser;
//   bool _isLoading = false;
//   String? _errorMessage;
//   String? _profileImageUrl;

//   // Getters
//   User? get currentUser => _currentUser;
//   bool get isLoading => _isLoading;
//   String? get errorMessage => _errorMessage;
//   String? get profileImageUrl => _profileImageUrl;

//   // Load user profile from local storage first, then fetch from API
//   Future<void> loadUserProfile() async {
//     _setLoading(true);
//     _clearError();

//     try {
//       // First try to get user from local storage
//       _currentUser = await UserPreferences.getUser();
      
//       if (_currentUser != null) {
//         // Fetch updated profile from API
//         final updatedUser = await _userProfileService.getUserProfile(_currentUser!.id);
//         if (updatedUser != null) {
//           _currentUser = updatedUser;
//           // Update local storage with fresh data
//           await UserPreferences.updateUser(_currentUser!);
//         }
//       }
      
//       notifyListeners();
//     } catch (e) {
//       _setError('Failed to load user profile: $e');
//     } finally {
//       _setLoading(false);
//     }
//   }

//   // Update user profile
//   Future<bool> updateProfile({
//     required String name,
//     required String email,
//     required String mobile,
//   }) async {
//     if (_currentUser == null) return false;

//     _setLoading(true);
//     _clearError();

//     try {
//       final userData = {
//         'name': name,
//         'email': email,
//         'mobile': mobile,
//       };

//       final success = await _userProfileService.updateUserProfile(
//         _currentUser!.id,
//         userData,
//       );

//       if (success) {
//         // Update local user object
//         _currentUser = User(
//           id: _currentUser!.id,
//           name: name,
//           email: email,
//           mobile: mobile,
//           password: _currentUser!.password,
//           otp: _currentUser!.otp,
//           createdAt: _currentUser!.createdAt,
//           updatedAt: DateTime.now(),
//         );

//         // Save to local storage
//         await UserPreferences.updateUser(_currentUser!);
//         notifyListeners();
//         return true;
//       } else {
//         _setError('Failed to update profile');
//         return false;
//       }
//     } catch (e) {
//       _setError('Error updating profile: $e');
//       return false;
//     } finally {
//       _setLoading(false);
//     }
//   }

//   // Upload profile image
//   Future<bool> uploadProfileImage(String imagePath) async {
//     if (_currentUser == null) return false;

//     _setLoading(true);
//     _clearError();

//     try {
//       final imageUrl = await _userProfileService.uploadProfileImage(
//         _currentUser!.id,
//         imagePath,
//       );

//       if (imageUrl != null) {
//         _profileImageUrl = imageUrl;
//         notifyListeners();
//         return true;
//       } else {
//         _setError('Failed to upload image');
//         return false;
//       }
//     } catch (e) {
//       _setError('Error uploading image: $e');
//       return false;
//     } finally {
//       _setLoading(false);
//     }
//   }

//   // Set current user manually (useful for initial setup)
//   void setCurrentUser(User user) {
//     _currentUser = user;
//     notifyListeners();
//   }

//   // Clear user data
//   void clearUser() {
//     _currentUser = null;
//     _profileImageUrl = null;
//     _clearError();
//     notifyListeners();
//   }

//   // Private helper methods
//   void _setLoading(bool loading) {
//     _isLoading = loading;
//     notifyListeners();
//   }

//   void _setError(String error) {
//     _errorMessage = error;
//     notifyListeners();
//   }

//   void _clearError() {
//     _errorMessage = null;
//   }
// }


















import 'package:booking_application/helper/storage_helper.dart';
import 'package:booking_application/services/user_profile_servive.dart';
import 'package:flutter/material.dart';
import 'package:booking_application/modal/registration_model.dart';

class UserProfileProvider extends ChangeNotifier {
  final UserProfileService _userProfileService = UserProfileService();
  
  User? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;
  String? _profileImageUrl;

  // Getters
  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get profileImageUrl => _profileImageUrl;

  // Load user profile from local storage first, then fetch from API
  Future<void> loadUserProfile() async {
    _setLoading(true);
    _clearError();

    try {
      // First try to get user from local storage
      _currentUser = await UserPreferences.getUser();
      
      if (_currentUser != null) {
        print('Loaded user from storage: ${_currentUser!.name}');
        // Fetch updated profile from API
        final updatedUser = await _userProfileService.getUserProfile(_currentUser!.id);
        if (updatedUser != null) {
          _currentUser = updatedUser;
          // Update local storage with fresh data
          await UserPreferences.updateUser(_currentUser!);
          print('Updated user from API: ${_currentUser!.name}');
        } else {
          print('Failed to fetch updated user from API, using cached data');
        }
      } else {
        print('No user found in storage');
      }
      
      notifyListeners();
    } catch (e) {
      print('Error in loadUserProfile: $e');
      _setError('Failed to load user profile: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Update user profile (legacy method - keeping for backward compatibility)
  Future<bool> updateProfile({
    required String name,
    required String email,
    required String mobile,
  }) async {
    if (_currentUser == null) {
      _setError('No user logged in');
      return false;
    }

    _setLoading(true);
    _clearError();

    try {
      final userData = {
        'name': name,
        'email': email,
        'mobile': mobile,
      };

      final success = await _userProfileService.updateUserProfile(
        _currentUser!.id,
        userData,
      );

      if (success) {
        // Update local user object
        _currentUser = User(
          id: _currentUser!.id,
          name: name,
          email: email,
          mobile: mobile,
          password: _currentUser!.password,
          otp: _currentUser!.otp,
          createdAt: _currentUser!.createdAt,
          updatedAt: DateTime.now(),
        );

        // Save to local storage
        await UserPreferences.updateUser(_currentUser!);
        notifyListeners();
        return true;
      } else {
        _setError('Failed to update profile');
        return false;
      }
    } catch (e) {
      print('Error in updateProfile: $e');
      _setError('Error updating profile: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // NEW: Update user info using the new API endpoint
  Future<bool> updateUserInfo({
    required String name,
    required String email,
    required String phone,
  }) async {
    if (_currentUser == null) {
      _setError('No user logged in');
      return false;
    }

    _setLoading(true);
    _clearError();

    try {
      final success = await _userProfileService.updateUserInfo(
        _currentUser!.id,
        name: name,
        email: email,
        phone: phone,
      );

      if (success) {
        // Update local user object
        _currentUser = User(
          id: _currentUser!.id,
          name: name,
          email: email,
          mobile: phone, // Map phone to mobile field
          password: _currentUser!.password,
          otp: _currentUser!.otp,
          createdAt: _currentUser!.createdAt,
          updatedAt: DateTime.now(),
        );

        // Save to local storage
        await UserPreferences.updateUser(_currentUser!);
        notifyListeners();
        return true;
      } else {
        _setError('Failed to update user info');
        return false;
      }
    } catch (e) {
      print('Error in updateUserInfo: $e');
      _setError('Error updating user info: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Upload profile image (legacy method - keeping for backward compatibility)
  // Future<bool> uploadProfileImage(String imagePath) async {
  //   if (_currentUser == null) {
  //     _setError('No user logged in');
  //     return false;
  //   }

  //   _setLoading(true);
  //   _clearError();

  //   try {
  //     print('Uploading profile image: $imagePath');
  //     final imageUrl = await _userProfileService.updateProfileImage(
  //       _currentUser!.id,
  //       imagePath,
  //     );

  //     if (imageUrl != null && imageUrl.isNotEmpty) {
  //       _profileImageUrl = imageUrl;
  //       print('Profile image uploaded successfully: $imageUrl');
  //       notifyListeners();
  //       return true;
  //     } else {
  //       _setError('Failed to upload image - no URL returned');
  //       return false;
  //     }
  //   } catch (e) {
  //     print('Error in uploadProfileImage: $e');
  //     _setError('Error uploading image: $e');
  //     return false;
  //   } finally {
  //     _setLoading(false);
  //   }
  // }



  Future<bool> uploadProfileImage(String imagePath) async {
  if (_currentUser == null) {
    _setError('No user logged in');
    return false;
  }

  _setLoading(true);
  _clearError();

  try {
    print('Uploading profile image: $imagePath');
    final imageUrl = await _userProfileService.updateProfileImage(
      _currentUser!.id,
      imagePath,
    );

    if (imageUrl != null && imageUrl.isNotEmpty) {
      // Update both the profileImageUrl and the currentUser's profileImage
      _profileImageUrl = imageUrl;
      _currentUser = User(
        id: _currentUser!.id,
        name: _currentUser!.name,
        email: _currentUser!.email,
        mobile: _currentUser!.mobile,
        password: _currentUser!.password,
        otp: _currentUser!.otp,
        profileImage: imageUrl, // Update the profile image URL
        createdAt: _currentUser!.createdAt,
        updatedAt: DateTime.now(),
      );
      
      // Save to local storage
      await UserPreferences.updateUser(_currentUser!);
      
      print('Profile image uploaded successfully: $imageUrl');
      notifyListeners();
      return true;
    } else {
      _setError('Failed to upload image - no URL returned');
      return false;
    }
  } catch (e) {
    print('Error in uploadProfileImage: $e');
    _setError('Error uploading image: $e');
    return false;
  } finally {
    _setLoading(false);
  }
}

  // NEW: Update profile image using the new API endpoint
  Future<bool> updateProfileImage(String imagePath) async {
    if (_currentUser == null) {
      _setError('No user logged in');
      return false;
    }

    _setLoading(true);
    _clearError();

    try {
      print('Updating profile image: $imagePath');
      final imageUrl = await _userProfileService.updateProfileImage(
        _currentUser!.id,
        imagePath,
      );

      if (imageUrl != null && imageUrl.isNotEmpty) {
        _profileImageUrl = imageUrl;
        print('Profile image updated successfully: $imageUrl');
        notifyListeners();
        return true;
      } else {
        _setError('Failed to update profile image - no URL returned');
        return false;
      }
    } catch (e) {
      print('Error in updateProfileImage: $e');
      _setError('Error updating profile image: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Set current user manually (useful for initial setup)
  void setCurrentUser(User user) {
    _currentUser = user;
    notifyListeners();
  }

  // Clear user data
  void clearUser() {
    _currentUser = null;
    _profileImageUrl = null;
    _clearError();
    notifyListeners();
  }

  // Private helper methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    print('UserProfileProvider Error: $error');
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
  }
}