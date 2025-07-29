// import 'package:booking_application/helper/storage_helper.dart';
// import 'package:booking_application/modal/registration_model.dart';
// import 'package:booking_application/services/registration_service.dart';
// import 'package:flutter/material.dart';

// enum RegistrationState { idle, loading, success, error }

// class RegistrationProvider extends ChangeNotifier {
//   final RegistrationService _service = RegistrationService();
  
//   RegistrationState _state = RegistrationState.idle;
//   String? _errorMessage;
//   User? _user;

//   // Getters
//   RegistrationState get state => _state;
//   String? get errorMessage => _errorMessage;
//   User? get user => _user;
//   bool get isLoading => _state == RegistrationState.loading;

//   // Registration method
//   Future<bool> registerUser({
//     required String name,
//     required String email,
//     required String mobile,
//     required String password,
//   }) async {
//     _setState(RegistrationState.loading);
    
//     try {
//       final request = RegistrationRequest(
//         name: name,
//         email: email,
//         mobile: mobile,
//         password: password,
//       );

//       final response = await _service.registerUser(request);

//       if (response.success) {
//         _user = response.user;
        
//         // Save user to shared preferences
//         await UserPreferences.saveUser(_user!);
        
//         _setState(RegistrationState.success);
//         return true;
//       } else {
//         _errorMessage = response.message ?? 'Registration failed';
//         _setState(RegistrationState.error);
//         return false;
//       }
//     } catch (e) {
//       _errorMessage = e.toString();
//       _setState(RegistrationState.error);
//       return false;
//     }
//   }

//   // Load user from preferences
//   Future<void> loadUserFromPreferences() async {
//     try {
//       final user = await UserPreferences.getUser();
//       if (user != null) {
//         _user = user;
//         notifyListeners();
//       }
//     } catch (e) {
//       print('Error loading user from preferences: $e');
//     }
//   }

//   // Logout method
//   Future<void> logout() async {
//     try {
//       await UserPreferences.clearUserData();
//       _user = null;
//       _setState(RegistrationState.idle);
//     } catch (e) {
//       print('Error during logout: $e');
//     }
//   }

//   // Check if user is logged in
//   Future<bool> checkLoginStatus() async {
//     try {
//       return await UserPreferences.isLoggedIn();
//     } catch (e) {
//       print('Error checking login status: $e');
//       return false;
//     }
//   }

//   // Clear error
//   void clearError() {
//     _errorMessage = null;
//     if (_state == RegistrationState.error) {
//       _setState(RegistrationState.idle);
//     }
//   }

//   // Private method to update state
//   void _setState(RegistrationState newState) {
//     _state = newState;
//     notifyListeners();
//   }
// }















import 'package:booking_application/helper/storage_helper.dart';
import 'package:booking_application/modal/registration_model.dart';
import 'package:booking_application/services/registration_service.dart';
import 'package:flutter/material.dart';

enum RegistrationState { idle, loading, success, error }

class RegistrationProvider extends ChangeNotifier {
  final RegistrationService _service = RegistrationService();
  
  // Controllers for form fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  
  // State management
  RegistrationState _state = RegistrationState.idle;
  String? _errorMessage;
  String? _successMessage;
  User? _user;
  bool _isPasswordVisible = false;
  
  // Validation errors map
  Map<String, String> _validationErrors = {};

  // Getters
  RegistrationState get state => _state;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;
  User? get user => _user;
  bool get isLoading => _state == RegistrationState.loading;
  bool get isPasswordVisible => _isPasswordVisible;

  // Validation methods
  bool hasError(String field) => _validationErrors.containsKey(field);
  String? getValidationError(String field) => _validationErrors[field];
  
  void clearValidationErrors() {
    _validationErrors.clear();
    notifyListeners();
  }
  
  void setValidationError(String field, String message) {
    _validationErrors[field] = message;
    notifyListeners();
  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  // Clear messages
  void clearMessages() {
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();
  }

  // Clear form
  void clearForm() {
    nameController.clear();
    emailController.clear();
    mobileController.clear();
    passwordController.clear();
    _validationErrors.clear();
    _isPasswordVisible = false;
    notifyListeners();
  }

  // Registration method (updated to use controllers)
  Future<bool> registerUser() async {
    // Clear previous messages and validation errors
    clearMessages();
    clearValidationErrors();
    
    // Basic validation
    bool isValid = true;
    
    if (nameController.text.trim().isEmpty) {
      setValidationError('name', 'Please enter your name');
      isValid = false;
    }
    
    if (emailController.text.trim().isEmpty) {
      setValidationError('email', 'Please enter your email');
      isValid = false;
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(emailController.text.trim())) {
      setValidationError('email', 'Please enter a valid email address');
      isValid = false;
    }
    
    if (mobileController.text.trim().isEmpty) {
      setValidationError('mobile', 'Please enter your mobile number');
      isValid = false;
    } else if (!RegExp(r'^[0-9]{10}$').hasMatch(mobileController.text.trim())) {
      setValidationError('mobile', 'Please enter a valid 10-digit mobile number');
      isValid = false;
    }
    
    if (passwordController.text.trim().isEmpty) {
      setValidationError('password', 'Please enter your password');
      isValid = false;
    } else if (passwordController.text.length < 6) {
      setValidationError('password', 'Password must be at least 6 characters');
      isValid = false;
    }
    
    if (!isValid) {
      return false;
    }
    
    _setState(RegistrationState.loading);
    
    try {
      final request = RegistrationRequest(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        mobile: mobileController.text.trim(),
        password: passwordController.text.trim(),
      );

      final response = await _service.registerUser(request);

      if (response.success) {
        _user = response.user;
        _successMessage = response.message ?? 'Registration successful!';
        
        // Save user to shared preferences
        await UserPreferences.saveUser(_user!);
        
        _setState(RegistrationState.success);
        return true;
      } else {
        _errorMessage = response.message ?? 'Registration failed';
        _setState(RegistrationState.error);
        return false;
      }
    } catch (e) {
      _errorMessage = e.toString();
      _setState(RegistrationState.error);
      return false;
    }
  }

  // Load user from preferences
  Future<void> loadUserFromPreferences() async {
    try {
      final user = await UserPreferences.getUser();
      if (user != null) {
        _user = user;
        notifyListeners();
      }
    } catch (e) {
      print('Error loading user from preferences: $e');
    }
  }

  // Logout method
  Future<void> logout() async {
    try {
      await UserPreferences.clearUserData();
      _user = null;
      clearForm();
      _setState(RegistrationState.idle);
    } catch (e) {
      print('Error during logout: $e');
    }
  }

  // Check if user is logged in
  Future<bool> checkLoginStatus() async {
    try {
      return await UserPreferences.isLoggedIn();
    } catch (e) {
      print('Error checking login status: $e');
      return false;
    }
  }

  // Clear error
  void clearError() {
    _errorMessage = null;
    if (_state == RegistrationState.error) {
      _setState(RegistrationState.idle);
    }
  }

  // Private method to update state
  void _setState(RegistrationState newState) {
    _state = newState;
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}