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
        // Fetch updated profile from API
        final updatedUser = await _userProfileService.getUserProfile(_currentUser!.id);
        if (updatedUser != null) {
          _currentUser = updatedUser;
          // Update local storage with fresh data
          await UserPreferences.updateUser(_currentUser!);
        }
      }
      
      notifyListeners();
    } catch (e) {
      _setError('Failed to load user profile: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Update user profile
  Future<bool> updateProfile({
    required String name,
    required String email,
    required String mobile,
  }) async {
    if (_currentUser == null) return false;

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
      _setError('Error updating profile: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Upload profile image
  Future<bool> uploadProfileImage(String imagePath) async {
    if (_currentUser == null) return false;

    _setLoading(true);
    _clearError();

    try {
      final imageUrl = await _userProfileService.uploadProfileImage(
        _currentUser!.id,
        imagePath,
      );

      if (imageUrl != null) {
        _profileImageUrl = imageUrl;
        notifyListeners();
        return true;
      } else {
        _setError('Failed to upload image');
        return false;
      }
    } catch (e) {
      _setError('Error uploading image: $e');
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
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
  }
}