// import 'package:booking_application/auth/user_details.dart';
// import 'package:booking_application/provider/login_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
// import 'dart:async';

// class OtpScreen extends StatefulWidget {
//   final String mobileNumber;
  
//   const OtpScreen({
//     super.key,
//     required this.mobileNumber,
//   });

//   @override
//   State<OtpScreen> createState() => _OtpScreenState();
// }

// class _OtpScreenState extends State<OtpScreen> {
//   final List<TextEditingController> _controllers = List.generate(4, (index) => TextEditingController());
//   final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());
  
//   Timer? _timer;
//   int _resendCountdown = 0;
//   bool _canResend = true;

//   @override
//   void initState() {
//     super.initState();
//     // Initialize controllers
//     for (var controller in _controllers) {
//       controller.text = '';
//     }
    
//     // Auto-focus first field
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _focusNodes[0].requestFocus();
//     });
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     for (var controller in _controllers) {
//       controller.dispose();
//     }
//     for (var focusNode in _focusNodes) {
//       focusNode.dispose();
//     }
//     super.dispose();
//   }

//   void _onChanged(String value, int index) {
//     if (value.isNotEmpty && index < 3) {
//       _focusNodes[index + 1].requestFocus();
//     } else if (value.isEmpty && index > 0) {
//       _focusNodes[index - 1].requestFocus();
//     }
    
//     // Auto-verify when all fields are filled
//     if (_getOtpValue().length == 4) {
//       _verifyOtp();
//     }
//   }

//   void _onKeyEvent(RawKeyEvent event, int index) {
//     if (event is RawKeyDownEvent && event.logicalKey == LogicalKeyboardKey.backspace) {
//       if (_controllers[index].text.isEmpty && index > 0) {
//         _focusNodes[index - 1].requestFocus();
//       }
//     }
//   }

//   String _getOtpValue() {
//     return _controllers.map((controller) => controller.text).join();
//   }

//   String _formatMobileNumber(String mobile) {
//     if (mobile.length >= 10) {
//       return '${mobile.substring(0, 3)}*******${mobile.substring(mobile.length - 4)}';
//     }
//     return mobile;
//   }

//   void _verifyOtp() async {
//     String otp = _getOtpValue();
    
//     if (otp.length != 4) {
//       _showSnackBar('Please enter complete OTP', isError: true);
//       return;
//     }

//     final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    
//     final success = await loginProvider.verifyOtp(otp);
    
//     if (success) {
//       // Navigate to user details or home screen
//       if (mounted) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const Adddetails()),
//         );
//       }
//     } else {
//       // Show error and clear OTP fields
//       if (mounted) {
//         _showSnackBar(loginProvider.errorMessage ?? 'Invalid OTP', isError: true);
//         _clearOtpFields();
//       }
//     }
//   }

//   void _clearOtpFields() {
//     for (var controller in _controllers) {
//       controller.clear();
//     }
//     _focusNodes[0].requestFocus();
//   }

//   void _resendOtp() async {
//     if (!_canResend) return;

//     final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    
//     final success = await loginProvider.loginWithMobile(widget.mobileNumber);
    
//     if (success) {
//       _showSnackBar('OTP sent successfully');
//       _startResendTimer();
//     } else {
//       _showSnackBar(loginProvider.errorMessage ?? 'Failed to send OTP', isError: true);
//     }
//   }

//   void _startResendTimer() {
//     setState(() {
//       _canResend = false;
//       _resendCountdown = 30;
//     });

//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (_resendCountdown > 0) {
//         setState(() {
//           _resendCountdown--;
//         });
//       } else {
//         setState(() {
//           _canResend = true;
//         });
//         timer.cancel();
//       }
//     });
//   }

//   void _showSnackBar(String message, {bool isError = false}) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: isError ? Colors.red : Colors.green,
//         duration: const Duration(seconds: 3),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(
//             Icons.arrow_back,
//             color: Colors.black,
//             size: 24,
//           ),
//         ),
//         systemOverlayStyle: SystemUiOverlayStyle.dark,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Title
//             const Text(
//               'Verify your\nnumber',
//               style: TextStyle(
//                 fontSize: 32,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//                 height: 1.2,
//               ),
//             ),
            
//             const SizedBox(height: 16),
            
//             // Subtitle
//             const Text(
//               'Enter the code we sent to the number',
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.grey,
//               ),
//             ),
            
//             const SizedBox(height: 8),
            
//             Text(
//               '+91 ${_formatMobileNumber(widget.mobileNumber)}',
//               style: const TextStyle(
//                 fontSize: 16,
//                 color: Colors.black,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
            
//             const SizedBox(height: 40),
            
//             // OTP Input Fields
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: List.generate(4, (index) {
//                 return Container(
//                   width: 60,
//                   height: 60,
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: _controllers[index].text.isNotEmpty 
//                           ? const Color(0xFF1E88E5) 
//                           : Colors.grey.shade300,
//                       width: _controllers[index].text.isNotEmpty ? 2 : 1,
//                     ),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: RawKeyboardListener(
//                     focusNode: FocusNode(),
//                     onKey: (event) => _onKeyEvent(event, index),
//                     child: TextField(
//                       controller: _controllers[index],
//                       focusNode: _focusNodes[index],
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black,
//                       ),
//                       keyboardType: TextInputType.number,
//                       maxLength: 1,
//                       decoration: const InputDecoration(
//                         border: InputBorder.none,
//                         counterText: '',
//                       ),
//                       inputFormatters: [
//                         FilteringTextInputFormatter.digitsOnly,
//                       ],
//                       onChanged: (value) => _onChanged(value, index),
//                     ),
//                   ),
//                 );
//               }),
//             ),
            
//             const SizedBox(height: 24),
            
//             // Error message display
//             Consumer<LoginProvider>(
//               builder: (context, loginProvider, child) {
//                 if (loginProvider.otpState == LoginState.error && 
//                     loginProvider.errorMessage != null) {
//                   return Padding(
//                     padding: const EdgeInsets.only(bottom: 16),
//                     child: Text(
//                       loginProvider.errorMessage!,
//                       style: const TextStyle(
//                         color: Colors.red,
//                         fontSize: 14,
//                       ),
//                     ),
//                   );
//                 }
//                 return const SizedBox.shrink();
//               },
//             ),
            
//             // Resend Code
//             Row(
//               children: [
//                 Text(
//                   "Didn't receive your code? ",
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey.shade600,
//                   ),
//                 ),
//                 Consumer<LoginProvider>(
//                   builder: (context, loginProvider, child) {
//                     final isLoading = loginProvider.loginState == LoginState.loading;
                    
//                     return GestureDetector(
//                       onTap: (_canResend && !isLoading) ? _resendOtp : null,
//                       child: Text(
//                         _canResend && !isLoading
//                             ? 'Resend'
//                             : isLoading
//                                 ? 'Sending...'
//                                 : 'Resend in ${_resendCountdown}s',
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: (_canResend && !isLoading)
//                               ? const Color(0xFF1E88E5)
//                               : Colors.grey,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
            
//             const Spacer(),
            
//             // Continue Button
//             Consumer<LoginProvider>(
//               builder: (context, loginProvider, child) {
//                 final isLoading = loginProvider.otpState == LoginState.loading;
//                 final otpValue = _getOtpValue();
                
//                 return SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(context, MaterialPageRoute(builder: (context)=>Adddetails()));
//                     },
//                     // onPressed: (isLoading || otpValue.length != 4) ? null : _verifyOtp,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF1E88E5),
//                       foregroundColor: Colors.white,
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       elevation: 0,
//                       disabledBackgroundColor: Colors.grey.shade400,
//                     ),
//                     child: isLoading
//                         ? const SizedBox(
//                             height: 20,
//                             width: 20,
//                             child: CircularProgressIndicator(
//                               strokeWidth: 2,
//                               valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                             ),
//                           )
//                         : const Text(
//                             'Continue',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                   ),
//                 );
//               },
//             ),
            
//             const SizedBox(height: 32),
//           ],
//         ),
//       ),
//     );
//   }
// }




















import 'package:booking_application/auth/user_details.dart';
import 'package:booking_application/home/navbar_screen.dart';
import 'package:booking_application/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class OtpScreen extends StatefulWidget {
  final String mobileNumber;
  
  const OtpScreen({
    super.key,
    required this.mobileNumber,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _controllers = List.generate(4, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());
  
  Timer? _timer;
  int _resendCountdown = 0;
  bool _canResend = true;

  @override
  void initState() {
    super.initState();
    // Initialize controllers
    for (var controller in _controllers) {
      controller.text = '';
    }
    
    // Auto-focus first field
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNodes[0].requestFocus();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.isNotEmpty && index < 3) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
    
    // Auto-verify when all fields are filled
    if (_getOtpValue().length == 4) {
      _verifyOtp();
    }
  }

  void _onKeyEvent(RawKeyEvent event, int index) {
    if (event is RawKeyDownEvent && event.logicalKey == LogicalKeyboardKey.backspace) {
      if (_controllers[index].text.isEmpty && index > 0) {
        _focusNodes[index - 1].requestFocus();
      }
    }
  }

  String _getOtpValue() {
    return _controllers.map((controller) => controller.text).join();
  }

  String _formatMobileNumber(String mobile) {
    if (mobile.length >= 10) {
      return '${mobile.substring(0, 3)}*******${mobile.substring(mobile.length - 4)}';
    }
    return mobile;
  }

  void _verifyOtp() async {
    String otp = _getOtpValue();
    
    if (otp.length != 4) {
      _showSnackBar('Please enter complete OTP', isError: true);
      return;
    }

    print('Entered OTP: $otp'); // Debug print
    
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    
    // Check if your default OTP is 1234
    // if (otp == '1234') {
    //   print('Default OTP entered, navigating...'); // Debug print
    //   if (mounted) {
    //     Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(builder: (context) => const Adddetails()),
    //     );
    //   }
    //   return;
    // }
    
    final success = await loginProvider.verifyOtp(otp,widget.mobileNumber);
    
    if (success) {
      // Navigate to user details or home screen
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>  const NavbarScreen()),
        );
      }
    } else {
      // Show error and clear OTP fields
      if (mounted) {
        _showSnackBar(loginProvider.errorMessage ?? 'Invalid OTP. Try 1234 for testing.', isError: true);
        _clearOtpFields();
      }
    }
  }

  void _clearOtpFields() {
    for (var controller in _controllers) {
      controller.clear();
    }
    _focusNodes[0].requestFocus();
  }

  void _resendOtp() async {
    if (!_canResend) return;

    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    
    final success = await loginProvider.loginWithMobile(widget.mobileNumber);
    
    if (success) {
      _showSnackBar('OTP sent successfully');
      _startResendTimer();
    } else {
      _showSnackBar(loginProvider.errorMessage ?? 'Failed to send OTP', isError: true);
    }
  }

  void _startResendTimer() {
    setState(() {
      _canResend = false;
      _resendCountdown = 30;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendCountdown > 0) {
        setState(() {
          _resendCountdown--;
        });
      } else {
        setState(() {
          _canResend = true;
        });
        timer.cancel();
      }
    });
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 24,
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 
                         MediaQuery.of(context).padding.top - 
                         kToolbarHeight,
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  const Text(
                    'Verify your\nnumber',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      height: 1.2,
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Subtitle
                  const Text(
                    'Enter the code we sent to the number',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  Text(
                    '+91 ${_formatMobileNumber(widget.mobileNumber)}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // OTP Input Fields
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(4, (index) {
                      return Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _controllers[index].text.isNotEmpty 
                                ? const Color(0xFF1E88E5) 
                                : Colors.grey.shade300,
                            width: _controllers[index].text.isNotEmpty ? 2 : 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: RawKeyboardListener(
                          focusNode: FocusNode(),
                          onKey: (event) => _onKeyEvent(event, index),
                          child: TextField(
                            controller: _controllers[index],
                            focusNode: _focusNodes[index],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                            keyboardType: TextInputType.number,
                            maxLength: 1,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              counterText: '',
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            onChanged: (value) => _onChanged(value, index),
                          ),
                        ),
                      );
                    }),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Error message display - Now with constrained height
                  Consumer<LoginProvider>(
                    builder: (context, loginProvider, child) {
                      if (loginProvider.otpState == LoginState.error && 
                          loginProvider.errorMessage != null) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.red.shade200),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.error_outline,
                                color: Colors.red.shade600,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  loginProvider.errorMessage!,
                                  style: TextStyle(
                                    color: Colors.red.shade700,
                                    fontSize: 14,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  
                  // Resend Code
                  Row(
                    children: [
                      Text(
                        "Didn't receive your code? ",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Consumer<LoginProvider>(
                        builder: (context, loginProvider, child) {
                          final isLoading = loginProvider.loginState == LoginState.loading;
                          
                          return GestureDetector(
                            onTap: (_canResend && !isLoading) ? _resendOtp : null,
                            child: Text(
                              _canResend && !isLoading
                                  ? 'Resend'
                                  : isLoading
                                      ? 'Sending...'
                                      : 'Resend in ${_resendCountdown}s',
                              style: TextStyle(
                                fontSize: 14,
                                color: (_canResend && !isLoading)
                                    ? const Color(0xFF1E88E5)
                                    : Colors.grey,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  
                  // Flexible spacer that adapts to content
                  const Expanded(child: SizedBox()),
                  
                  // Continue Button - Fixed at bottom
                  Consumer<LoginProvider>(
                    builder: (context, loginProvider, child) {
                      final isLoading = loginProvider.otpState == LoginState.loading;
                      final otpValue = _getOtpValue();
                      
                      return Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: (isLoading || otpValue.length != 4) ? null : _verifyOtp,
                            // Remove the hardcoded navigation - use proper OTP verification
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1E88E5),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 0,
                              disabledBackgroundColor: Colors.grey.shade400,
                            ),
                            child: isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                    ),
                                  )
                                : const Text(
                                    'Continue',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                          ),
                        ),
                      );
                    },
                  ),
                  
                  // Bottom spacing for safe area
                  SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}