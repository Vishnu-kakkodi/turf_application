// import 'package:flutter/material.dart';

// class PersonalInformationScreen extends StatelessWidget {
//   const PersonalInformationScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Personal information',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         centerTitle: false,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         elevation: 0,
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//         child: Column(
//           children: [
//             // const Divider(thickness: 1),
//             const SizedBox(height: 20),
//             Stack(
//               alignment: Alignment.bottomRight,
//               children: [
//                 const CircleAvatar(
//                   radius: 50,
//                   backgroundImage: NetworkImage(
//                       'https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg'), // Replace with user image
//                 ),
//                 Positioned(
//                   bottom: 0,
//                   right: 2,
//                   child: CircleAvatar(
//                     radius: 14,
//                     backgroundColor: Colors.grey.shade200,
//                     child: const Icon(Icons.camera_alt, size: 16),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             const Text(
//               "PMS",
//               style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
//             ),
//             const SizedBox(height: 30),
//             const Divider(thickness: 1),
//             const SizedBox(height: 16),
//             _buildTextField("Full Name", "Tommy"),
//             const SizedBox(height: 12),
//             _buildTextField("E-Mail", "Tommy@gmail.com"),
//             const SizedBox(height: 12),
//             _buildTextField("Phone Number", "1234567890"),
//             const SizedBox(height: 40),
//             SizedBox(
//               width: double.infinity,
//               height: 50,
//               child: ElevatedButton(
//                 onPressed: () {},
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF00A9FF),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                 ),
//                 child: const Text("Save", style: TextStyle(fontSize: 16,color: Colors.white)),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(String label, String hint) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
//         const SizedBox(height: 4),
//         TextFormField(
//           initialValue: hint,
//           decoration: InputDecoration(
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//             ),
//             contentPadding: const EdgeInsets.symmetric(horizontal: 16),
//           ),
//         ),
//       ],
//     );
//   }
// }


















import 'package:booking_application/provider/user_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';


class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({super.key});

  @override
  State<PersonalInformationScreen> createState() => _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<UserProfileProvider>(context, listen: false);
      provider.loadUserProfile();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _populateFields(UserProfileProvider provider) {
    if (provider.currentUser != null && _nameController.text.isEmpty) {
      _nameController.text = provider.currentUser!.name;
      _emailController.text = provider.currentUser!.email;
      _phoneController.text = provider.currentUser!.mobile;
    }
  }

  Future<void> _pickImage() async {
    final provider = Provider.of<UserProfileProvider>(context, listen: false);
    
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () async {
                  Navigator.of(context).pop();
                  final XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    final success = await provider.uploadProfileImage(image.path);
                    if (success && mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Profile image updated successfully')),
                      );
                    }
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () async {
                  Navigator.of(context).pop();
                  final XFile? image = await _imagePicker.pickImage(source: ImageSource.camera);
                  if (image != null) {
                    final success = await provider.uploadProfileImage(image.path);
                    if (success && mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Profile image updated successfully')),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    final provider = Provider.of<UserProfileProvider>(context, listen: false);
    
    final success = await provider.updateProfile(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      mobile: _phoneController.text.trim(),
    );

    if (mounted) {
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(provider.errorMessage ?? 'Failed to update profile'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Personal information',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Consumer<UserProfileProvider>(
        builder: (context, provider, child) {
          _populateFields(provider);

          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: provider.profileImageUrl != null
                            ? NetworkImage(provider.profileImageUrl!)
                            : const NetworkImage(
                                'https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg',
                              ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 2,
                        child: GestureDetector(
                          onTap: _pickImage,
                          child: CircleAvatar(
                            radius: 14,
                            backgroundColor: Colors.grey.shade200,
                            child: const Icon(Icons.camera_alt, size: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    provider.currentUser?.name ?? "User",
                    style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  const SizedBox(height: 30),
                  const Divider(thickness: 1),
                  const SizedBox(height: 16),
                  _buildTextField(
                    "Full Name",
                    _nameController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildTextField(
                    "E-Mail",
                    _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildTextField(
                    "Phone Number",
                    _phoneController,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your phone number';
                      }
                      if (value.length < 10) {
                        return 'Please enter a valid phone number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: provider.isLoading ? null : _saveProfile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00A9FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: provider.isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              "Save",
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    String? Function(String?)? validator,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 4),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          ),
        ),
      ],
    );
  }
}