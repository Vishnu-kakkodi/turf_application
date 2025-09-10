import 'package:booking_application/auth/otp_screen.dart';
import 'package:booking_application/auth/signup_screen.dart';
import 'package:booking_application/provider/login_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _mobileController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _mobileController.dispose();
    super.dispose();
  }

  String? _validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your mobile number';
    }
    if (value.length != 10) {
      return 'Mobile number must be 10 digits';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Please enter a valid mobile number';
    }
    return null;
  }

  // void _handleGetOTP() async {
  //   if (_formKey.currentState!.validate()) {
  //     final loginProvider = Provider.of<LoginProvider>(context, listen: false);
      
  //     final success = await loginProvider.loginWithMobile(_mobileController.text);
      
  //     if (success) {

     
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => OtpScreen(
  //             mobileNumber: _mobileController.text,
  //           ),
  //         ),
  //       );
  //     } else {
  //       // Show error message
  //       if (mounted) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text(loginProvider.errorMessage ?? 'Failed to send OTP'),
  //             backgroundColor: Colors.red,
  //           ),
  //         );
  //       }
  //     }
  //   }
  // }


  void _handleGetOTP() async {
  if (_formKey.currentState!.validate()) {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);

    final success = await loginProvider.loginWithMobile(_mobileController.text);

    if (success) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('OTP sent successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }

   
      await Future.delayed(const Duration(milliseconds: 500));

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtpScreen(
            mobileNumber: _mobileController.text,
          ),
        ),
      );
    } else {
      // Show error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(loginProvider.errorMessage ?? 'Failed to send OTP'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://m.media-amazon.com/images/I/71+ItnMjnQL.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Gradient overlay
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.6),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Login Title
                    const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Subtitle
                    const Text(
                      'Hey! Good to see you again',
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Mobile Number Label
                    const Text(
                      'Mobile Number',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Phone Number Input
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          // Country Code
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 16),
                            child: Row(
                              children: [
                                Icon(Icons.phone,
                                    color: Colors.grey.shade600, size: 20),
                                const SizedBox(width: 8),
                                Text(
                                  '+91',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Divider
                          Container(
                            height: 20,
                            width: 1,
                            color: Colors.grey.shade300,
                          ),

                          // Phone Number Field
                          Expanded(
                            child: TextFormField(
                              controller: _mobileController,
                              decoration: InputDecoration(
                                hintText: 'Enter your Mobile Number',
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 16,
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 16),
                                errorStyle: const TextStyle(fontSize: 0),
                              ),
                              keyboardType: TextInputType.phone,
                              maxLength: 10,
                              validator: _validateMobile,
                              buildCounter: (context, {required currentLength, required isFocused, maxLength}) => null,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Error message display
                    Consumer<LoginProvider>(
                      builder: (context, loginProvider, child) {
                        if (loginProvider.loginState == LoginState.error && 
                            loginProvider.errorMessage != null) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              loginProvider.errorMessage!,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),

                    const SizedBox(height: 20),

                    // Get OTP Button
                    Consumer<LoginProvider>(
                      builder: (context, loginProvider, child) {
                        final isLoading = loginProvider.loginState == LoginState.loading;
                        
                        return SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: isLoading ? null : _handleGetOTP,
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
                                    'Get OTP',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 20),

                    // Or Divider
                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.grey.shade300)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Or',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Expanded(child: Divider(color: Colors.grey.shade300)),
                      ],
                    ),

                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: IconButton(
                            onPressed: () {
                              // TODO: Implement Google login
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Google login coming soon!')),
                              );
                            },
                            icon: const FaIcon(
                              FontAwesomeIcons.google,
                              size: 20,
                            ),
                          ),
                        ),

                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: IconButton(
                            onPressed: () {
                              // TODO: Implement Twitter login
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Twitter login coming soon!')),
                              );
                            },
                            icon: const FaIcon(
                              FontAwesomeIcons.xTwitter,
                              color: Colors.black,
                              size: 20,
                            ),
                          ),
                        ),

                        // Facebook Login
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: IconButton(
                            onPressed: () {
                              // TODO: Implement Facebook login
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Facebook login coming soon!')),
                              );
                            },
                            icon: const FaIcon(
                              FontAwesomeIcons.facebookF,
                              color: Color(0xFF1877F2), // Facebook blue
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: "Don't have account? ",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(
                              text: 'Sign up',
                              style: const TextStyle(
                                color: Color(0xFF1E88E5),
                                fontWeight: FontWeight.w600,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => const SignupScreen()));
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}