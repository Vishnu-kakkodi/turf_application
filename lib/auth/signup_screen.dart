// import 'package:booking_application/auth/login_screen.dart';
// import 'package:booking_application/auth/otp_screen.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class SignupScreen extends StatelessWidget {
//   const SignupScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Background Image
//           Container(
//             width: double.infinity,
//             height: double.infinity,
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: NetworkImage(
//                     'https://media.istockphoto.com/id/171272361/photo/young-african-american-man-soccer-player.jpg?s=612x612&w=0&k=20&c=qRxLIyc8EFROkIjDe6KDN664Z-qmAoFuFnEvfFjt98g='), // You'll need to add this image to your assets
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),

//           // Gradient overlay
//           Container(
//             width: double.infinity,
//             height: double.infinity,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   Colors.black.withOpacity(0.3),
//                   Colors.black.withOpacity(0.6),
//                 ],
//               ),
//             ),
//           ),

//           // Status bar and back button
//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.pop(context);
//                         },
//                         child: const Icon(
//                           Icons.arrow_back,
//                           color: Colors.white,
//                           size: 24,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           // SignUp Card
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: Container(
//               padding: const EdgeInsets.all(24),
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(24),
//                   topRight: Radius.circular(24),
//                 ),
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // SignUp Title
//                   const Text(
//                     'SignUp',
//                     style: TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),

//                   const SizedBox(height: 24),

//                   // Name Field
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         'Name',
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.black87,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Container(
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.grey.shade300),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Row(
//                           children: [
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 12, vertical: 16),
//                               child: Icon(Icons.person_outline,
//                                   color: Colors.grey.shade600, size: 20),
//                             ),
//                             Expanded(
//                               child: TextField(
//                                 decoration: InputDecoration(
//                                   hintText: 'Enter your name',
//                                   hintStyle: TextStyle(
//                                     color: Colors.grey.shade500,
//                                     fontSize: 16,
//                                   ),
//                                   border: InputBorder.none,
//                                   contentPadding: const EdgeInsets.symmetric(
//                                       horizontal: 12, vertical: 16),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 20),

//                   // Mobile Number Field 1
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         'Mobile Number',
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.black87,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Container(
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.grey.shade300),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Row(
//                           children: [
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 12, vertical: 16),
//                               child: Icon(Icons.phone_outlined,
//                                   color: Colors.grey.shade600, size: 20),
//                             ),
//                             Expanded(
//                               child: TextField(
//                                 decoration: InputDecoration(
//                                   hintText: 'Enter your Mobile Number',
//                                   hintStyle: TextStyle(
//                                     color: Colors.grey.shade500,
//                                     fontSize: 16,
//                                   ),
//                                   border: InputBorder.none,
//                                   contentPadding: const EdgeInsets.symmetric(
//                                       horizontal: 12, vertical: 16),
//                                 ),
//                                 keyboardType: TextInputType.phone,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 20),

//                   // Mobile Number Field 2 (Confirmation)
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         'Email',
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.black87,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Container(
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.grey.shade300),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Row(
//                           children: [
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 12, vertical: 16),
//                               child: Icon(Icons.email,
//                                   color: Colors.grey.shade600, size: 20),
//                             ),
//                             Expanded(
//                               child: TextField(
//                                 decoration: InputDecoration(
//                                   hintText: 'Enter your Email',
//                                   hintStyle: TextStyle(
//                                     color: Colors.grey.shade500,
//                                     fontSize: 16,
//                                   ),
//                                   border: InputBorder.none,
//                                   contentPadding: const EdgeInsets.symmetric(
//                                       horizontal: 12, vertical: 16),
//                                 ),
//                                 keyboardType: TextInputType.phone,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 24),

//                   // Sign Up Button
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpScreen()));
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF1E88E5),
//                         foregroundColor: Colors.white,
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         elevation: 0,
//                       ),
//                       child: const Text(
//                         'Sign Up',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 20),

//                   // Or Divider
//                   Row(
//                     children: [
//                       Expanded(child: Divider(color: Colors.grey.shade300)),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 16),
//                         child: Text(
//                           'Or',
//                           style: TextStyle(
//                             color: Colors.grey.shade600,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ),
//                       Expanded(child: Divider(color: Colors.grey.shade300)),
//                     ],
//                   ),

//                   const SizedBox(height: 20),

//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Container(
//                         width: 50,
//                         height: 50,
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.grey.shade300),
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                         child: IconButton(
//                           onPressed: () {
//                             // Handle Google signup
//                           },
//                           icon: const FaIcon(
//                             FontAwesomeIcons.google,
//                             // color: Colors.red,
//                             size: 20,
//                           ),
//                         ),
//                       ),

//                       // X (Twitter) Login
//                       Container(
//                         width: 50,
//                         height: 50,
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.grey.shade300),
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                         child: IconButton(
//                           onPressed: () {
//                             // Handle X (Twitter) signup
//                           },
//                           icon: const FaIcon(
//                             FontAwesomeIcons.xTwitter,
//                             color: Colors.black,
//                             size: 20,
//                           ),
//                         ),
//                       ),

//                       // Facebook Login
//                       Container(
//                         width: 50,
//                         height: 50,
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.grey.shade300),
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                         child: IconButton(
//                           onPressed: () {
                            
//                           },
//                           icon: const FaIcon(
//                             FontAwesomeIcons.facebookF,
//                             color: Color(0xFF1877F2), // Facebook blue
//                             size: 20,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 20),
//                   Center(
//                     child: RichText(
//                       text: TextSpan(
//                         text: "Don't have account? ",
//                         style: TextStyle(
//                           color: Colors.grey.shade600,
//                           fontSize: 14,
//                         ),
//                         children: [
//                           TextSpan(
//                             text: 'Sign in',
//                             style: const TextStyle(
//                               color: Color(0xFF1E88E5),
//                               fontWeight: FontWeight.w600,
//                             ),
//                             recognizer: TapGestureRecognizer()
//                               ..onTap = () {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (_) => LoginScreen()));
//                               },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 20),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



// import 'dart:io';
// import 'package:booking_application/auth/login_screen.dart';
// import 'package:booking_application/auth/otp_screen.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:image_picker/image_picker.dart';

// class SignupScreen extends StatefulWidget {
//   const SignupScreen({super.key});

//   @override
//   State<SignupScreen> createState() => _SignupScreenState();
// }

// class _SignupScreenState extends State<SignupScreen> {
//   File? _selectedImage;
//   final ImagePicker _imagePicker = ImagePicker();

//   Future<void> _pickImageFromGallery() async {
//     try {
//       final XFile? pickedFile = await _imagePicker.pickImage(
//         source: ImageSource.gallery,
//         maxWidth: 800,
//         maxHeight: 800,
//         imageQuality: 85,
//       );
      
//       if (pickedFile != null) {
//         setState(() {
//           _selectedImage = File(pickedFile.path);
//         });
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error picking image: $e'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   void _showImagePickerOptions() {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder: (BuildContext context) {
//         return Container(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text(
//                 'Select Profile Picture',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.pop(context);
//                       _pickImageFromCamera();
//                     },
//                     child: Column(
//                       children: [
//                         Container(
//                           width: 60,
//                           height: 60,
//                           decoration: BoxDecoration(
//                             color: const Color(0xFF1E88E5),
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           child: const Icon(
//                             Icons.camera_alt,
//                             color: Colors.white,
//                             size: 30,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         const Text('Camera'),
//                       ],
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.pop(context);
//                       _pickImageFromGallery();
//                     },
//                     child: Column(
//                       children: [
//                         Container(
//                           width: 60,
//                           height: 60,
//                           decoration: BoxDecoration(
//                             color: const Color(0xFF1E88E5),
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           child: const Icon(
//                             Icons.photo_library,
//                             color: Colors.white,
//                             size: 30,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         const Text('Gallery'),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Future<void> _pickImageFromCamera() async {
//     try {
//       final XFile? pickedFile = await _imagePicker.pickImage(
//         source: ImageSource.camera,
//         maxWidth: 800,
//         maxHeight: 800,
//         imageQuality: 85,
//       );
      
//       if (pickedFile != null) {
//         setState(() {
//           _selectedImage = File(pickedFile.path);
//         });
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error taking photo: $e'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Background Image
//           Container(
//             width: double.infinity,
//             height: double.infinity,
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: NetworkImage(
//                     'https://media.istockphoto.com/id/171272361/photo/young-african-american-man-soccer-player.jpg?s=612x612&w=0&k=20&c=qRxLIyc8EFROkIjDe6KDN664Z-qmAoFuFnEvfFjt98g='),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),

//           // Gradient overlay
//           Container(
//             width: double.infinity,
//             height: double.infinity,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   Colors.black.withOpacity(0.3),
//                   Colors.black.withOpacity(0.6),
//                 ],
//               ),
//             ),
//           ),

//           // Status bar and back button
//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.pop(context);
//                         },
//                         child: const Icon(
//                           Icons.arrow_back,
//                           color: Colors.white,
//                           size: 24,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           // SignUp Card
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: Container(
//               padding: const EdgeInsets.all(24),
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(24),
//                   topRight: Radius.circular(24),
//                 ),
//               ),
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // SignUp Title
//                     const Text(
//                       'SignUp',
//                       style: TextStyle(
//                         fontSize: 28,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),

//                     const SizedBox(height: 20),

//                     // Profile Picture Section
//                     Center(
//                       child: Column(
//                         children: [
//                           GestureDetector(
//                             onTap: _showImagePickerOptions,
//                             child: Container(
//                               width: 100,
//                               height: 100,
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 border: Border.all(
//                                   color: const Color(0xFF1E88E5),
//                                   width: 3,
//                                 ),
//                                 color: Colors.grey.shade100,
//                               ),
//                               child: _selectedImage != null
//                                   ? ClipOval(
//                                       child: Image.file(
//                                         _selectedImage!,
//                                         width: 100,
//                                         height: 100,
//                                         fit: BoxFit.cover,
//                                       ),
//                                     )
//                                   : const Icon(
//                                       Icons.add_a_photo,
//                                       size: 40,
//                                       color: Color(0xFF1E88E5),
//                                     ),
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             _selectedImage != null ? 'Tap to change photo' : 'Add Profile Picture',
//                             style: TextStyle(
//                               color: Colors.grey.shade600,
//                               fontSize: 12,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),

//                     const SizedBox(height: 24),

//                     // Name Field
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           'Name',
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.black87,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         Container(
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.grey.shade300),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Row(
//                             children: [
//                               Container(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 12, vertical: 16),
//                                 child: Icon(Icons.person_outline,
//                                     color: Colors.grey.shade600, size: 20),
//                               ),
//                               Expanded(
//                                 child: TextField(
//                                   decoration: InputDecoration(
//                                     hintText: 'Enter your name',
//                                     hintStyle: TextStyle(
//                                       color: Colors.grey.shade500,
//                                       fontSize: 16,
//                                     ),
//                                     border: InputBorder.none,
//                                     contentPadding: const EdgeInsets.symmetric(
//                                         horizontal: 12, vertical: 16),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),

//                     const SizedBox(height: 20),

//                     // Mobile Number Field
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           'Mobile Number',
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.black87,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         Container(
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.grey.shade300),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Row(
//                             children: [
//                               Container(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 12, vertical: 16),
//                                 child: Icon(Icons.phone_outlined,
//                                     color: Colors.grey.shade600, size: 20),
//                               ),
//                               Expanded(
//                                 child: TextField(
//                                   decoration: InputDecoration(
//                                     hintText: 'Enter your Mobile Number',
//                                     hintStyle: TextStyle(
//                                       color: Colors.grey.shade500,
//                                       fontSize: 16,
//                                     ),
//                                     border: InputBorder.none,
//                                     contentPadding: const EdgeInsets.symmetric(
//                                         horizontal: 12, vertical: 16),
//                                   ),
//                                   keyboardType: TextInputType.phone,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),

//                     const SizedBox(height: 20),

//                     // Email Field
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           'Email',
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.black87,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         Container(
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.grey.shade300),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Row(
//                             children: [
//                               Container(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 12, vertical: 16),
//                                 child: Icon(Icons.email,
//                                     color: Colors.grey.shade600, size: 20),
//                               ),
//                               Expanded(
//                                 child: TextField(
//                                   decoration: InputDecoration(
//                                     hintText: 'Enter your Email',
//                                     hintStyle: TextStyle(
//                                       color: Colors.grey.shade500,
//                                       fontSize: 16,
//                                     ),
//                                     border: InputBorder.none,
//                                     contentPadding: const EdgeInsets.symmetric(
//                                         horizontal: 12, vertical: 16),
//                                   ),
//                                   keyboardType: TextInputType.emailAddress,
//                                 ),
//                               ),
                              
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),

//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           'Password',
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.black87,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         Container(
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.grey.shade300),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Row(
//                             children: [
//                               Container(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 12, vertical: 16),
//                                 child: Icon(Icons.password,
//                                     color: Colors.grey.shade600, size: 20),
//                               ),
//                               Expanded(
//                                 child: TextField(
//                                   decoration: InputDecoration(
//                                     hintText: 'Password',
//                                     hintStyle: TextStyle(
//                                       color: Colors.grey.shade500,
//                                       fontSize: 16,
//                                     ),
//                                     border: InputBorder.none,
//                                     contentPadding: const EdgeInsets.symmetric(
//                                         horizontal: 12, vertical: 16),
//                                   ),
//                                   keyboardType: TextInputType.emailAddress,
//                                 ),
//                               ),
                              
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),


//                     const SizedBox(height: 24),

//                     // Sign Up Button
//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpScreen()));
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(0xFF1E88E5),
//                           foregroundColor: Colors.white,
//                           padding: const EdgeInsets.symmetric(vertical: 16),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           elevation: 0,
//                         ),
//                         child: const Text(
//                           'Sign Up',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: 20),

//                     // Or Divider
//                     Row(
//                       children: [
//                         Expanded(child: Divider(color: Colors.grey.shade300)),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 16),
//                           child: Text(
//                             'Or',
//                             style: TextStyle(
//                               color: Colors.grey.shade600,
//                               fontSize: 14,
//                             ),
//                           ),
//                         ),
//                         Expanded(child: Divider(color: Colors.grey.shade300)),
//                       ],
//                     ),

//                     const SizedBox(height: 20),

//                     // Social Media Login Buttons
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Container(
//                           width: 50,
//                           height: 50,
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.grey.shade300),
//                             borderRadius: BorderRadius.circular(25),
//                           ),
//                           child: IconButton(
//                             onPressed: () {
//                               // Handle Google signup
//                             },
//                             icon: const FaIcon(
//                               FontAwesomeIcons.google,
//                               size: 20,
//                             ),
//                           ),
//                         ),

//                         // X (Twitter) Login
//                         Container(
//                           width: 50,
//                           height: 50,
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.grey.shade300),
//                             borderRadius: BorderRadius.circular(25),
//                           ),
//                           child: IconButton(
//                             onPressed: () {
//                               // Handle X (Twitter) signup
//                             },
//                             icon: const FaIcon(
//                               FontAwesomeIcons.xTwitter,
//                               color: Colors.black,
//                               size: 20,
//                             ),
//                           ),
//                         ),

//                         // Facebook Login
//                         Container(
//                           width: 50,
//                           height: 50,
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.grey.shade300),
//                             borderRadius: BorderRadius.circular(25),
//                           ),
//                           child: IconButton(
//                             onPressed: () {
//                               // Handle Facebook signup
//                             },
//                             icon: const FaIcon(
//                               FontAwesomeIcons.facebookF,
//                               color: Color(0xFF1877F2), // Facebook blue
//                               size: 20,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),

//                     const SizedBox(height: 20),
//                     Center(
//                       child: RichText(
//                         text: TextSpan(
//                           text: "Already have an account? ",
//                           style: TextStyle(
//                             color: Colors.grey.shade600,
//                             fontSize: 14,
//                           ),
//                           children: [
//                             TextSpan(
//                               text: 'Sign in',
//                               style: const TextStyle(
//                                 color: Color(0xFF1E88E5),
//                                 fontWeight: FontWeight.w600,
//                               ),
//                               recognizer: TapGestureRecognizer()
//                                 ..onTap = () {
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (_) => LoginScreen()));
//                                 },
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: 20),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }














// import 'dart:io';
// import 'package:booking_application/auth/login_screen.dart';
// import 'package:booking_application/auth/otp_screen.dart';
// import 'package:booking_application/provider/registration_provider.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';

// class SignupScreen extends StatefulWidget {
//   const SignupScreen({super.key});

//   @override
//   State<SignupScreen> createState() => _SignupScreenState();
// }

// class _SignupScreenState extends State<SignupScreen> {
//   File? _selectedImage;
//   final ImagePicker _imagePicker = ImagePicker();

//   @override
//   void initState() {
//     super.initState();
//     // Clear any previous data when screen loads
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<RegistrationProvider>().clearForm();
//       context.read<RegistrationProvider>().clearMessages();
//     });
//   }

//   Future<void> _pickImageFromGallery() async {
//     try {
//       final XFile? pickedFile = await _imagePicker.pickImage(
//         source: ImageSource.gallery,
//         maxWidth: 800,
//         maxHeight: 800,
//         imageQuality: 85,
//       );
      
//       if (pickedFile != null) {
//         setState(() {
//           _selectedImage = File(pickedFile.path);
//         });
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error picking image: $e'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   void _showImagePickerOptions() {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder: (BuildContext context) {
//         return Container(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text(
//                 'Select Profile Picture',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.pop(context);
//                       _pickImageFromCamera();
//                     },
//                     child: Column(
//                       children: [
//                         Container(
//                           width: 60,
//                           height: 60,
//                           decoration: BoxDecoration(
//                             color: const Color(0xFF1E88E5),
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           child: const Icon(
//                             Icons.camera_alt,
//                             color: Colors.white,
//                             size: 30,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         const Text('Camera'),
//                       ],
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.pop(context);
//                       _pickImageFromGallery();
//                     },
//                     child: Column(
//                       children: [
//                         Container(
//                           width: 60,
//                           height: 60,
//                           decoration: BoxDecoration(
//                             color: const Color(0xFF1E88E5),
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           child: const Icon(
//                             Icons.photo_library,
//                             color: Colors.white,
//                             size: 30,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         const Text('Gallery'),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Future<void> _pickImageFromCamera() async {
//     try {
//       final XFile? pickedFile = await _imagePicker.pickImage(
//         source: ImageSource.camera,
//         maxWidth: 800,
//         maxHeight: 800,
//         imageQuality: 85,
//       );
      
//       if (pickedFile != null) {
//         setState(() {
//           _selectedImage = File(pickedFile.path);
//         });
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error taking photo: $e'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   Future<void> _handleSignUp() async {
//     final provider = context.read<RegistrationProvider>();
    
//     // Clear previous messages
//     provider.clearMessages();
    
//     final success = await provider.registerUser();
    
//     if (success && mounted) {
//       // Show success message
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(provider.successMessage ?? 'Registration successful!'),
//           backgroundColor: Colors.green,
//           duration: const Duration(seconds: 2),
//         ),
//       );
      
//       // Navigate to OTP screen after a short delay
//       await Future.delayed(const Duration(seconds: 1));
//       if (mounted) {
//         Navigator.push(
//           context, 
//           MaterialPageRoute(builder: (context) => OtpScreen())
//         );
//       }
//     } else if (mounted) {
//       // Show error message if registration failed
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(provider.errorMessage ?? 'Registration failed'),
//           backgroundColor: Colors.red,
//           duration: const Duration(seconds: 3),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Consumer<RegistrationProvider>(
//         builder: (context, provider, child) {
//           return Stack(
//             children: [
//               // Background Image
//               Container(
//                 width: double.infinity,
//                 height: double.infinity,
//                 decoration: const BoxDecoration(
//                   image: DecorationImage(
//                     image: NetworkImage(
//                         'https://media.istockphoto.com/id/171272361/photo/young-african-american-man-soccer-player.jpg?s=612x612&w=0&k=20&c=qRxLIyc8EFROkIjDe6KDN664Z-qmAoFuFnEvfFjt98g='),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),

//               // Gradient overlay
//               Container(
//                 width: double.infinity,
//                 height: double.infinity,
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     colors: [
//                       Colors.black.withOpacity(0.3),
//                       Colors.black.withOpacity(0.6),
//                     ],
//                   ),
//                 ),
//               ),

//               // Status bar and back button
//               SafeArea(
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.pop(context);
//                             },
//                             child: const Icon(
//                               Icons.arrow_back,
//                               color: Colors.white,
//                               size: 24,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               // SignUp Card
//               Positioned(
//                 bottom: 0,
//                 left: 0,
//                 right: 0,
//                 child: Container(
//                   padding: const EdgeInsets.all(24),
//                   decoration: const BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(24),
//                       topRight: Radius.circular(24),
//                     ),
//                   ),
//                   child: SingleChildScrollView(
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // SignUp Title
//                         const Text(
//                           'SignUp',
//                           style: TextStyle(
//                             fontSize: 28,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black,
//                           ),
//                         ),

//                         const SizedBox(height: 20),

//                         // Profile Picture Section
//                         Center(
//                           child: Column(
//                             children: [
//                               GestureDetector(
//                                 onTap: _showImagePickerOptions,
//                                 child: Container(
//                                   width: 100,
//                                   height: 100,
//                                   decoration: BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     border: Border.all(
//                                       color: const Color(0xFF1E88E5),
//                                       width: 3,
//                                     ),
//                                     color: Colors.grey.shade100,
//                                   ),
//                                   child: _selectedImage != null
//                                       ? ClipOval(
//                                           child: Image.file(
//                                             _selectedImage!,
//                                             width: 100,
//                                             height: 100,
//                                             fit: BoxFit.cover,
//                                           ),
//                                         )
//                                       : const Icon(
//                                           Icons.add_a_photo,
//                                           size: 40,
//                                           color: Color(0xFF1E88E5),
//                                         ),
//                                 ),
//                               ),
//                               const SizedBox(height: 8),
//                               Text(
//                                 _selectedImage != null ? 'Tap to change photo' : 'Add Profile Picture',
//                                 style: TextStyle(
//                                   color: Colors.grey.shade600,
//                                   fontSize: 12,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),

//                         const SizedBox(height: 24),

//                         // Name Field
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text(
//                               'Name',
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.black87,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             Container(
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                   color: provider.hasError('name') 
//                                     ? Colors.red 
//                                     : Colors.grey.shade300
//                                 ),
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: Row(
//                                 children: [
//                                   Container(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 12, vertical: 16),
//                                     child: Icon(Icons.person_outline,
//                                         color: Colors.grey.shade600, size: 20),
//                                   ),
//                                   Expanded(
//                                     child: TextField(
//                                       controller: provider.nameController,
//                                       decoration: InputDecoration(
//                                         hintText: 'Enter your name',
//                                         hintStyle: TextStyle(
//                                           color: Colors.grey.shade500,
//                                           fontSize: 16,
//                                         ),
//                                         border: InputBorder.none,
//                                         contentPadding: const EdgeInsets.symmetric(
//                                             horizontal: 12, vertical: 16),
//                                       ),
//                                       onChanged: (value) {
//                                         if (provider.hasError('name')) {
//                                           provider.clearValidationErrors();
//                                         }
//                                       },
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             // Error message for name
//                             if (provider.hasError('name'))
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 4),
//                                 child: Text(
//                                   provider.getValidationError('name')!,
//                                   style: const TextStyle(
//                                     color: Colors.red,
//                                     fontSize: 12,
//                                   ),
//                                 ),
//                               ),
//                           ],
//                         ),

//                         const SizedBox(height: 20),

//                         // Mobile Number Field
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text(
//                               'Mobile Number',
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.black87,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             Container(
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                   color: provider.hasError('mobile') 
//                                     ? Colors.red 
//                                     : Colors.grey.shade300
//                                 ),
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: Row(
//                                 children: [
//                                   Container(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 12, vertical: 16),
//                                     child: Icon(Icons.phone_outlined,
//                                         color: Colors.grey.shade600, size: 20),
//                                   ),
//                                   Expanded(
//                                     child: TextField(
//                                       controller: provider.mobileController,
//                                       decoration: InputDecoration(
//                                         hintText: 'Enter your Mobile Number',
//                                         hintStyle: TextStyle(
//                                           color: Colors.grey.shade500,
//                                           fontSize: 16,
//                                         ),
//                                         border: InputBorder.none,
//                                         contentPadding: const EdgeInsets.symmetric(
//                                             horizontal: 12, vertical: 16),
//                                       ),
//                                       keyboardType: TextInputType.phone,
//                                       onChanged: (value) {
//                                         if (provider.hasError('mobile')) {
//                                           provider.clearValidationErrors();
//                                         }
//                                       },
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             // Error message for mobile
//                             if (provider.hasError('mobile'))
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 4),
//                                 child: Text(
//                                   provider.getValidationError('mobile')!,
//                                   style: const TextStyle(
//                                     color: Colors.red,
//                                     fontSize: 12,
//                                   ),
//                                 ),
//                               ),
//                           ],
//                         ),

//                         const SizedBox(height: 20),

//                         // Email Field
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text(
//                               'Email',
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.black87,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             Container(
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                   color: provider.hasError('email') 
//                                     ? Colors.red 
//                                     : Colors.grey.shade300
//                                 ),
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: Row(
//                                 children: [
//                                   Container(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 12, vertical: 16),
//                                     child: Icon(Icons.email,
//                                         color: Colors.grey.shade600, size: 20),
//                                   ),
//                                   Expanded(
//                                     child: TextField(
//                                       controller: provider.emailController,
//                                       decoration: InputDecoration(
//                                         hintText: 'Enter your Email',
//                                         hintStyle: TextStyle(
//                                           color: Colors.grey.shade500,
//                                           fontSize: 16,
//                                         ),
//                                         border: InputBorder.none,
//                                         contentPadding: const EdgeInsets.symmetric(
//                                             horizontal: 12, vertical: 16),
//                                       ),
//                                       keyboardType: TextInputType.emailAddress,
//                                       onChanged: (value) {
//                                         if (provider.hasError('email')) {
//                                           provider.clearValidationErrors();
//                                         }
//                                       },
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             // Error message for email
//                             if (provider.hasError('email'))
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 4),
//                                 child: Text(
//                                   provider.getValidationError('email')!,
//                                   style: const TextStyle(
//                                     color: Colors.red,
//                                     fontSize: 12,
//                                   ),
//                                 ),
//                               ),
//                           ],
//                         ),

//                         const SizedBox(height: 20),

//                         // Password Field
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text(
//                               'Password',
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.black87,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             Container(
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                   color: provider.hasError('password') 
//                                     ? Colors.red 
//                                     : Colors.grey.shade300
//                                 ),
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: Row(
//                                 children: [
//                                   Container(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 12, vertical: 16),
//                                     child: Icon(Icons.lock_outline,
//                                         color: Colors.grey.shade600, size: 20),
//                                   ),
//                                   Expanded(
//                                     child: TextField(
//                                       controller: provider.passwordController,
//                                       obscureText: !provider.isPasswordVisible,
//                                       decoration: InputDecoration(
//                                         hintText: 'Enter your password',
//                                         hintStyle: TextStyle(
//                                           color: Colors.grey.shade500,
//                                           fontSize: 16,
//                                         ),
//                                         border: InputBorder.none,
//                                         contentPadding: const EdgeInsets.symmetric(
//                                             horizontal: 12, vertical: 16),
//                                       ),
//                                       onChanged: (value) {
//                                         if (provider.hasError('password')) {
//                                           provider.clearValidationErrors();
//                                         }
//                                       },
//                                     ),
//                                   ),
//                                   IconButton(
//                                     onPressed: provider.togglePasswordVisibility,
//                                     icon: Icon(
//                                       provider.isPasswordVisible 
//                                         ? Icons.visibility 
//                                         : Icons.visibility_off,
//                                       color: Colors.grey.shade600,
//                                       size: 20,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             // Error message for password
//                             if (provider.hasError('password'))
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 4),
//                                 child: Text(
//                                   provider.getValidationError('password')!,
//                                   style: const TextStyle(
//                                     color: Colors.red,
//                                     fontSize: 12,
//                                   ),
//                                 ),
//                               ),
//                           ],
//                         ),

//                         const SizedBox(height: 24),

//                         // Sign Up Button
//                         SizedBox(
//                           width: double.infinity,
//                           child: ElevatedButton(
//                             onPressed: provider.isLoading ? null : _handleSignUp,
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: const Color(0xFF1E88E5),
//                               foregroundColor: Colors.white,
//                               padding: const EdgeInsets.symmetric(vertical: 16),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               elevation: 0,
//                             ),
//                             child: provider.isLoading 
//                               ? const Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     SizedBox(
//                                       width: 20,
//                                       height: 20,
//                                       child: CircularProgressIndicator(
//                                         strokeWidth: 2,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                     SizedBox(width: 12),
//                                     Text(
//                                       'Signing Up...',
//                                       style: TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                   ],
//                                 )
//                               : const Text(
//                                   'Sign Up',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                           ),
//                         ),

//                         const SizedBox(height: 20),

//                         // Or Divider
//                         Row(
//                           children: [
//                             Expanded(child: Divider(color: Colors.grey.shade300)),
//                             Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 16),
//                               child: Text(
//                                 'Or',
//                                 style: TextStyle(
//                                   color: Colors.grey.shade600,
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ),
//                             Expanded(child: Divider(color: Colors.grey.shade300)),
//                           ],
//                         ),

//                         const SizedBox(height: 20),

//                         // Social Media Login Buttons
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Container(
//                               width: 50,
//                               height: 50,
//                               decoration: BoxDecoration(
//                                 border: Border.all(color: Colors.grey.shade300),
//                                 borderRadius: BorderRadius.circular(25),
//                               ),
//                               child: IconButton(
//                                 onPressed: () {
//                                   // Handle Google signup
//                                 },
//                                 icon: const FaIcon(
//                                   FontAwesomeIcons.google,
//                                   size: 20,
//                                 ),
//                               ),
//                             ),

//                             // X (Twitter) Login
//                             Container(
//                               width: 50,
//                               height: 50,
//                               decoration: BoxDecoration(
//                                 border: Border.all(color: Colors.grey.shade300),
//                                 borderRadius: BorderRadius.circular(25),
//                               ),
//                               child: IconButton(
//                                 onPressed: () {
//                                   // Handle X (Twitter) signup
//                                 },
//                                 icon: const FaIcon(
//                                   FontAwesomeIcons.xTwitter,
//                                   color: Colors.black,
//                                   size: 20,
//                                 ),
//                               ),
//                             ),

//                             // Facebook Login
//                             Container(
//                               width: 50,
//                               height: 50,
//                               decoration: BoxDecoration(
//                                 border: Border.all(color: Colors.grey.shade300),
//                                 borderRadius: BorderRadius.circular(25),
//                               ),
//                               child: IconButton(
//                                 onPressed: () {
//                                   // Handle Facebook signup
//                                 },
//                                 icon: const FaIcon(
//                                   FontAwesomeIcons.facebookF,
//                                   color: Color(0xFF1877F2), // Facebook blue
//                                   size: 20,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),

//                         const SizedBox(height: 20),
//                         Center(
//                           child: RichText(
//                             text: TextSpan(
//                               text: "Already have an account? ",
//                               style: TextStyle(
//                                 color: Colors.grey.shade600,
//                                 fontSize: 14,
//                               ),
//                               children: [
//                                 TextSpan(
//                                   text: 'Sign in',
//                                   style: const TextStyle(
//                                     color: Color(0xFF1E88E5),
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                   recognizer: TapGestureRecognizer()
//                                     ..onTap = () {
//                                       Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (_) => LoginScreen()));
//                                     },
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),

//                         const SizedBox(height: 20),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }



















import 'dart:io';
import 'package:booking_application/auth/login_screen.dart';
import 'package:booking_application/auth/otp_screen.dart';
import 'package:booking_application/provider/registration_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  File? _selectedImage;
  final ImagePicker _imagePicker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Clear any previous data when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RegistrationProvider>().clearForm();
      context.read<RegistrationProvider>().clearMessages();
    });
  }

  Future<void> _pickImageFromGallery() async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );
      
      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking image: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Select Profile Picture',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      _pickImageFromCamera();
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E88E5),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text('Camera'),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      _pickImageFromGallery();
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E88E5),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Icon(
                            Icons.photo_library,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text('Gallery'),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImageFromCamera() async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );
      
      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error taking photo: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _handleSignUp() async {
    final provider = context.read<RegistrationProvider>();
    
    if (!_formKey.currentState!.validate()) {
      return;
    }
    
    // Clear previous messages
    provider.clearMessages();
    
    final success = await provider.registerUser();
    
    if (success && mounted) {
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(provider.successMessage ?? 'Registration successful!'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
      
      // Navigate to OTP screen after a short delay
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => const LoginScreen())
        );
      }
      // if (mounted) {
      //   Navigator.push(
      //     context, 
      //     MaterialPageRoute(builder: (context) => const OtpScreen())
      //   );
      // }
    } else if (mounted) {
      // Show error message if registration failed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(provider.errorMessage ?? 'Registration failed'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Consumer<RegistrationProvider>(
        builder: (context, provider, child) {
          return Stack(
            children: [
              // Background Image
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://media.istockphoto.com/id/171272361/photo/young-african-american-man-soccer-player.jpg?s=612x612&w=0&k=20&c=qRxLIyc8EFROkIjDe6KDN664Z-qmAoFuFnEvfFjt98g='),
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

              // Status bar and back button
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

              // SignUp Card
              Positioned.fill(
                child: DraggableScrollableSheet(
                  initialChildSize: 0.7,
                  minChildSize: 0.5,
                  maxChildSize: 0.9,
                  builder: (context, scrollController) {
                    return Container(
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
                        child: SingleChildScrollView(
                          controller: scrollController,
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // SignUp Title
                              const Text(
                                'SignUp',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),

                              const SizedBox(height: 20),

                              // Profile Picture Section
                              Center(
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: _showImagePickerOptions,
                                      child: Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: const Color(0xFF1E88E5),
                                            width: 3,
                                          ),
                                          color: Colors.grey.shade100,
                                        ),
                                        child: _selectedImage != null
                                            ? ClipOval(
                                                child: Image.file(
                                                  _selectedImage!,
                                                  width: 100,
                                                  height: 100,
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                            : const Icon(
                                                Icons.add_a_photo,
                                                size: 40,
                                                color: Color(0xFF1E88E5),
                                              ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      _selectedImage != null ? 'Tap to change photo' : 'Add Profile Picture',
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 24),

                              // Name Field
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Name',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: provider.hasError('name') 
                                          ? Colors.red 
                                          : Colors.grey.shade300
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 16),
                                          child: Icon(Icons.person_outline,
                                              color: Colors.grey.shade600, size: 20),
                                        ),
                                        Expanded(
                                          child: TextFormField(
                                            controller: provider.nameController,
                                            decoration: InputDecoration(
                                              hintText: 'Enter your name',
                                              hintStyle: TextStyle(
                                                color: Colors.grey.shade500,
                                                fontSize: 16,
                                              ),
                                              border: InputBorder.none,
                                              contentPadding: const EdgeInsets.symmetric(
                                                  horizontal: 12, vertical: 16),
                                            ),
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'Please enter your name';
                                              }
                                              return null;
                                            },
                                            onChanged: (value) {
                                              if (provider.hasError('name')) {
                                                provider.clearValidationErrors();
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Error message for name
                                  if (provider.hasError('name'))
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Text(
                                        provider.getValidationError('name')!,
                                        style: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                ],
                              ),

                              const SizedBox(height: 20),

                              // Mobile Number Field
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Mobile Number',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: provider.hasError('mobile') 
                                          ? Colors.red 
                                          : Colors.grey.shade300
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 16),
                                          child: Icon(Icons.phone_outlined,
                                              color: Colors.grey.shade600, size: 20),
                                        ),
                                        Expanded(
                                          child: TextFormField(
                                            controller: provider.mobileController,
                                            decoration: InputDecoration(
                                              hintText: 'Enter your Mobile Number',
                                              hintStyle: TextStyle(
                                                color: Colors.grey.shade500,
                                                fontSize: 16,
                                              ),
                                              border: InputBorder.none,
                                              contentPadding: const EdgeInsets.symmetric(
                                                  horizontal: 12, vertical: 16),
                                            ),
                                            keyboardType: TextInputType.phone,
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'Please enter your mobile number';
                                              }
                                              if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                                                return 'Please enter a valid 10-digit mobile number';
                                              }
                                              return null;
                                            },
                                            onChanged: (value) {
                                              if (provider.hasError('mobile')) {
                                                provider.clearValidationErrors();
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Error message for mobile
                                  if (provider.hasError('mobile'))
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Text(
                                        provider.getValidationError('mobile')!,
                                        style: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                ],
                              ),

                              const SizedBox(height: 20),

                              // Email Field
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Email',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: provider.hasError('email') 
                                          ? Colors.red 
                                          : Colors.grey.shade300
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 16),
                                          child: Icon(Icons.email,
                                              color: Colors.grey.shade600, size: 20),
                                        ),
                                        Expanded(
                                          child: TextFormField(
                                            controller: provider.emailController,
                                            decoration: InputDecoration(
                                              hintText: 'Enter your Email',
                                              hintStyle: TextStyle(
                                                color: Colors.grey.shade500,
                                                fontSize: 16,
                                              ),
                                              border: InputBorder.none,
                                              contentPadding: const EdgeInsets.symmetric(
                                                  horizontal: 12, vertical: 16),
                                            ),
                                            keyboardType: TextInputType.emailAddress,
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'Please enter your email';
                                              }
                                              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                                  .hasMatch(value)) {
                                                return 'Please enter a valid email address';
                                              }
                                              return null;
                                            },
                                            onChanged: (value) {
                                              if (provider.hasError('email')) {
                                                provider.clearValidationErrors();
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Error message for email
                                  if (provider.hasError('email'))
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Text(
                                        provider.getValidationError('email')!,
                                        style: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                ],
                              ),

                              const SizedBox(height: 20),

                              // Password Field
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Password',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: provider.hasError('password') 
                                          ? Colors.red 
                                          : Colors.grey.shade300
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 16),
                                          child: Icon(Icons.lock_outline,
                                              color: Colors.grey.shade600, size: 20),
                                        ),
                                        Expanded(
                                          child: TextFormField(
                                            controller: provider.passwordController,
                                            obscureText: !provider.isPasswordVisible,
                                            decoration: InputDecoration(
                                              hintText: 'Enter your password',
                                              hintStyle: TextStyle(
                                                color: Colors.grey.shade500,
                                                fontSize: 16,
                                              ),
                                              border: InputBorder.none,
                                              contentPadding: const EdgeInsets.symmetric(
                                                  horizontal: 12, vertical: 16),
                                            ),
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'Please enter your password';
                                              }
                                              if (value.length < 6) {
                                                return 'Password must be at least 6 characters';
                                              }
                                              return null;
                                            },
                                            onChanged: (value) {
                                              if (provider.hasError('password')) {
                                                provider.clearValidationErrors();
                                              }
                                            },
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: provider.togglePasswordVisibility,
                                          icon: Icon(
                                            provider.isPasswordVisible 
                                              ? Icons.visibility 
                                              : Icons.visibility_off,
                                            color: Colors.grey.shade600,
                                            size: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Error message for password
                                  if (provider.hasError('password'))
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Text(
                                        provider.getValidationError('password')!,
                                        style: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                ],
                              ),

                              const SizedBox(height: 24),

                              // Sign Up Button
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: provider.isLoading ? null : _handleSignUp,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF1E88E5),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: provider.isLoading 
                                    ? const Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(width: 12),
                                          Text(
                                            'Signing Up...',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      )
                                    : const Text(
                                        'Sign Up',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                ),
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

                              // Social Media Login Buttons
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
                                        // Handle Google signup
                                      },
                                      icon: const FaIcon(
                                        FontAwesomeIcons.google,
                                        size: 20,
                                      ),
                                    ),
                                  ),

                                  // X (Twitter) Login
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey.shade300),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        // Handle X (Twitter) signup
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
                                        // Handle Facebook signup
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
                                    text: "Already have an account? ",
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 14,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Sign in',
                                        style: const TextStyle(
                                          color: Color(0xFF1E88E5),
                                          fontWeight: FontWeight.w600,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) => const LoginScreen()));
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
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}