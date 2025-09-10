// // ignore_for_file: deprecated_member_use, unused_field

// import 'package:flutter/material.dart';

// class CreateNewTeam extends StatefulWidget {
//   const CreateNewTeam({super.key});

//   @override
//   State<CreateNewTeam> createState() => _CreateNewTeamState();
// }

// class _CreateNewTeamState extends State<CreateNewTeam>
//     with TickerProviderStateMixin {
//   final _formKey = GlobalKey<FormState>();
//   String? selectedTeamName;
//   String? selectedSport;
//   String? selectedTeamType;
//   String teamLink = '';
//   List<TeamMember> teamMembers = [];
//   bool showPreview = false;

//   // Animation controllers
//   late AnimationController _slideController;
//   late AnimationController _fadeController;
//   late AnimationController _scaleController;
//   late Animation<Offset> _slideAnimation;
//   late Animation<double> _fadeAnimation;
//   late Animation<double> _scaleAnimation;

//   // Sample data for dropdowns
//   final List<String> teamNames = [
//     'Warriors',
//     'Lions',
//     'Eagles',
//     'Tigers',
//     'Champions',
//     'Phoenix',
//     'Thunderbolts',
//     'Spartans'
//   ];

//   final List<String> sports = [
//     'Football',
//     'Basketball',
//     'Cricket',
//     'Tennis',
//     'Baseball',
//     'Volleyball',
//     'Hockey',
//     'Rugby'
//   ];

//   final List<String> teamTypes = [
//     'Professional',
//     'Amateur',
//     'College',
//     'High School',
//     'Youth',
//     'Recreational',
//     'Semi-Professional'
//   ];

//   final List<String> positions = [
//     'Captain',
//     'Vice Captain',
//     'Forward',
//     'Midfielder',
//     'Defender',
//     'Goalkeeper',
//     'Point Guard',
//     'Center',
//     'Power Forward',
//     'Shooting Guard',
//     'Small Forward'
//   ];

//   @override
//   void initState() {
//     super.initState();

//     // Initialize animation controllers
//     _slideController = AnimationController(
//       duration: const Duration(milliseconds: 800),
//       vsync: this,
//     );
//     _fadeController = AnimationController(
//       duration: const Duration(milliseconds: 600),
//       vsync: this,
//     );
//     _scaleController = AnimationController(
//       duration: const Duration(milliseconds: 400),
//       vsync: this,
//     );

//     // Initialize animations
//     _slideAnimation = Tween<Offset>(
//       begin: const Offset(0, 0.3),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(
//       parent: _slideController,
//       curve: Curves.easeOutCubic,
//     ));

//     _fadeAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _fadeController,
//       curve: Curves.easeInOut,
//     ));

//     _scaleAnimation = Tween<double>(
//       begin: 0.8,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _scaleController,
//       curve: Curves.elasticOut,
//     ));

//     // Start initial animations
//     _slideController.forward();
//     _fadeController.forward();
//   }

//   @override
//   void dispose() {
//     _slideController.dispose();
//     _fadeController.dispose();
//     _scaleController.dispose();
//     super.dispose();
//   }

//   void _addTeamMember() {
//     showDialog(
//       context: context,
//       builder: (context) => _AddMemberDialog(
//         positions: positions,
//         onAdd: (member) {
//           setState(() {
//             teamMembers.add(member);
//           });
//           _animateNewMember();
//         },
//       ),
//     );
//   }

//   void _animateNewMember() {
//     _scaleController.reset();
//     _scaleController.forward();
//   }

//   void _removeMember(int index) {
//     setState(() {
//       teamMembers.removeAt(index);
//     });
//   }

//   void _showPreview() {
//     if (_formKey.currentState!.validate() && teamMembers.isNotEmpty) {
//       setState(() {
//         showPreview = true;
//       });
//       _slideController.reset();
//       _fadeController.reset();
//       _slideController.forward();
//       _fadeController.forward();
//     } else {
//       _showErrorSnackBar(
//           'Please fill all required fields and add at least one team member');
//     }
//   }

//   void _showErrorSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Row(
//           children: [
//             const Icon(Icons.error_outline, color: Colors.white),
//             const SizedBox(width: 8),
//             Expanded(child: Text(message)),
//           ],
//         ),
//         backgroundColor: Colors.red,
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       ),
//     );
//   }

//   void _confirmTeam() {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: const Row(
//           children: [
//             Icon(Icons.check_circle, color: Colors.white),
//             SizedBox(width: 8),
//             Text('Team created successfully!'),
//           ],
//         ),
//         backgroundColor: Colors.green,
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       ),
//     );
//     Navigator.pop(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: AppBar(
//         title: const Text(
//           'Create New Team',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black87,
//         elevation: 0,
//         centerTitle: true,
//         leading: IconButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             icon: const Icon(Icons.arrow_back_ios)),
//       ),
//       body: AnimatedSwitcher(
//         duration: const Duration(milliseconds: 500),
//         switchInCurve: Curves.easeInOut,
//         switchOutCurve: Curves.easeInOut,
//         transitionBuilder: (child, animation) {
//           return SlideTransition(
//             position: Tween<Offset>(
//               begin: const Offset(1.0, 0.0),
//               end: Offset.zero,
//             ).animate(animation),
//             child: child,
//           );
//         },
//         child: showPreview ? _buildPreview() : _buildForm(),
//       ),
//     );
//   }

//   Widget _buildForm() {
//     return SlideTransition(
//       position: _slideAnimation,
//       child: FadeTransition(
//         opacity: _fadeAnimation,
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(20.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildAnimatedSectionTitle('Team Information', delay: 0),
//                 const SizedBox(height: 16),
//                 // _buildAnimatedTextField(
//                 //   label: 'Team Name',
//                 //   icon: Icons.sports,
//                 //   delay: 100,
//                 // ),

//                 // TextFormField(
//                 //   decoration: InputDecoration(
//                 //     border: OutlineInputBorder(
//                 //     ),
                    
//                 //     hintText: 'Team Name',
//                 //     prefixIcon: Icon(Icons.sports,color: Colors.blue,)
//                 //   ),
//                 // ),
//                 _buildAnimatedDropdownField(
//                   label: 'Team Name',
//                   value: selectedTeamName,
//                   items: teamNames,
//                   onChanged: (value) => setState(() => selectedTeamName = value),
//                   icon: Icons.sports,
//                   delay: 100,
//                 ),
//                 // const SizedBox(height: 16),
//                 // _buildAnimatedDropdownField(
//                 //   label: 'Sport',
//                 //   value: selectedSport,
//                 //   items: sports,
//                 //   onChanged: (value) => setState(() => selectedSport = value),
//                 //   icon: Icons.sports_basketball,
//                 //   delay: 200,
//                 // ),
//                 const SizedBox(height: 16),
//                 _buildAnimatedDropdownField(
//                   label: 'Team Type',
//                   value: selectedTeamType,
//                   items: teamTypes,
//                   onChanged: (value) =>
//                       setState(() => selectedTeamType = value),
//                   icon: Icons.group,
//                   delay: 300,
//                 ),
//                 const SizedBox(height: 16),
//                 _buildAnimatedTextFieldWithIcon(
//                   label: 'Team Link (Optional)',
//                   value: teamLink,
//                   onChanged: (value) => teamLink = value,
//                   icon: Icons.link,
//                   keyboardType: TextInputType.url,
//                   delay: 400,
//                 ),
//                 const SizedBox(height: 32),
//                 _buildAnimatedSectionTitle('Team Members', delay: 500),
//                 const SizedBox(height: 16),
//                 _buildAnimatedAddMemberCard(delay: 600),
//                 const SizedBox(height: 16),
//                 _buildAnimatedMembersList(),
//                 const SizedBox(height: 32),
//                 _buildAnimatedActionButtons(delay: 700),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildPreview() {
//     return SlideTransition(
//       position: _slideAnimation,
//       child: FadeTransition(
//         opacity: _fadeAnimation,
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildAnimatedSectionTitle('Team Preview', delay: 0),
//               const SizedBox(height: 20),
//               _buildAnimatedPreviewCard(),
//               const SizedBox(height: 32),
//               _buildAnimatedPreviewButtons(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildAnimatedSectionTitle(String title, {required int delay}) {
//     return TweenAnimationBuilder<double>(
//       duration: Duration(milliseconds: 600 + delay),
//       tween: Tween(begin: 0.0, end: 1.0),
//       curve: Curves.easeOutCubic,
//       builder: (context, value, child) {
//         return Transform.translate(
//           offset: Offset(0, 20 * (1 - value)),
//           child: Opacity(
//             opacity: value,
//             child: Text(
//               title,
//               style: const TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black87,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildAnimatedDropdownField({
//     required String label,
//     required String? value,
//     required List<String> items,
//     required Function(String?) onChanged,
//     required IconData icon,
//     required int delay,
//   }) {
//     return TweenAnimationBuilder<double>(
//       duration: Duration(milliseconds: 600 + delay),
//       tween: Tween(begin: 0.0, end: 1.0),
//       curve: Curves.easeOutCubic,
//       builder: (context, animation, child) {
//         return Transform.translate(
//           offset: Offset(0, 30 * (1 - animation)),
//           child: Opacity(
//             opacity: animation,
//             child: AnimatedContainer(
//               duration: const Duration(milliseconds: 200),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(8),
//                 border: Border.all(color: Colors.grey.shade300),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.05),
//                     blurRadius: 10,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: DropdownButtonFormField<String>(
//                 value: value,
//                 decoration: InputDecoration(
//                   labelText: label,
//                   prefixIcon: Icon(icon, color: Colors.blue[700]),
//                   border: InputBorder.none,
//                   contentPadding:
//                       const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//                 ),
//                 items: items
//                     .map((item) => DropdownMenuItem(
//                           value: item,
//                           child: Text(item),
//                         ))
//                     .toList(),
//                 onChanged: onChanged,
//                 validator: (value) =>
//                     value == null ? 'Please select $label' : null,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildAnimatedTextField({
//     required String label,
//     required IconData icon,
//     required int delay,
//   }) {
//     return TweenAnimationBuilder<double>(
//       duration: Duration(milliseconds: 600 + delay),
//       tween: Tween(begin: 0.0, end: 1.0),
//       curve: Curves.easeOutCubic,
//       builder: (context, animation, child) {
//         return Transform.translate(
//           offset: Offset(0, 30 * (1 - animation)),
//           child: Opacity(
//             opacity: animation,
//             child: TextFormField(
//               decoration: InputDecoration(
//                 border: const OutlineInputBorder(),
//                 hintText: label,
//                 prefixIcon: Icon(icon, color: Colors.blue),
//                 contentPadding:
//                     const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//               ),
//               validator: (val) =>
//                   val == null || val.isEmpty ? 'Please enter $label' : null,
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildAnimatedTextFieldWithIcon({
//     required String label,
//     required String value,
//     required Function(String) onChanged,
//     required IconData icon,
//     TextInputType keyboardType = TextInputType.text,
//     required int delay,
//   }) {
//     return TweenAnimationBuilder<double>(
//       duration: Duration(milliseconds: 600 + delay),
//       tween: Tween(begin: 0.0, end: 1.0),
//       curve: Curves.easeOutCubic,
//       builder: (context, animation, child) {
//         return Transform.translate(
//           offset: Offset(0, 30 * (1 - animation)),
//           child: Opacity(
//             opacity: animation,
//             child: AnimatedContainer(
//               duration: const Duration(milliseconds: 200),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(8),
//                 border: Border.all(color: Colors.grey.shade300),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.05),
//                     blurRadius: 10,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: TextFormField(
//                 initialValue: value,
//                 decoration: InputDecoration(
//                   labelText: label,
//                   prefixIcon: Icon(icon, color: Colors.blue[700]),
//                   border: InputBorder.none,
//                   contentPadding:
//                       const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//                 ),
//                 keyboardType: keyboardType,
//                 onChanged: onChanged,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildAnimatedAddMemberCard({required int delay}) {
//     return TweenAnimationBuilder<double>(
//       duration: Duration(milliseconds: 600 + delay),
//       tween: Tween(begin: 0.0, end: 1.0),
//       curve: Curves.easeOutCubic,
//       builder: (context, animation, child) {
//         return Transform.translate(
//           offset: Offset(0, 30 * (1 - animation)),
//           child: Opacity(
//             opacity: animation,
//             child: GestureDetector(
//               onTap: _addTeamMember,
//               child: AnimatedContainer(
//                 duration: const Duration(milliseconds: 200),
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(8),
//                   border: Border.all(color: Colors.grey.shade300),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.05),
//                       blurRadius: 10,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: Row(
//                   children: [
//                     Hero(
//                       tag: 'add_member_icon',
//                       child: AnimatedContainer(
//                         duration: const Duration(milliseconds: 300),
//                         width: 40,
//                         height: 40,
//                         decoration: BoxDecoration(
//                           color: Colors.blue[700],
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: const Icon(Icons.add, color: Colors.white),
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     const Text(
//                       'Add Team Member',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildAnimatedMembersList() {
//     if (teamMembers.isEmpty) {
//       return TweenAnimationBuilder<double>(
//         duration: const Duration(milliseconds: 600),
//         tween: Tween(begin: 0.0, end: 1.0),
//         curve: Curves.easeInOut,
//         builder: (context, animation, child) {
//           return Opacity(
//             opacity: animation,
//             child: Container(
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.grey[100],
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: const Center(
//                 child: Text(
//                   'No team members added yet',
//                   style: TextStyle(color: Colors.grey),
//                 ),
//               ),
//             ),
//           );
//         },
//       );
//     }

//     return Column(
//       children: teamMembers.asMap().entries.map((entry) {
//         int index = entry.key;
//         TeamMember member = entry.value;

//         return TweenAnimationBuilder<double>(
//           duration: Duration(milliseconds: 400 + (index * 100)),
//           tween: Tween(begin: 0.0, end: 1.0),
//           curve: Curves.elasticOut,
//           builder: (context, animation, child) {
//             return Transform.scale(
//               scale: animation,
//               child: Container(
//                 margin: const EdgeInsets.only(bottom: 8),
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(8),
//                   border: Border.all(color: Colors.grey.shade300),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.05),
//                       blurRadius: 10,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: Row(
//                   children: [
//                     Hero(
//                       tag: 'member_${member.name}',
//                       child: CircleAvatar(
//                         backgroundColor: Colors.blue[100],
//                         child: Text(
//                           member.name.substring(0, 1).toUpperCase(),
//                           style: TextStyle(
//                             color: Colors.blue[700],
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             member.name,
//                             style: const TextStyle(
//                               fontWeight: FontWeight.w500,
//                               fontSize: 16,
//                             ),
//                           ),
//                           Text(
//                             member.position,
//                             style: TextStyle(
//                               color: Colors.grey[600],
//                               fontSize: 14,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     AnimatedContainer(
//                       duration: const Duration(milliseconds: 200),
//                       child: IconButton(
//                         onPressed: () => _removeMember(index),
//                         icon:
//                             const Icon(Icons.delete_outline, color: Colors.red),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       }).toList(),
//     );
//   }

//   Widget _buildAnimatedActionButtons({required int delay}) {
//     return TweenAnimationBuilder<double>(
//       duration: Duration(milliseconds: 600 + delay),
//       tween: Tween(begin: 0.0, end: 1.0),
//       curve: Curves.easeOutCubic,
//       builder: (context, animation, child) {
//         return Transform.translate(
//           offset: Offset(0, 30 * (1 - animation)),
//           child: Opacity(
//             opacity: animation,
//             child: SizedBox(
//               width: double.infinity,
//               child: AnimatedContainer(
//                 duration: const Duration(milliseconds: 300),
//                 child: ElevatedButton(
//                   onPressed: _showPreview,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue[700],
//                     foregroundColor: Colors.white,
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     elevation: 4,
//                     shadowColor: Colors.blue.withOpacity(0.3),
//                   ),
//                   child: const Text(
//                     'Preview Team',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildAnimatedPreviewCard() {
//     return TweenAnimationBuilder<double>(
//       duration: const Duration(milliseconds: 800),
//       tween: Tween(begin: 0.0, end: 1.0),
//       curve: Curves.elasticOut,
//       builder: (context, animation, child) {
//         return Transform.scale(
//           scale: animation,
//           child: Card(
//             elevation: 8,
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//             shadowColor: Colors.blue.withOpacity(0.2),
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Hero(
//                         tag: 'team_logo',
//                         child: Container(
//                           width: 60,
//                           height: 60,
//                           decoration: BoxDecoration(
//                             color: Colors.blue.shade100,
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           child: Icon(
//                             Icons.sports,
//                             color: Colors.blue.shade700,
//                             size: 30,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 16),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               selectedTeamName ?? '',
//                               style: const TextStyle(
//                                 fontSize: 24,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             Text(
//                               '${selectedSport ?? ''} • ${selectedTeamType ?? ''}',
//                               style: TextStyle(
//                                 color: Colors.grey[600],
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   if (teamLink.isNotEmpty) ...[
//                     const SizedBox(height: 16),
//                     Row(
//                       children: [
//                         Icon(Icons.link, color: Colors.grey[600], size: 18),
//                         const SizedBox(width: 8),
//                         Expanded(
//                           child: Text(
//                             teamLink,
//                             style: TextStyle(
//                               color: Colors.blue[700],
//                               decoration: TextDecoration.underline,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                   const SizedBox(height: 20),
//                   const Text(
//                     'Team Members',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   ...teamMembers.asMap().entries.map((entry) {
//                     int index = entry.key;
//                     TeamMember member = entry.value;
//                     return TweenAnimationBuilder<double>(
//                       duration: Duration(milliseconds: 400 + (index * 100)),
//                       tween: Tween(begin: 0.0, end: 1.0),
//                       curve: Curves.easeOutCubic,
//                       builder: (context, animation, child) {
//                         return Transform.translate(
//                           offset: Offset(20 * (1 - animation), 0),
//                           child: Opacity(
//                             opacity: animation,
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(vertical: 4),
//                               child: Row(
//                                 children: [
//                                   Hero(
//                                     tag: 'preview_member_${member.name}',
//                                     child: CircleAvatar(
//                                       radius: 20,
//                                       backgroundColor: Colors.grey[200],
//                                       child: Text(
//                                         member.name
//                                             .substring(0, 1)
//                                             .toUpperCase(),
//                                         style: const TextStyle(
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                     ),
//                                   ),
//                                   const SizedBox(width: 12),
//                                   Expanded(
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           member.name,
//                                           style: const TextStyle(
//                                               fontWeight: FontWeight.w500),
//                                         ),
//                                         Text(
//                                           member.position,
//                                           style: TextStyle(
//                                             color: Colors.grey[600],
//                                             fontSize: 12,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   }),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildAnimatedPreviewButtons() {
//     return TweenAnimationBuilder<double>(
//       duration: const Duration(milliseconds: 600),
//       tween: Tween(begin: 0.0, end: 1.0),
//       curve: Curves.easeOutCubic,
//       builder: (context, animation, child) {
//         return Transform.translate(
//           offset: Offset(0, 30 * (1 - animation)),
//           child: Opacity(
//             opacity: animation,
//             child: Row(
//               children: [
//                 Expanded(
//                   child: AnimatedContainer(
//                     duration: const Duration(milliseconds: 200),
//                     child: OutlinedButton(
//                       onPressed: () => setState(() => showPreview = false),
//                       style: OutlinedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       child: const Text('Back to Edit'),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 Expanded(
//                   child: AnimatedContainer(
//                     duration: const Duration(milliseconds: 200),
//                     child: ElevatedButton(
//                       onPressed: _confirmTeam,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blue[700],
//                         foregroundColor: Colors.white,
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         elevation: 4,
//                         shadowColor: Colors.blue.withOpacity(0.3),
//                       ),
//                       child: const Text('Confirm Team'),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class TeamMember {
//   final String name;
//   final String position;

//   TeamMember({required this.name, required this.position});
// }

// class _AddMemberDialog extends StatefulWidget {
//   final List<String> positions;
//   final Function(TeamMember) onAdd;

//   const _AddMemberDialog({
//     required this.positions,
//     required this.onAdd,
//   });

//   @override
//   State<_AddMemberDialog> createState() => _AddMemberDialogState();
// }

// class _AddMemberDialogState extends State<_AddMemberDialog>
//     with SingleTickerProviderStateMixin {
//   final _nameController = TextEditingController();
//   String? selectedPosition;
//   final _formKey = GlobalKey<FormState>();
//   late AnimationController _dialogController;
//   late Animation<double> _scaleAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _dialogController = AnimationController(
//       duration: const Duration(milliseconds: 300),
//       vsync: this,
//     );
//     _scaleAnimation = Tween<double>(
//       begin: 0.8,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _dialogController,
//       curve: Curves.elasticOut,
//     ));
//     _dialogController.forward();
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _dialogController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ScaleTransition(
//       scale: _scaleAnimation,
//       child: AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         title: const Text('Add Team Member'),
//         content: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TweenAnimationBuilder<double>(
//                 duration: const Duration(milliseconds: 400),
//                 tween: Tween(begin: 0.0, end: 1.0),
//                 curve: Curves.easeOutCubic,
//                 builder: (context, animation, child) {
//                   return Transform.translate(
//                     offset: Offset(0, 20 * (1 - animation)),
//                     child: Opacity(
//                       opacity: animation,
//                       child: TextFormField(
//                         controller: _nameController,
//                         decoration: const InputDecoration(
//                           labelText: 'Name',
//                           prefixIcon: Icon(Icons.person),
//                           border: OutlineInputBorder(),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.trim().isEmpty) {
//                             return 'Please enter a name';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//                   );
//                 },
//               ),
//               const SizedBox(height: 16),
//               TweenAnimationBuilder<double>(
//                 duration: const Duration(milliseconds: 500),
//                 tween: Tween(begin: 0.0, end: 1.0),
//                 curve: Curves.easeOutCubic,
//                 builder: (context, animation, child) {
//                   return Transform.translate(
//                     offset: Offset(0, 20 * (1 - animation)),
//                     child: Opacity(
//                       opacity: animation,
//                       child: DropdownButtonFormField<String>(
//                         value: selectedPosition,
//                         decoration: const InputDecoration(
//                           labelText: 'Position',
//                           prefixIcon: Icon(Icons.assignment_ind),
//                           border: OutlineInputBorder(),
//                         ),
//                         items: widget.positions
//                             .map((position) => DropdownMenuItem(
//                                   value: position,
//                                   child: Text(position),
//                                 ))
//                             .toList(),
//                         onChanged: (value) =>
//                             setState(() => selectedPosition = value),
//                         validator: (value) =>
//                             value == null ? 'Please select a position' : null,
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//         actions: [
//           TweenAnimationBuilder<double>(
//             duration: const Duration(milliseconds: 600),
//             tween: Tween(begin: 0.0, end: 1.0),
//             curve: Curves.easeOutCubic,
//             builder: (context, animation, child) {
//               return Transform.translate(
//                 offset: Offset(0, 20 * (1 - animation)),
//                 child: Opacity(
//                   opacity: animation,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       TextButton(
//                         onPressed: () => Navigator.pop(context),
//                         child: const Text('Cancel'),
//                       ),
//                       const SizedBox(width: 8),
//                       AnimatedContainer(
//                         duration: const Duration(milliseconds: 200),
//                         child: ElevatedButton(
//                           onPressed: () {
//                             if (_formKey.currentState!.validate()) {
//                               widget.onAdd(TeamMember(
//                                 name: _nameController.text.trim(),
//                                 position: selectedPosition!,
//                               ));
//                               Navigator.pop(context);
//                             }
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.blue[700],
//                             foregroundColor: Colors.white,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                           ),
//                           child: const Text('Add'),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }













// ignore_for_file: deprecated_member_use, unused_field

import 'package:flutter/material.dart';

class CreateNewTeam extends StatefulWidget {
  const CreateNewTeam({super.key});

  @override
  State<CreateNewTeam> createState() => _CreateNewTeamState();
}

class _CreateNewTeamState extends State<CreateNewTeam>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  String? selectedTeamName;
  String? selectedSport;
  String? selectedTeamType;
  String teamLink = '';
  List<TeamMember> teamMembers = [];
  bool showPreview = false;

  // Animation controllers
  late AnimationController _slideController;
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  // Sample data for dropdowns
  final List<String> sports = [
    'Football',
    'Basketball',
    'Cricket',
    'Tennis',
    'Baseball',
    'Volleyball',
    'Hockey',
    'Rugby'
  ];

  final List<String> teamTypes = [
    'Professional',
    'Amateur',
    'College',
    'High School',
    'Youth',
    'Recreational',
    'Semi-Professional'
  ];

  final List<String> positions = [
    'Captain',
    'Vice Captain',
    'Forward',
    'Midfielder',
    'Defender',
    'Goalkeeper',
    'Point Guard',
    'Center',
    'Power Forward',
    'Shooting Guard',
    'Small Forward'
  ];

  @override
  void initState() {
    super.initState();
    
    // Initialize animation controllers
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    // Initialize animations
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));

    // Start initial animations
    _slideController.forward();
    _fadeController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  void _addTeamMember() {
    showDialog(
      context: context,
      builder: (context) => _AddMemberDialog(
        positions: positions,
        onAdd: (member) {
          setState(() {
            teamMembers.add(member);
          });
          _animateNewMember();
        },
      ),
    );
  }

  void _animateNewMember() {
    _scaleController.reset();
    _scaleController.forward();
  }

  void _removeMember(int index) {
    setState(() {
      teamMembers.removeAt(index);
    });
  }

  void _showPreview() {
    if (_formKey.currentState!.validate() && teamMembers.isNotEmpty) {
      setState(() {
        showPreview = true;
      });
      _slideController.reset();
      _fadeController.reset();
      _slideController.forward();
      _fadeController.forward();
    } else {
      _showErrorSnackBar('Please fill all required fields and add at least one team member');
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _confirmTeam() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:const Row(
          children: [
             Icon(Icons.check_circle, color: Colors.white),
             SizedBox(width: 8),
             Text('Team created successfully!'),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Create New Team',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon:const Icon(Icons.arrow_back_ios)),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
        transitionBuilder: (child, animation) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
        child: showPreview ? _buildPreview() : _buildForm(),
      ),
    );
  }

  Widget _buildForm() {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAnimatedSectionTitle('Team Information', delay: 0),
                const SizedBox(height: 16),
                _buildAnimatedTextField(
                  label: 'Team Name',
                  value: selectedTeamName,
                  onChanged: (value) => setState(() => selectedTeamName = value),
                  delay: 100,
                  icon: Icons.sports
                  
                ),
                const SizedBox(height: 16),
                // _buildAnimatedDropdownField(
                //   label: 'Sport',
                //   value: selectedSport,
                //   items: sports,
                //   onChanged: (value) => setState(() => selectedSport = value),
                //   icon: Icons.sports_basketball,
                //   delay: 200,
                // ),
                const SizedBox(height: 16),
                _buildAnimatedDropdownField(
                  label: 'Team Type',
                  value: selectedTeamType,
                  items: teamTypes,
                  onChanged: (value) => setState(() => selectedTeamType = value),
                  icon: Icons.group,
                  delay: 300,
                ),
                const SizedBox(height: 16),
                _buildAnimatedTextFieldWithIcon(
                  label: 'Team Link (Optional)',
                  value: teamLink,
                  onChanged: (value) => teamLink = value,
                  icon: Icons.link,
                  keyboardType: TextInputType.url,
                  delay: 400,
                ),
                const SizedBox(height: 32),
                _buildAnimatedSectionTitle('Team Members', delay: 500),
                const SizedBox(height: 16),
                _buildAnimatedAddMemberCard(delay: 600),
                const SizedBox(height: 16),
                _buildAnimatedMembersList(),
                const SizedBox(height: 32),
                _buildAnimatedActionButtons(delay: 700),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPreview() {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAnimatedSectionTitle('Team Preview', delay: 0),
              const SizedBox(height: 20),
              _buildAnimatedPreviewCard(),
              const SizedBox(height: 32),
              _buildAnimatedPreviewButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedSectionTitle(String title, {required int delay}) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 600 + delay),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
        );
      },
    );
  }

  // // New method for regular text field without icon
  // Widget _buildAnimatedTextField({
  //   required String label,
  //   required String? value,
  //   required Function(String?) onChanged,
  //   required int delay,
  // }) {
  //   return TweenAnimationBuilder<double>(
  //     duration: Duration(milliseconds: 600 + delay),
  //     tween: Tween(begin: 0.0, end: 1.0),
  //     curve: Curves.easeOutCubic,
  //     builder: (context, animation, child) {
  //       return Transform.translate(
  //         offset: Offset(0, 30 * (1 - animation)),
  //         child: Opacity(
  //           opacity: animation,
  //           child: AnimatedContainer(
  //             duration: const Duration(milliseconds: 200),
  //             decoration: BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.circular(8),
  //               border: Border.all(color: Colors.grey.shade300),
  //               boxShadow: [
  //                 BoxShadow(
  //                   color: Colors.black.withOpacity(0.05),
  //                   blurRadius: 10,
  //                   offset: const Offset(0, 2),
  //                 ),
  //               ],
  //             ),
  //             child: TextFormField(
  //               initialValue: value,
  //               decoration: InputDecoration(
  //                 labelText: label,
  //                 border: InputBorder.none,
  //                 contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  //               ),
  //               onChanged: onChanged,
  //               validator: (value) => value == null || value.isEmpty ? 'Please enter a team name' : null,
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }


  // New method for regular text field with optional icon
Widget _buildAnimatedTextField({
  required String label,
  required String? value,
  required Function(String?) onChanged,
  required int delay,
  IconData? icon, // <-- Add this
}) {
  return TweenAnimationBuilder<double>(
    duration: Duration(milliseconds: 600 + delay),
    tween: Tween(begin: 0.0, end: 1.0),
    curve: Curves.easeOutCubic,
    builder: (context, animation, child) {
      return Transform.translate(
        offset: Offset(0, 30 * (1 - animation)),
        child: Opacity(
          opacity: animation,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextFormField(
              initialValue: value,
              decoration: InputDecoration(
                labelText: label,
                prefixIcon: icon != null 
                    ? Icon(icon, color: Colors.blue) 
                    : null, // <-- Only show if provided
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              ),
              onChanged: onChanged,
              validator: (value) =>
                  value == null || value.isEmpty ? 'Please enter $label' : null,
            ),
          ),
        ),
      );
    },
  );
}


  Widget _buildAnimatedDropdownField({
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
    required IconData icon,
    required int delay,
  }) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 600 + delay),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutCubic,
      builder: (context, animation, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - animation)),
          child: Opacity(
            opacity: animation,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: DropdownButtonFormField<String>(
                value: value,
                decoration: InputDecoration(
                  labelText: label,
                  prefixIcon: Icon(icon, color: Colors.blue[700]),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                ),
                items: items.map((item) => DropdownMenuItem(
                  value: item,
                  child: Text(item),
                )).toList(),
                onChanged: onChanged,
                validator: (value) => value == null ? 'Please select $label' : null,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedTextFieldWithIcon({
    required String label,
    required String value,
    required Function(String) onChanged,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    required int delay,
  }) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 600 + delay),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutCubic,
      builder: (context, animation, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - animation)),
          child: Opacity(
            opacity: animation,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextFormField(
                initialValue: value,
                decoration: InputDecoration(
                  labelText: label,
                  prefixIcon: Icon(icon, color: Colors.blue[700]),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                ),
                keyboardType: keyboardType,
                onChanged: onChanged,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedAddMemberCard({required int delay}) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 600 + delay),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutCubic,
      builder: (context, animation, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - animation)),
          child: Opacity(
            opacity: animation,
            child: GestureDetector(
              onTap: _addTeamMember,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Hero(
                      tag: 'add_member_icon',
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.blue[700],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(Icons.add, color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      'Add Team Member',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedMembersList() {
    if (teamMembers.isEmpty) {
      return TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 600),
        tween: Tween(begin: 0.0, end: 1.0),
        curve: Curves.easeInOut,
        builder: (context, animation, child) {
          return Opacity(
            opacity: animation,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  'No team members added yet',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          );
        },
      );
    }

    return Column(
      children: teamMembers.asMap().entries.map((entry) {
        int index = entry.key;
        TeamMember member = entry.value;
        
        return TweenAnimationBuilder<double>(
          duration: Duration(milliseconds: 400 + (index * 100)),
          tween: Tween(begin: 0.0, end: 1.0),
          curve: Curves.elasticOut,
          builder: (context, animation, child) {
            return Transform.scale(
              scale: animation,
              child: Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Hero(
                      tag: 'member_${member.name}',
                      child: CircleAvatar(
                        backgroundColor: Colors.blue[100],
                        child: Text(
                          member.name.substring(0, 1).toUpperCase(),
                          style: TextStyle(
                            color: Colors.blue[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            member.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            member.position,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      child: IconButton(
                        onPressed: () => _removeMember(index),
                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildAnimatedActionButtons({required int delay}) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 600 + delay),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutCubic,
      builder: (context, animation, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - animation)),
          child: Opacity(
            opacity: animation,
            child: SizedBox(
              width: double.infinity,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                child: ElevatedButton(
                  onPressed: _showPreview,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 4,
                    shadowColor: Colors.blue.withOpacity(0.3),
                  ),
                  child: const Text(
                    'Preview Team',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedPreviewCard() {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 800),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.elasticOut,
      builder: (context, animation, child) {
        return Transform.scale(
          scale: animation,
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            shadowColor: Colors.blue.withOpacity(0.2),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Hero(
                        tag: 'team_logo',
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Icon(
                            Icons.sports,
                            color: Colors.blue.shade700,
                            size: 30,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              selectedTeamName ?? '',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${selectedSport ?? ''} • ${selectedTeamType ?? ''}',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (teamLink.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(Icons.link, color: Colors.grey[600], size: 18),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            teamLink,
                            style: TextStyle(
                              color: Colors.blue[700],
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 20),
                  const Text(
                    'Team Members',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...teamMembers.asMap().entries.map((entry) {
                    int index = entry.key;
                    TeamMember member = entry.value;
                    return TweenAnimationBuilder<double>(
                      duration: Duration(milliseconds: 400 + (index * 100)),
                      tween: Tween(begin: 0.0, end: 1.0),
                      curve: Curves.easeOutCubic,
                      builder: (context, animation, child) {
                        return Transform.translate(
                          offset: Offset(20 * (1 - animation), 0),
                          child: Opacity(
                            opacity: animation,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                children: [
                                  Hero(
                                    tag: 'preview_member_${member.name}',
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.grey[200],
                                      child: Text(
                                        member.name.substring(0, 1).toUpperCase(),
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          member.name,
                                          style: const TextStyle(fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          member.position,
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedPreviewButtons() {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 600),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutCubic,
      builder: (context, animation, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - animation)),
          child: Opacity(
            opacity: animation,
            child: Row(
              children: [
                Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    child: OutlinedButton(
                      onPressed: () => setState(() => showPreview = false),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Back to Edit'),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    child: ElevatedButton(
                      onPressed: _confirmTeam,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[700],
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 4,
                        shadowColor: Colors.blue.withOpacity(0.3),
                      ),
                      child: const Text('Confirm Team'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class TeamMember {
  final String name;
  final String position;

  TeamMember({required this.name, required this.position});
}

class _AddMemberDialog extends StatefulWidget {
  final List<String> positions;
  final Function(TeamMember) onAdd;

  const _AddMemberDialog({
    required this.positions,
    required this.onAdd,
  });

  @override
  State<_AddMemberDialog> createState() => _AddMemberDialogState();
}

class _AddMemberDialogState extends State<_AddMemberDialog>
    with SingleTickerProviderStateMixin {
  final _nameController = TextEditingController();
  String? selectedPosition;
  final _formKey = GlobalKey<FormState>();
  late AnimationController _dialogController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _dialogController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _dialogController,
      curve: Curves.elasticOut,
    ));
    _dialogController.forward();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dialogController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text('Add Team Member'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 400),
                tween: Tween(begin: 0.0, end: 1.0),
                curve: Curves.easeOutCubic,
                builder: (context, animation, child) {
                  return Transform.translate(
                    offset: Offset(0, 20 * (1 - animation)),
                    child: Opacity(
                      opacity: animation,
                      child: TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter a name';
                          }
                          return null;
                        },
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 500),
                tween: Tween(begin: 0.0, end: 1.0),
                curve: Curves.easeOutCubic,
                builder: (context, animation, child) {
                  return Transform.translate(
                    offset: Offset(0, 20 * (1 - animation)),
                    child: Opacity(
                      opacity: animation,
                      child: DropdownButtonFormField<String>(
                        value: selectedPosition,
                        decoration: const InputDecoration(
                          labelText: 'Position',
                          prefixIcon: Icon(Icons.assignment_ind),
                          border: OutlineInputBorder(),
                        ),
                        items: widget.positions.map((position) => DropdownMenuItem(
                          value: position,
                          child: Text(position),
                        )).toList(),
                        onChanged: (value) => setState(() => selectedPosition = value),
                        validator: (value) => value == null ? 'Please select a position' : null,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        actions: [
          TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 600),
            tween: Tween(begin: 0.0, end: 1.0),
            curve: Curves.easeOutCubic,
            builder: (context, animation, child) {
              return Transform.translate(
                offset: Offset(0, 20 * (1 - animation)),
                child: Opacity(
                  opacity: animation,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(width: 8),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              widget.onAdd(TeamMember(
                                name: _nameController.text.trim(),
                                position: selectedPosition!,
                              ));
                              Navigator.pop(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[700],
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Add'),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}