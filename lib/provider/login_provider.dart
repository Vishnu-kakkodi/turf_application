// import 'package:flutter/material.dart';
// import 'package:booking_application/services/login_service.dart';
// import 'package:booking_application/modal/registration_model.dart';

// enum LoginState { idle, loading, success, error, otpSent, otpVerifying }

// class LoginProvider extends ChangeNotifier {
//   final LoginService _loginService = LoginService();
  
//   LoginState _state = LoginState.idle;
//   String _message = '';
//   User? _currentUser;
//   String? _token;
//   bool _isLoggedIn = false;
  
//   // Getters
//   LoginState get state => _state;
//   String get message => _message;
//   User? get currentUser => _currentUser;
//   String? get token => _token;
//   bool get isLoggedIn => _isLoggedIn;
//   bool get isLoading => _state == LoginState.loading || _state == LoginState.otpVerifying;

//   // Initialize provider - check if user is already logged in
//   Future<void> initialize() async {
//     _state = LoginState.loading;
//     notifyListeners();
    
//     try {
//       _isLoggedIn = await _loginService.isUserLoggedIn();
//       if (_isLoggedIn) {
//         _currentUser = await _loginService.getCurrentUser();
//         _state = LoginState.success;
//       } else {
//         _state = LoginState.idle;
//       }
//     } catch (e) {
//       _state = LoginState.error;
//       _message = 'Initialization error: ${e.toString()}';
//     }
    
//     notifyListeners();
//   }

//   // Login with mobile number
//   Future<bool> loginWithMobile(String mobile) async {
//     if (mobile.isEmpty) {
//       _setError('Mobile number is required');
//       return false;
//     }

//     if (!_isValidMobile(mobile)) {
//       _setError('Please enter a valid mobile number');
//       return false;
//     }

//     _setState(LoginState.loading, 'Sending OTP...');
    
//     try {
//       final response = await _loginService.loginWithMobile(mobile);
      
//       if (response.success) {
//         _setState(LoginState.otpSent, response.message);
//         return true;
//       } else {
//         _setError(response.message);
//         return false;
//       }
//     } catch (e) {
//       _setError('Login failed: ${e.toString()}');
//       return false;
//     }
//   }

//   // Verify OTP
//   Future<bool> verifyOTP(String mobile, String otp) async {
//     if (otp.isEmpty) {
//       _setError('OTP is required');
//       return false;
//     }

//     if (otp.length != 6) {
//       _setError('Please enter a valid 6-digit OTP');
//       return false;
//     }

//     _setState(LoginState.otpVerifying, 'Verifying OTP...');
    
//     try {
//       final response = await _loginService.verifyOTP(mobile, otp);
      
//       if (response.success && response.user != null) {
//         _currentUser = response.user;
//         _token = response.token;
//         _isLoggedIn = true;
//         _setState(LoginState.success, 'Login successful');
//         return true;
//       } else {
//         _setError(response.message);
//         return false;
//       }
//     } catch (e) {
//       _setError('OTP verification failed: ${e.toString()}');
//       return false;
//     }
//   }

//   // Logout
//   Future<bool> logout() async {
//     _setState(LoginState.loading, 'Logging out...');
    
//     try {
//       final success = await _loginService.logout();
      
//       if (success) {
//         _currentUser = null;
//         _token = null;
//         _isLoggedIn = false;
//         _setState(LoginState.idle, 'Logged out successfully');
//         return true;
//       } else {
//         _setError('Logout failed');
//         return false;
//       }
//     } catch (e) {
//       _setError('Logout error: ${e.toString()}');
//       return false;
//     }
//   }

//   // Resend OTP
//   Future<bool> resendOTP(String mobile) async {
//     return await loginWithMobile(mobile);
//   }

//   // Clear any error messages
//   void clearError() {
//     if (_state == LoginState.error) {
//       _state = LoginState.idle;
//       _message = '';
//       notifyListeners();
//     }
//   }

//   // Reset to idle state
//   void reset() {
//     _state = LoginState.idle;
//     _message = '';
//     notifyListeners();
//   }

//   // Private helper methods
//   void _setState(LoginState state, String message) {
//     _state = state;
//     _message = message;
//     notifyListeners();
//   }

//   void _setError(String errorMessage) {
//     _state = LoginState.error;
//     _message = errorMessage;
//     notifyListeners();
//   }

//   bool _isValidMobile(String mobile) {
//     // Indian mobile number validation (10 digits)
//     final RegExp mobileRegex = RegExp(r'^[6-9]\d{9}$');
//     return mobileRegex.hasMatch(mobile);
//   }

//   // Update user profile (if needed)
//   void updateUser(User user) {
//     _currentUser = user;
//     notifyListeners();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }
// }



















import 'package:booking_application/helper/storage_helper.dart';
import 'package:booking_application/services/login_service.dart';
import 'package:flutter/material.dart';
import 'package:booking_application/modal/registration_model.dart';


enum LoginState { idle, loading, success, error }

class LoginProvider extends ChangeNotifier {
  final LoginService _loginService = LoginService();
  
  LoginState _loginState = LoginState.idle;
  LoginState _otpState = LoginState.idle;
  String? _errorMessage;
  User? _currentUser;
  String? _authToken;
  String? _currentMobile;

  // Getters
  LoginState get loginState => _loginState;
  LoginState get otpState => _otpState;
  String? get errorMessage => _errorMessage;
  User? get currentUser => _currentUser;
  String? get authToken => _authToken;
  String? get currentMobile => _currentMobile;
  bool get isLoggedIn => _currentUser != null;

  // Login with mobile number
  Future<bool> loginWithMobile(String mobile) async {
    _setLoginState(LoginState.loading);
    
    try {
      final result = await _loginService.loginWithMobile(mobile);
      
      if (result['success']) {
        _currentMobile = mobile;
        _setLoginState(LoginState.success);
        _clearError();
        return true;
      } else {
        _setError(result['message']);
        _setLoginState(LoginState.error);
        return false;
      }
    } catch (e) {
      _setError('An unexpected error occurred: ${e.toString()}');
      _setLoginState(LoginState.error);
      return false;
    }
  }

  // Verify OTP
  Future<bool> verifyOtp(String otp) async {
    _setOtpState(LoginState.loading);
    
    try {
      final result = await _loginService.verifyOtp(otp);
      
      if (result['success']) {
        final data = result['data'];
        
        // Extract user data and token from response
        if (data['user'] != null) {
          _currentUser = User.fromJson(data['user']);
          await UserPreferences.saveUser(_currentUser!);
        }
        
        if (data['token'] != null) {
          _authToken = data['token'];
          await UserPreferences.saveToken(_authToken!);
        }
        
        _setOtpState(LoginState.success);
        _clearError();
        return true;
      } else {
        _setError(result['message']);
        _setOtpState(LoginState.error);
        return false;
      }
    } catch (e) {
      _setError('An unexpected error occurred: ${e.toString()}');
      _setOtpState(LoginState.error);
      return false;
    }
  }

  // Register user
  Future<bool> registerUser(RegistrationRequest request) async {
    _setLoginState(LoginState.loading);
    
    try {
      final result = await _loginService.registerUser(request);
      
      if (result['success']) {
        final data = result['data'];
        
        if (data['user'] != null) {
          _currentUser = User.fromJson(data['user']);
          await UserPreferences.saveUser(_currentUser!);
        }
        
        if (data['token'] != null) {
          _authToken = data['token'];
          await UserPreferences.saveToken(_authToken!);
        }
        
        _setLoginState(LoginState.success);
        _clearError();
        return true;
      } else {
        _setError(result['message']);
        _setLoginState(LoginState.error);
        return false;
      }
    } catch (e) {
      _setError('An unexpected error occurred: ${e.toString()}');
      _setLoginState(LoginState.error);
      return false;
    }
  }

  // Load user data from preferences
  Future<void> loadUserData() async {
    try {
      final isLoggedIn = await UserPreferences.isLoggedIn();
      if (isLoggedIn) {
        _currentUser = await UserPreferences.getUser();
        _authToken = await UserPreferences.getToken();
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error loading user data: $e');
    }
  }

  // Logout user
  Future<void> logout() async {
    try {
      await UserPreferences.clearUserData();
      _currentUser = null;
      _authToken = null;
      _currentMobile = null;
      _setLoginState(LoginState.idle);
      _setOtpState(LoginState.idle);
      _clearError();
    } catch (e) {
      debugPrint('Error during logout: $e');
    }
  }

  // Update user data
  Future<bool> updateUser(User user) async {
    try {
      final success = await UserPreferences.updateUser(user);
      if (success) {
        _currentUser = user;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Error updating user: $e');
      return false;
    }
  }

  // Reset states
  void resetLoginState() {
    _setLoginState(LoginState.idle);
    _clearError();
  }

  void resetOtpState() {
    _setOtpState(LoginState.idle);
    _clearError();
  }

  // Private helper methods
  void _setLoginState(LoginState state) {
    _loginState = state;
    notifyListeners();
  }

  void _setOtpState(LoginState state) {
    _otpState = state;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Check login status
  Future<bool> checkLoginStatus() async {
    try {
      final isLoggedIn = await UserPreferences.isLoggedIn();
      if (isLoggedIn) {
        await loadUserData();
        return _currentUser != null;
      }
      return false;
    } catch (e) {
      debugPrint('Error checking login status: $e');
      return false;
    }
  }
}