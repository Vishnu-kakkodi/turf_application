// import 'package:booking_application/views/Cricket/models/tournament_model.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class TournamentDetailScreen extends StatefulWidget {
//   final Tournament tournament;

//   const TournamentDetailScreen({Key? key, required this.tournament}) : super(key: key);

//   @override
//   _TournamentDetailScreenState createState() => _TournamentDetailScreenState();
// }

// class _TournamentDetailScreenState extends State<TournamentDetailScreen> with SingleTickerProviderStateMixin {
//   late TabController _tabController;
  
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 4, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFFAFAFA),
//       body: CustomScrollView(
//         slivers: [
//           // App Bar with Tournament Header
//           SliverAppBar(
//             expandedHeight: 280,
//             pinned: true,
//             backgroundColor: const Color(0xFF2E7D32),
//             leading: IconButton(
//               icon: const Icon(Icons.arrow_back, color: Colors.white),
//               onPressed: () => Navigator.pop(context),
//             ),
//             actions: [
//               IconButton(
//                 icon: const Icon(Icons.share, color: Colors.white),
//                 onPressed: () {
//                   // Share tournament functionality
//                 },
//               ),
//               IconButton(
//                 icon: const Icon(Icons.more_vert, color: Colors.white),
//                 onPressed: () {
//                   _showMoreOptions(context);
//                 },
//               ),
//             ],
//             flexibleSpace: FlexibleSpaceBar(
//               background: Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                     colors: [
//                       const Color(0xFF2E7D32),
//                       const Color(0xFF1B5E20),
//                     ],
//                   ),
//                 ),
//                 child: SafeArea(
//                   child: Padding(
//                     padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                           decoration: BoxDecoration(
//                             color: _getStatusColor(widget.tournament.tournamentStatus),
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: Text(
//                             _getStatusText(widget.tournament.tournamentStatus),
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 12,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         Text(
//                           widget.tournament.name,
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 28,
//                             fontWeight: FontWeight.bold,
//                             height: 1.2,
//                           ),
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         const SizedBox(height: 12),
//                         Row(
//                           children: [
//                             const Icon(Icons.location_on, color: Colors.white70, size: 18),
//                             const SizedBox(width: 6),
//                             Expanded(
//                               child: Text(
//                                 widget.tournament.locationName,
//                                 style: const TextStyle(
//                                   color: Colors.white70,
//                                   fontSize: 14,
//                                 ),
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 8),
//                         Row(
//                           children: [
//                             const Icon(Icons.calendar_today, color: Colors.white70, size: 18),
//                             const SizedBox(width: 6),
//                             Text(
//                               '${_formatDate(widget.tournament.startDate)} - ${_formatDate(widget.tournament.endDate)}',
//                               style: const TextStyle(
//                                 color: Colors.white70,
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),

//           // Tab Bar
//           SliverPersistentHeader(
//             pinned: true,
//             delegate: _SliverAppBarDelegate(
//               TabBar(
//                 controller: _tabController,
//                 labelColor: const Color(0xFF2E7D32),
//                 unselectedLabelColor: const Color(0xFF666666),
//                 indicatorColor: const Color(0xFF2E7D32),
//                 indicatorWeight: 3,
//                 labelStyle: const TextStyle(
//                   fontWeight: FontWeight.w600,
//                   fontSize: 14,
//                 ),
//                 tabs: const [
//                   Tab(text: 'Overview'),
//                   Tab(text: 'Teams'),
//                   Tab(text: 'Matches'),
//                   Tab(text: 'Standings'),
//                 ],
//               ),
//             ),
//           ),

//           // Tab Content
//           SliverFillRemaining(
//             child: TabBarView(
//               controller: _tabController,
//               children: [
//                 _buildOverviewTab(),
//                 _buildTeamsTab(),
//                 _buildMatchesTab(),
//                 _buildStandingsTab(),
//               ],
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: _buildBottomBar(),
//     );
//   }

//   Widget _buildOverviewTab() {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Quick Stats
//           Row(
//             children: [
//               Expanded(
//                 child: _buildStatCard(
//                   icon: Icons.groups,
//                   label: 'Teams',
//                   value: '${widget.tournament.numberOfTeams}',
//                   color: const Color(0xFF3B82F6),
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: _buildStatCard(
//                   icon: Icons.sports_cricket,
//                   label: 'Matches',
//                   value: '0', // Replace with actual match count
//                   color: const Color(0xFFFF9800),
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: _buildStatCard(
//                   icon: Icons.emoji_events,
//                   label: 'Format',
//                   value: widget.tournament.format,
//                   color: const Color(0xFF9C27B0),
//                   isText: true,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 24),

//           // Description
//           _buildSection(
//             title: 'About Tournament',
//             child: Text(
//               widget.tournament.description,
//               style: const TextStyle(
//                 color: Color(0xFF666666),
//                 fontSize: 15,
//                 height: 1.6,
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),

//           // Tournament Details
//           _buildSection(
//             title: 'Tournament Details',
//             child: Column(
//               children: [
//                 _buildDetailRow(
//                   icon: Icons.calendar_month,
//                   label: 'Registration Ends',
//                   value: DateFormat('dd MMM yyyy').format(widget.tournament.registrationEndDate),
//                 ),
//                 const SizedBox(height: 12),
//                 _buildDetailRow(
//                   icon: Icons.flag,
//                   label: 'Tournament Starts',
//                   value: DateFormat('dd MMM yyyy').format(widget.tournament.startDate),
//                 ),
//                 const SizedBox(height: 12),
//                 _buildDetailRow(
//                   icon: Icons.event_available,
//                   label: 'Tournament Ends',
//                   value: DateFormat('dd MMM yyyy').format(widget.tournament.endDate),
//                 ),
//                 const SizedBox(height: 12),
//                 _buildDetailRow(
//                   icon: Icons.format_list_bulleted,
//                   label: 'Format',
//                   value: widget.tournament.format,
//                 ),
//                 const SizedBox(height: 12),
//                 _buildDetailRow(
//                   icon: widget.tournament.isPaidEntry ? Icons.payments : Icons.free_breakfast,
//                   label: 'Entry',
//                   value: widget.tournament.isPaidEntry 
//                       ? '₹${widget.tournament.entryFee?.toStringAsFixed(0) ?? '0'}'
//                       : 'Free',
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 20),

//           // Rules
//           if (widget.tournament.rules.isNotEmpty)
//             _buildSection(
//               title: 'Rules & Regulations',
//               child: Text(
//                 widget.tournament.rules,
//                 style: const TextStyle(
//                   color: Color(0xFF666666),
//                   fontSize: 15,
//                   height: 1.6,
//                 ),
//               ),
//             ),
//           const SizedBox(height: 20),

//           // Prizes
//           if (widget.tournament.prizes.isNotEmpty)
//             _buildSection(
//               title: 'Prizes',
//               child: Text(
//                 widget.tournament.prizes,
//                 style: const TextStyle(
//                   color: Color(0xFF666666),
//                   fontSize: 15,
//                   height: 1.6,
//                 ),
//               ),
//             ),
//           const SizedBox(height: 20),

//           // Location Map Preview (Placeholder)
//           _buildSection(
//             title: 'Location',
//             child: Container(
//               height: 200,
//               decoration: BoxDecoration(
//                 color: const Color(0xFFE0E0E0),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Icon(Icons.map, size: 48, color: Color(0xFF999999)),
//                     const SizedBox(height: 8),
//                     Text(
//                       widget.tournament.locationName,
//                       style: const TextStyle(
//                         color: Color(0xFF666666),
//                         fontWeight: FontWeight.w500,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       'Lat: ${widget.tournament.lat.toStringAsFixed(4)}, Lng: ${widget.tournament.lng.toStringAsFixed(4)}',
//                       style: const TextStyle(
//                         color: Color(0xFF999999),
//                         fontSize: 12,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTeamsTab() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.groups,
//             size: 80,
//             color: Colors.grey[300],
//           ),
//           const SizedBox(height: 16),
//           Text(
//             'No Teams Yet',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.w600,
//               color: Colors.grey[600],
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Teams will appear here once registration starts',
//             style: TextStyle(
//               fontSize: 14,
//               color: Colors.grey[500],
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildMatchesTab() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.sports_cricket,
//             size: 80,
//             color: Colors.grey[300],
//           ),
//           const SizedBox(height: 16),
//           Text(
//             'No Matches Scheduled',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.w600,
//               color: Colors.grey[600],
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Matches will be scheduled after team registration',
//             style: TextStyle(
//               fontSize: 14,
//               color: Colors.grey[500],
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildStandingsTab() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.leaderboard,
//             size: 80,
//             color: Colors.grey[300],
//           ),
//           const SizedBox(height: 16),
//           Text(
//             'No Standings Available',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.w600,
//               color: Colors.grey[600],
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Standings will be updated as matches are played',
//             style: TextStyle(
//               fontSize: 14,
//               color: Colors.grey[500],
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildStatCard({
//     required IconData icon,
//     required String label,
//     required String value,
//     required Color color,
//     bool isText = false,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: color.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Icon(icon, color: color, size: 24),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             value,
//             style: TextStyle(
//               fontSize: isText ? 12 : 20,
//               fontWeight: FontWeight.bold,
//               color: const Color(0xFF333333),
//             ),
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//           ),
//           const SizedBox(height: 4),
//           Text(
//             label,
//             style: const TextStyle(
//               fontSize: 12,
//               color: Color(0xFF999999),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSection({required String title, required Widget child}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: const TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: Color(0xFF333333),
//           ),
//         ),
//         const SizedBox(height: 12),
//         Container(
//           width: double.infinity,
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.05),
//                 blurRadius: 8,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           child: child,
//         ),
//       ],
//     );
//   }

//   Widget _buildDetailRow({
//     required IconData icon,
//     required String label,
//     required String value,
//   }) {
//     return Row(
//       children: [
//         Container(
//           padding: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: const Color(0xFFF5F5F5),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Icon(icon, color: const Color(0xFF2E7D32), size: 20),
//         ),
//         const SizedBox(width: 12),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 label,
//                 style: const TextStyle(
//                   fontSize: 12,
//                   color: Color(0xFF999999),
//                 ),
//               ),
//               const SizedBox(height: 2),
//               Text(
//                 value,
//                 style: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600,
//                   color: Color(0xFF333333),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildBottomBar() {
//     final status = widget.tournament.tournamentStatus;
    
//     if (status == TournamentStatus.registrationOpen) {
//       return Container(
//         padding: const EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 8,
//               offset: const Offset(0, -2),
//             ),
//           ],
//         ),
//         child: ElevatedButton(
//           onPressed: () {
//             // Register team functionality
//             _showRegisterDialog();
//           },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: const Color(0xFF2E7D32),
//             padding: const EdgeInsets.symmetric(vertical: 16),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             elevation: 0,
//           ),
//           child: const Text(
//             'Register Your Team',
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w600,
//               color: Colors.white,
//             ),
//           ),
//         ),
//       );
//     }
    
//     return const SizedBox.shrink();
//   }

//   void _showRegisterDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//         ),
//         title: const Text(
//           'Register Team',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         content: const Text(
//           'Team registration functionality will be implemented here.',
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text(
//               'Close',
//               style: TextStyle(color: Color(0xFF2E7D32)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showMoreOptions(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) => Container(
//         padding: const EdgeInsets.symmetric(vertical: 20),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ListTile(
//               leading: const Icon(Icons.edit, color: Color(0xFF2E7D32)),
//               title: const Text('Edit Tournament'),
//               onTap: () {
//                 Navigator.pop(context);
//                 // Navigate to edit screen
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.share, color: Color(0xFF3B82F6)),
//               title: const Text('Share Tournament'),
//               onTap: () {
//                 Navigator.pop(context);
//                 // Share functionality
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.delete, color: Colors.red),
//               title: const Text('Delete Tournament'),
//               onTap: () {
//                 Navigator.pop(context);
//                 _showDeleteConfirmation();
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showDeleteConfirmation() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//         ),
//         title: const Text(
//           'Delete Tournament',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         content: const Text(
//           'Are you sure you want to delete this tournament? This action cannot be undone.',
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//               // Delete functionality
//             },
//             child: const Text(
//               'Delete',
//               style: TextStyle(color: Colors.red),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Color _getStatusColor(TournamentStatus status) {
//     switch (status) {
//       case TournamentStatus.registrationOpen:
//         return const Color(0xFFFF9800);
//       case TournamentStatus.live:
//         return const Color(0xFFFF6B6B);
//       case TournamentStatus.completed:
//         return const Color(0xFF666666);
//     }
//   }

//   String _getStatusText(TournamentStatus status) {
//     switch (status) {
//       case TournamentStatus.registrationOpen:
//         return 'Registration Open';
//       case TournamentStatus.live:
//         return 'Live';
//       case TournamentStatus.completed:
//         return 'Completed';
//     }
//   }

//   String _formatDate(DateTime date) {
//     return '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}';
//   }
// }

// // Custom Delegate for Pinned Tab Bar
// class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
//   _SliverAppBarDelegate(this._tabBar);

//   final TabBar _tabBar;

//   @override
//   double get minExtent => _tabBar.preferredSize.height;
//   @override
//   double get maxExtent => _tabBar.preferredSize.height;

//   @override
//   Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return Container(
//       color: Colors.white,
//       child: _tabBar,
//     );
//   }

//   @override
//   bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
//     return false;
//   }
// }













import 'package:booking_application/views/Cricket/models/tournament_model.dart';
import 'package:booking_application/views/Cricket/models/team_model.dart';
import 'package:booking_application/views/Cricket/providers/tournament_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TournamentDetailScreen extends StatefulWidget {
  final Tournament tournament;

  const TournamentDetailScreen({Key? key, required this.tournament}) : super(key: key);

  @override
  _TournamentDetailScreenState createState() => _TournamentDetailScreenState();
}

class _TournamentDetailScreenState extends State<TournamentDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    
    // Add listener to rebuild when tab changes
    _tabController.addListener(() {
      setState(() {});
    });
    
    // Fetch tournament teams when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<TournamentNewProvider>(context, listen: false);
      provider.fetchTournamentTeams(widget.tournament.id);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: CustomScrollView(
        slivers: [
          // App Bar with Tournament Header
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: const Color(0xFF2E7D32),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.share, color: Colors.white),
                onPressed: () {
                  // Share tournament functionality
                },
              ),
              IconButton(
                icon: const Icon(Icons.more_vert, color: Colors.white),
                onPressed: () {
                  _showMoreOptions(context);
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFF2E7D32),
                      const Color(0xFF1B5E20),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: _getStatusColor(widget.tournament.tournamentStatus),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            _getStatusText(widget.tournament.tournamentStatus),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          widget.tournament.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Icon(Icons.location_on, color: Colors.white70, size: 18),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                widget.tournament.locationName,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.calendar_today, color: Colors.white70, size: 18),
                            const SizedBox(width: 6),
                            Text(
                              '${_formatDate(widget.tournament.startDate)} - ${_formatDate(widget.tournament.endDate)}',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Tab Bar
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverAppBarDelegate(
              TabBar(
                controller: _tabController,
                labelColor: const Color(0xFF2E7D32),
                unselectedLabelColor: const Color(0xFF666666),
                indicatorColor: const Color(0xFF2E7D32),
                indicatorWeight: 3,
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                tabs: const [
                  Tab(text: 'Overview'),
                  Tab(text: 'Teams'),
                  Tab(text: 'Matches'),
                ],
              ),
            ),
          ),

          // Tab Content
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOverviewTab(),
                _buildTeamsTab(),
                _buildMatchesTab(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: _tabController.index == 1
          ? FloatingActionButton.extended(
              onPressed: () => _showAddTeamDialog(),
              backgroundColor: const Color(0xFF2E7D32),
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text('Add Team', style: TextStyle(color: Colors.white)),
            )
          : null,
    );
  }

  Widget _buildOverviewTab() {
    return Consumer<TournamentNewProvider>(
      builder: (context, provider, child) {
        final teams = provider.tournamentTeams[widget.tournament.id] ?? [];
        
        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Quick Stats
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      icon: Icons.groups,
                      label: 'Teams',
                      value: '${teams.length}',
                      color: const Color(0xFF3B82F6),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      icon: Icons.sports_cricket,
                      label: 'Matches',
                      value: '0',
                      color: const Color(0xFFFF9800),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      icon: Icons.emoji_events,
                      label: 'Format',
                      value: widget.tournament.format,
                      color: const Color(0xFF9C27B0),
                      isText: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Description
              _buildSection(
                title: 'About Tournament',
                child: Text(
                  widget.tournament.description,
                  style: const TextStyle(
                    color: Color(0xFF666666),
                    fontSize: 15,
                    height: 1.6,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Tournament Details
              _buildSection(
                title: 'Tournament Details',
                child: Column(
                  children: [
                    _buildDetailRow(
                      icon: Icons.calendar_month,
                      label: 'Registration Ends',
                      value: DateFormat('dd MMM yyyy').format(widget.tournament.registrationEndDate),
                    ),
                    const SizedBox(height: 12),
                    _buildDetailRow(
                      icon: Icons.flag,
                      label: 'Tournament Starts',
                      value: DateFormat('dd MMM yyyy').format(widget.tournament.startDate),
                    ),
                    const SizedBox(height: 12),
                    _buildDetailRow(
                      icon: Icons.event_available,
                      label: 'Tournament Ends',
                      value: DateFormat('dd MMM yyyy').format(widget.tournament.endDate),
                    ),
                    const SizedBox(height: 12),
                    _buildDetailRow(
                      icon: Icons.format_list_bulleted,
                      label: 'Format',
                      value: widget.tournament.format,
                    ),
                    const SizedBox(height: 12),
                    _buildDetailRow(
                      icon: widget.tournament.tournamentType == 'paid' ? Icons.payments : Icons.free_breakfast,
                      label: 'Entry',
                      value: widget.tournament.tournamentType == 'paid'
                          ? '₹${widget.tournament.price?.toStringAsFixed(0) ?? '0'}'
                          : 'Free',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Rules
              if (widget.tournament.rules != null && widget.tournament.rules!.isNotEmpty)
                _buildSection(
                  title: 'Rules & Regulations',
                  child: Text(
                    widget.tournament.rules!,
                    style: const TextStyle(
                      color: Color(0xFF666666),
                      fontSize: 15,
                      height: 1.6,
                    ),
                  ),
                ),
              const SizedBox(height: 20),

              // Prizes
              if (widget.tournament.prizes != null && widget.tournament.prizes!.isNotEmpty)
                _buildSection(
                  title: 'Prizes',
                  child: Text(
                    widget.tournament.prizes!,
                    style: const TextStyle(
                      color: Color(0xFF666666),
                      fontSize: 15,
                      height: 1.6,
                    ),
                  ),
                ),
              const SizedBox(height: 20),

              // Location Map Preview
              _buildSection(
                title: 'Location',
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0E0E0),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.map, size: 48, color: Color(0xFF999999)),
                        const SizedBox(height: 8),
                        Text(
                          widget.tournament.locationName,
                          style: const TextStyle(
                            color: Color(0xFF666666),
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Lat: ${widget.tournament.location.lat.toStringAsFixed(4)}, Lng: ${widget.tournament.location.lng.toStringAsFixed(4)}',
                          style: const TextStyle(
                            color: Color(0xFF999999),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTeamsTab() {
    return Consumer<TournamentNewProvider>(
      builder: (context, provider, child) {
        if (provider.isLoadingTeams) {
          return const Center(child: CircularProgressIndicator());
        }

        final teams = provider.tournamentTeams[widget.tournament.id] ?? [];

        if (teams.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.groups,
                  size: 80,
                  color: Colors.grey[300],
                ),
                const SizedBox(height: 16),
                Text(
                  'No Teams Yet',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Add teams to start the tournament',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () => _showAddTeamDialog(),
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text('Add Your First Team', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E7D32),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: teams.length,
          itemBuilder: (context, index) {
            final team = teams[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: CircleAvatar(
                  backgroundColor: const Color(0xFF2E7D32),
                  child: Text(
                    team.teamName[0].toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(
                  team.teamName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  '${team.players.length} players',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, size: 16),
                  onPressed: () {
                    _showTeamDetails(team);
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildMatchesTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.sports_cricket,
            size: 80,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 16),
          Text(
            'No Matches Scheduled',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Matches will be scheduled after team registration',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    bool isText = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: isText ? 12 : 20,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF333333),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF999999),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: child,
        ),
      ],
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: const Color(0xFF2E7D32), size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF999999),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF333333),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showAddTeamDialog() {
    showDialog(
      context: context,
      builder: (context) => _AddTeamDialog(
        tournamentId: widget.tournament.id,
        onTeamAdded: () {
          final provider = Provider.of<TournamentNewProvider>(context, listen: false);
          provider.fetchTournamentTeams(widget.tournament.id);
        },
      ),
    );
  }

  void _showTeamDetails(Team team) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                team.teamName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${team.players.length} Players',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Players',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: team.players.length,
                  itemBuilder: (context, index) {
                    final player = team.players[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: const Color(0xFF2E7D32).withOpacity(0.1),
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(
                            color: Color(0xFF2E7D32),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      title: Text(
                        player.name,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMoreOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit, color: Color(0xFF2E7D32)),
              title: const Text('Edit Tournament'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.share, color: Color(0xFF3B82F6)),
              title: const Text('Share Tournament'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Delete Tournament'),
              onTap: () {
                Navigator.pop(context);
                _showDeleteConfirmation();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          'Delete Tournament',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text(
          'Are you sure you want to delete this tournament? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(TournamentStatus status) {
    switch (status) {
      case TournamentStatus.registrationOpen:
        return const Color(0xFFFF9800);
      case TournamentStatus.live:
        return const Color(0xFFFF6B6B);
      case TournamentStatus.completed:
        return const Color(0xFF666666);
    }
  }

  String _getStatusText(TournamentStatus status) {
    switch (status) {
      case TournamentStatus.registrationOpen:
        return 'Registration Open';
      case TournamentStatus.live:
        return 'Live';
      case TournamentStatus.completed:
        return 'Completed';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}';
  }
}

// Add Team Dialog
class _AddTeamDialog extends StatefulWidget {
  final String tournamentId;
  final VoidCallback onTeamAdded;

  const _AddTeamDialog({
    required this.tournamentId,
    required this.onTeamAdded,
  });

  @override
  State<_AddTeamDialog> createState() => _AddTeamDialogState();
}

class _AddTeamDialogState extends State<_AddTeamDialog> {
  final TextEditingController _searchController = TextEditingController();
  List<Team> _searchResults = [];
  bool _isSearching = false;
  Team? _selectedTeam;

  void _searchTeams(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    setState(() {
      _isSearching = true;
    });

    final provider = Provider.of<TournamentNewProvider>(context, listen: false);
    final results = await provider.searchTeams(query);

    setState(() {
      _searchResults = results;
      _isSearching = false;
    });
  }

  void _addTeam() async {
    if (_selectedTeam == null) return;

    final provider = Provider.of<TournamentNewProvider>(context, listen: false);
    
    // You need to get userId from your auth system
    const userId = '6884a16d466d0e6a7824552a'; // Replace with actual user ID
    
    final success = await provider.addTeamToTournament(
      userId: userId,
      tournamentId: widget.tournamentId,
      teamId: _selectedTeam!.id.toString(),
    );

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Team added successfully!'),
          backgroundColor: Color(0xFF2E7D32),
        ),
      );
      widget.onTeamAdded();
      Navigator.pop(context);
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(provider.errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: const Text(
        'Add Team to Tournament',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search teams...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              onChanged: _searchTeams,
            ),
            const SizedBox(height: 16),
            if (_isSearching)
              const CircularProgressIndicator()
            else if (_searchResults.isEmpty && _searchController.text.isNotEmpty)
              const Text(
                'No teams found',
                style: TextStyle(color: Colors.grey),
              )
            else if (_searchResults.isNotEmpty)
              Container(
                constraints: const BoxConstraints(maxHeight: 300),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _searchResults.length,
                  itemBuilder: (context, index) {
                    final team = _searchResults[index];
                    final isSelected = _selectedTeam?.id == team.id;
                    
                    return ListTile(
                      selected: isSelected,
                      selectedTileColor: const Color(0xFF2E7D32).withOpacity(0.1),
                      leading: CircleAvatar(
                        backgroundColor: isSelected 
                            ? const Color(0xFF2E7D32)
                            : Colors.grey[300],
                        child: Text(
                          team.teamName[0].toUpperCase(),
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(
                        team.teamName,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text('${team.players.length} players'),
                      onTap: () {
                        setState(() {
                          _selectedTeam = team;
                        });
                      },
                    );
                  },
                ),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _selectedTeam == null ? null : _addTeam,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2E7D32),
            disabledBackgroundColor: Colors.grey[300],
          ),
          child: const Text(
            'Add Team',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

// Custom Delegate for Pinned Tab Bar
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}