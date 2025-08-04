// import 'package:booking_application/home/navbar_screen.dart';
// import 'package:booking_application/provider/user_details_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class Adddetails extends StatefulWidget {
//   const Adddetails({super.key});

//   @override
//   State<Adddetails> createState() => _AdddetailsState();
// }

// class _AdddetailsState extends State<Adddetails> {
//   String? _selectedGender;
//   final List<String> _genderOptions = ['Male', 'Female', 'Other'];

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<UserDetailsProvider>().clearForm();
//     });
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)), // Default to 18 years ago
//       firstDate: DateTime(1900),
//       lastDate: DateTime.now(),
//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: const ColorScheme.light(
//               primary: Color(0xFF1E88E5),
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );
//     if (picked != null) {
//       setState(() {
//         final provider = context.read<UserDetailsProvider>();
//         // Format date as YYYY-MM-DD for API
//         provider.dobController.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
//       });
//     }
//   }

//   Future<void> _handleContinue() async {
//     final provider = context.read<UserDetailsProvider>();
    
//     // Set gender in the provider
//     provider.genderController.text = _selectedGender ?? '';

//     // Validate all fields
//     bool isValid = true;
//     String errorMessage = '';

//     if (provider.cityController.text.trim().isEmpty) {
//       errorMessage = 'Please enter your city';
//       isValid = false;
//     } else if (_selectedGender == null || _selectedGender!.isEmpty) {
//       errorMessage = 'Please select your gender';
//       isValid = false;
//     } else if (provider.dobController.text.trim().isEmpty) {
//       errorMessage = 'Please select your date of birth';
//       isValid = false;
//     }

//     if (!isValid) {
//       _showErrorSnackBar(errorMessage);
//       return;
//     }

//     // Show loading dialog
//     _showLoadingDialog();

//     try {
//       // Update user profile
//       final success = await provider.updateUserProfile();
      
//       // Hide loading dialog
//       if (mounted) Navigator.of(context).pop();

//       if (success) {
//         // Show success message
//         _showSuccessSnackBar('Profile updated successfully!');
        
//         // Navigate to navbar screen after a short delay
//         // await Future.delayed(const Duration(milliseconds: 1500));
//         if (mounted) {
//           Navigator.pushAndRemoveUntil(
//             context,
//             MaterialPageRoute(builder: (context) => const NavbarScreen()),
//             (route) => false,
//           );
//         }
//       } else {
//         // Show error message
//         _showErrorSnackBar(provider.errorMessage ?? 'Failed to update profile');
//       }
//     } catch (e) {
//       // Hide loading dialog
//       if (mounted) Navigator.of(context).pop();
//       _showErrorSnackBar('An error occurred. Please try again.');
//     }
//   }

//   void _showLoadingDialog() {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return const AlertDialog(
//           content: Row(
//             children: [
//               CircularProgressIndicator(),
//               SizedBox(width: 20),
//               Text('Updating profile...'),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   void _showErrorSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: Colors.red,
//         behavior: SnackBarBehavior.floating,
//       ),
//     );
//   }

//   void _showSuccessSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: Colors.green,
//         behavior: SnackBarBehavior.floating,
//       ),
//     );
//   }

//   String _formatDateForDisplay(String apiDate) {
//     if (apiDate.isEmpty) return '';
//     try {
//       final date = DateTime.parse(apiDate);
//       return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
//     } catch (e) {
//       return apiDate;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Consumer<UserDetailsProvider>(
//         builder: (context, provider, child) {
//           return Stack(
//             children: [
//               // Background Image - Stadium
//               Container(
//                 width: double.infinity,
//                 height: double.infinity,
//                 decoration: const BoxDecoration(
//                   image: DecorationImage(
//                     image: NetworkImage('https://media.istockphoto.com/id/1176722220/photo/empty-green-grass-field-and-illuminated-outdoor-stadium-with-fans-front-field-view.jpg?s=612x612&w=0&k=20&c=YFh_7QVyJKuF9iBFgX4QF9c4-ojJE0_vCJjeORQExX4='),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
              
//               // Dark gradient overlay
//               Container(
//                 width: double.infinity,
//                 height: double.infinity,
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     colors: [
//                       const Color(0xFF1a237e).withOpacity(0.8),
//                       const Color(0xFF000051).withOpacity(0.9),
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
//                           const SizedBox(width: 20),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
              
//               // Form Card
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
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // City Field
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             'Where do you live?',
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.black87,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Container(
//                             decoration: BoxDecoration(
//                               color: Colors.grey.shade50,
//                               borderRadius: BorderRadius.circular(8),
//                               border: Border.all(color: Colors.grey.shade200),
//                             ),
//                             child: TextField(
//                               controller: provider.cityController,
//                               decoration: InputDecoration(
//                                 hintText: 'Enter your City',
//                                 hintStyle: TextStyle(
//                                   color: Colors.grey.shade500,
//                                   fontSize: 16,
//                                 ),
//                                 border: InputBorder.none,
//                                 contentPadding: const EdgeInsets.symmetric(
//                                   horizontal: 16, 
//                                   vertical: 16,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
                      
//                       const SizedBox(height: 20),
                      
//                       // Gender Field
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             'Select your Gender',
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.black87,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Container(
//                             width: double.infinity,
//                             decoration: BoxDecoration(
//                               color: Colors.grey.shade50,
//                               borderRadius: BorderRadius.circular(8),
//                               border: Border.all(color: Colors.grey.shade200),
//                             ),
//                             child: DropdownButtonHideUnderline(
//                               child: DropdownButton<String>(
//                                 value: _selectedGender,
//                                 hint: Padding(
//                                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                                   child: Text(
//                                     'Select gender',
//                                     style: TextStyle(
//                                       color: Colors.grey.shade500,
//                                       fontSize: 16,
//                                     ),
//                                   ),
//                                 ),
//                                 icon: Padding(
//                                   padding: const EdgeInsets.only(right: 16),
//                                   child: Icon(
//                                     Icons.keyboard_arrow_down,
//                                     color: Colors.grey.shade600,
//                                   ),
//                                 ),
//                                 isExpanded: true,
//                                 items: _genderOptions.map((String value) {
//                                   return DropdownMenuItem<String>(
//                                     value: value,
//                                     child: Padding(
//                                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                                       child: Text(
//                                         value,
//                                         style: const TextStyle(
//                                           fontSize: 16,
//                                           color: Colors.black87,
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                 }).toList(),
//                                 onChanged: (String? newValue) {
//                                   setState(() {
//                                     _selectedGender = newValue;
//                                   });
//                                 },
//                                 dropdownColor: Colors.white,
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
                      
//                       const SizedBox(height: 20),
                      
//                       // Date of Birth Field
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             'Enter your Date of Birth',
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.black87,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Container(
//                             decoration: BoxDecoration(
//                               color: Colors.grey.shade50,
//                               borderRadius: BorderRadius.circular(8),
//                               border: Border.all(color: Colors.grey.shade200),
//                             ),
//                             child: GestureDetector(
//                               onTap: () => _selectDate(context),
//                               child: Container(
//                                 width: double.infinity,
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 16, 
//                                   vertical: 16,
//                                 ),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       provider.dobController.text.isNotEmpty 
//                                         ? _formatDateForDisplay(provider.dobController.text)
//                                         : 'DD/MM/YYYY',
//                                       style: TextStyle(
//                                         color: provider.dobController.text.isNotEmpty 
//                                           ? Colors.black87 
//                                           : Colors.grey.shade500,
//                                         fontSize: 16,
//                                       ),
//                                     ),
//                                     Icon(
//                                       Icons.calendar_today_outlined,
//                                       color: Colors.grey.shade600,
//                                       size: 20,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
                      
//                       const SizedBox(height: 32),
                      
//                       // Continue Button
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: provider.isUpdating ? null : _handleContinue,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xFF1E88E5),
//                             foregroundColor: Colors.white,
//                             padding: const EdgeInsets.symmetric(vertical: 16),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                             elevation: 0,
//                           ),
//                           child: provider.isUpdating 
//                             ? const SizedBox(
//                                 height: 20,
//                                 width: 20,
//                                 child: CircularProgressIndicator(
//                                   strokeWidth: 2,
//                                   valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                                 ),
//                               )
//                             : const Text(
//                                 'Continue',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                         ),
//                       ),
                      
//                       const SizedBox(height: 24),
//                     ],
//                   ),
//                 ),
//               ),
              
//               // Loading overlay
//               if (provider.isLoading)
//                 Container(
//                   color: Colors.black.withOpacity(0.3),
//                   child: const Center(
//                     child: CircularProgressIndicator(),
//                   ),
//                 ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }






















import 'package:flutter/material.dart';
import 'package:booking_application/home/navbar_screen.dart';

class Adddetails extends StatefulWidget {
  const Adddetails({super.key});

  @override
  State<Adddetails> createState() => _AdddetailsState();
}

class _AdddetailsState extends State<Adddetails> {
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  String? _selectedGender;
  final List<String> _genderOptions = ['Male', 'Female', 'Other'];
  bool _isUpdating = false;

  @override
  void dispose() {
    _cityController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: Color(0xFF1E88E5)),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _dobController.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  String _formatDateForDisplay(String apiDate) {
    if (apiDate.isEmpty) return '';
    try {
      final date = DateTime.parse(apiDate);
      return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
    } catch (_) {
      return apiDate;
    }
  }

  void _showSnackBar(String message, {Color color = Colors.red}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _handleContinue() async {
    final city = _cityController.text.trim();
    final dob = _dobController.text.trim();
    final gender = _selectedGender;

    if (city.isEmpty) {
      _showSnackBar('Please enter your city');
      return;
    }
    if (gender == null || gender.isEmpty) {
      _showSnackBar('Please select your gender');
      return;
    }
    if (dob.isEmpty) {
      _showSnackBar('Please select your date of birth');
      return;
    }

    setState(() {
      _isUpdating = true;
    });

    // Simulate network call
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isUpdating = false;
    });

    _showSnackBar('Profile updated successfully!', color: Colors.green);

    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const NavbarScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://media.istockphoto.com/id/1176722220/photo/empty-green-grass-field-and-illuminated-outdoor-stadium-with-fans-front-field-view.jpg?s=612x612&w=0&k=20&c=YFh_7QVyJKuF9iBFgX4QF9c4-ojJE0_vCJjeORQExX4='),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF1a237e).withOpacity(0.8),
                  const Color(0xFF000051).withOpacity(0.9),
                ],
              ),
            ),
          ),

          // Back Button
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, top: 8),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),
          ),

          // Form
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildInputField("Where do you live?", _cityController, 'Enter your City'),
                  const SizedBox(height: 20),
                  _buildGenderDropdown(),
                  const SizedBox(height: 20),
                  _buildDatePicker(),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isUpdating ? null : _handleContinue,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E88E5),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: _isUpdating
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
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey.shade500),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGenderDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Select your Gender',
            style: TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedGender,
              hint: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Select gender',
                  style: TextStyle(color: Colors.grey.shade500),
                ),
              ),
              icon: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade600),
              ),
              isExpanded: true,
              items: _genderOptions.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(value, style: const TextStyle(color: Colors.black87)),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedGender = newValue;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Enter your Date of Birth',
            style: TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => _selectDate(context),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _dobController.text.isNotEmpty
                      ? _formatDateForDisplay(_dobController.text)
                      : 'DD/MM/YYYY',
                  style: TextStyle(
                    color: _dobController.text.isNotEmpty ? Colors.black87 : Colors.grey.shade500,
                    fontSize: 16,
                  ),
                ),
                Icon(Icons.calendar_today_outlined, color: Colors.grey.shade600, size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
