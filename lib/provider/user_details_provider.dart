import 'package:booking_application/helper/storage_helper.dart';
import 'package:flutter/material.dart';
import 'package:booking_application/modal/registration_model.dart';
import 'package:booking_application/services/user_detail_service.dart';

class UserDetailsProvider extends ChangeNotifier {
  final UserDetailService _userDetailService = UserDetailService();

  // Current user data
  User? _currentUser;
  User? get currentUser => _currentUser;

  // Loading states
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isUpdating = false;
  bool get isUpdating => _isUpdating;

  // Error handling
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // Success message
  String? _successMessage;
  String? get successMessage => _successMessage;

  // Form controllers for profile update
  final TextEditingController cityController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  // Initialize provider
  UserDetailsProvider() {
    _loadUserFromPreferences();
  }

  Future<void> _loadUserFromPreferences() async {
    _setLoading(true);
    try {
      final user = await UserPreferences.getUser();
      if (user != null) {
        _currentUser = user;
        _populateControllers();
      }
    } catch (e) {
      _setErrorMessage('Failed to load user data: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }


  void _populateControllers() {
    if (_currentUser != null) {

      cityController.clear();
      genderController.clear();
      dobController.clear();
    }
  }

  // Update user profile
  Future<bool> updateUserProfile({
    String? city,
    String? gender,
    String? dob,
  }) async {
    if (_currentUser == null) {
      _setErrorMessage('No user logged in');
      return false;
    }
       
    
    


    _setUpdating(true);
    _clearMessages();

    try {
      final response = await _userDetailService.updateUserProfile(
        userId: _currentUser!.id,
        city: city ?? cityController.text.trim(),
        gender: gender ?? genderController.text.trim(),
        dob: dob ?? dobController.text.trim(),
      );

      if (response.success && response.data != null) {
        _currentUser = response.data;
        _setSuccessMessage(response.message ?? 'Profile updated successfully');
        return true;
      } else {
        _setErrorMessage(response.message ?? 'Failed to update profile');
        return false;
      }
    } catch (e) {
      _setErrorMessage('Error updating profile: ${e.toString()}');
      return false;
    } finally {
      _setUpdating(false);
    }
  }

  // Refresh user profile from server
  Future<void> refreshUserProfile() async {
    if (_currentUser == null) {
      _setErrorMessage('No user logged in');
      return;
    }

    _setLoading(true);
    _clearMessages();

    try {
      final response =
          await _userDetailService.getUserProfile(_currentUser!.id);

      if (response.success && response.data != null) {
        _currentUser = response.data;
        _populateControllers();
        _setSuccessMessage('Profile refreshed successfully');
      } else {
        _setErrorMessage(response.message ?? 'Failed to refresh profile');
      }
    } catch (e) {
      _setErrorMessage('Error refreshing profile: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> updateCity(String city) async {
    return await updateUserProfile(city: city);
  }

  Future<bool> updateGender(String gender) async {
    return await updateUserProfile(gender: gender);
  }

  Future<bool> updateDateOfBirth(String dob) async {
    return await updateUserProfile(dob: dob);
  }

  // Validation methods
  bool validateCity() {
    final city = cityController.text.trim();
    if (city.isEmpty) {
      _setErrorMessage('City cannot be empty');
      return false;
    }
    return true;
  }

  bool validateGender() {
    final gender = genderController.text.trim();
    if (gender.isEmpty) {
      _setErrorMessage('Gender cannot be empty');
      return false;
    }
    return true;
  }

  bool validateDateOfBirth() {
    final dob = dobController.text.trim();
    if (dob.isEmpty) {
      _setErrorMessage('Date of birth cannot be empty');
      return false;
    }

    try {
      DateTime.parse(dob);
      return true;
    } catch (e) {
      _setErrorMessage('Invalid date format');
      return false;
    }
  }

  void clearForm() {
    cityController.clear();
    genderController.clear();
    dobController.clear();
    _clearMessages();
  }

  void resetForm() {
    _populateControllers();
    _clearMessages();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setUpdating(bool updating) {
    _isUpdating = updating;
    notifyListeners();
  }

  void _setErrorMessage(String message) {
    _errorMessage = message;
    _successMessage = null;
    notifyListeners();
  }

  void _setSuccessMessage(String message) {
    _successMessage = message;
    _errorMessage = null;
    notifyListeners();
  }

  void _clearMessages() {
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();
  }

  void clearErrorMessage() {
    _errorMessage = null;
    notifyListeners();
  }

  void clearSuccessMessage() {
    _successMessage = null;
    notifyListeners();
  }

  bool get hasChanges {
    return cityController.text.trim().isNotEmpty ||
        genderController.text.trim().isNotEmpty ||
        dobController.text.trim().isNotEmpty;
  }

  @override
  void dispose() {
    cityController.dispose();
    genderController.dispose();
    dobController.dispose();
    super.dispose();
  }
}
