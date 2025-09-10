// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class MatchDetails extends StatefulWidget {
//   const MatchDetails({super.key});

//   @override
//   State<MatchDetails> createState() => _MatchDetailsState();
// }

// class _MatchDetailsState extends State<MatchDetails>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 6, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Match Center',style: TextStyle(fontWeight: FontWeight.bold),),
//         centerTitle: true,
//         // backgroundColor: Colors.teal,
//         foregroundColor: Colors.black,
//         bottom: TabBar(
//           controller: _tabController,
//           isScrollable: true,
//           indicatorColor: Colors.black,
//           labelColor: Colors.black,
//           unselectedLabelColor: Colors.blue,
//           tabs: const [
//             Tab(icon: Icon(Icons.add_circle), text: 'Create Match'),
//             Tab(icon: Icon(Icons.sports_cricket), text: 'Live Score'),
//             Tab(icon: Icon(Icons.schedule), text: 'Upcoming'),
//             Tab(icon: Icon(Icons.history), text: 'Past Matches'),
//             Tab(icon: Icon(Icons.analytics), text: 'Match Stats'),
//             Tab(icon: Icon(Icons.supervised_user_circle), text: 'Team Details'),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: const [
//           CreateMatchTab(),
//           LiveScoreTab(),
//           UpcomingMatchesTab(),
//           PastMatchesTab(),
//           MatchStatsTab(),
//           TeamDetailsTab(),
//         ],
//       ),
//     );
//   }
// }

// // Create Match Tab
// class CreateMatchTab extends StatefulWidget {
//   const CreateMatchTab({super.key});

//   @override
//   State<CreateMatchTab> createState() => _CreateMatchTabState();
// }

// class _CreateMatchTabState extends State<CreateMatchTab> {
//   final _formKey = GlobalKey<FormState>();
//   String _team1 = '';
//   String _team2 = '';
//   String _venue = '';
//   DateTime _matchDate = DateTime.now();
//   TimeOfDay _matchTime = TimeOfDay.now();
//   String _matchType = 'T20';
//   String _typeball = 'Tennis';

//   String _formatTime(TimeOfDay time) {
//     final hour = time.hour;
//     final minute = time.minute;
//     final period = hour >= 12 ? 'PM' : 'AM';
//     final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
//     return '${displayHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Form(
//         key: _formKey,
//         child: ListView(
//           children: [
//             const Text(
//               'Create New Match',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),
//             TextFormField(
//               decoration: const InputDecoration(
//                 labelText: 'Team 1',
//                 border: OutlineInputBorder(),
//                 prefixIcon: Icon(Icons.group),
//               ),
//               onSaved: (value) => _team1 = value ?? '',
//               validator: (value) =>
//                   value?.isEmpty ?? true ? 'Please enter team name' : null,
//             ),
//             const SizedBox(height: 16),
//             TextFormField(
//               decoration: const InputDecoration(
//                 labelText: 'Team 2',
//                 border: OutlineInputBorder(),
//                 prefixIcon: Icon(Icons.group),
//               ),
//               onSaved: (value) => _team2 = value ?? '',
//               validator: (value) =>
//                   value?.isEmpty ?? true ? 'Please enter team name' : null,
//             ),

//             const SizedBox(height: 16),
//             TextFormField(
//               decoration: const InputDecoration(
//                 labelText: 'Venue',
//                 border: OutlineInputBorder(),
//                 prefixIcon: Icon(Icons.location_on),
//               ),
//               onSaved: (value) => _venue = value ?? '',
//               validator: (value) =>
//                   value?.isEmpty ?? true ? 'Please enter venue' : null,
//             ),
//             const SizedBox(height: 16),
//             DropdownButtonFormField<String>(
//               value: _matchType,
//               decoration: const InputDecoration(
//                 labelText: 'Match Type',
//                 border: OutlineInputBorder(),
//                 prefixIcon: Icon(Icons.sports_cricket),
//               ),
//               items: ['T20', 'ODI', 'Test']
//                   .map((type) => DropdownMenuItem(
//                         value: type,
//                         child: Text(type),
//                       ))
//                   .toList(),
//               onChanged: (value) => setState(() => _matchType = value!),
//             ),
//              const SizedBox(height: 16),
//             DropdownButtonFormField<String>(
//               value: _typeball,
//               decoration: const InputDecoration(
//                 labelText: 'Type of ball',
//                 border: OutlineInputBorder(),
//                 prefixIcon: Icon(FontAwesomeIcons.baseball, size: 30)
//               ),
//               items: ['Tennis', 'Leather', 'Others']
//                   .map((type) => DropdownMenuItem(
//                         value: type,
//                         child: Text(type),
//                       ))
//                   .toList(),
//               onChanged: (value) => setState(() => _typeball = value!),
//             ),
//             const SizedBox(height: 16),
//             ListTile(
//               title: Text('Date: ${_matchDate.day.toString().padLeft(2, '0')}-${_matchDate.month.toString().padLeft(2, '0')}-${_matchDate.year} at ${_formatTime(_matchTime)}'),
//               leading: const Icon(Icons.calendar_today),
//               trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//               onTap: () async {
//                 final date = await showDatePicker(
//                   context: context,
//                   initialDate: _matchDate.isAfter(DateTime.now()) ? _matchDate : DateTime.now(),
//                   firstDate: DateTime.now(),
//                   lastDate: DateTime.now().add(const Duration(days: 365)),
//                 );
//                 if (date != null) {
//                   setState(() {
//                     _matchDate = date;
//                   });
//                 }
//               },
//             ),
//             const SizedBox(height: 8),
//             ListTile(
//               title: Text('Time: ${_formatTime(_matchTime)}'),
//               leading: const Icon(Icons.access_time),
//               trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//               onTap: () async {
//                 final time = await showTimePicker(
//                   context: context,
//                   initialTime: _matchTime,
//                 );
//                 if (time != null) {
//                   setState(() {
//                     _matchTime = time;
//                   });
//                 }
//               },
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 if (_formKey.currentState!.validate()) {
//                   _formKey.currentState!.save();
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text('Match scheduled for ${_matchDate.day.toString().padLeft(2, '0')}-${_matchDate.month.toString().padLeft(2, '0')}-${_matchDate.year} at ${_formatTime(_matchTime)}'),
//                     ),
//                   );
//                 }
//               },
//               child: const Text('Create Match'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Live Score Tab
// class LiveScoreTab extends StatelessWidget {
//   const LiveScoreTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         children: [
//           Card(
//             elevation: 4,
//             child: Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 children: [
//                   const Text(
//                     'India vs Australia',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 10),
//                const   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Column(
//                         children: [
//                            Text('IND', style: TextStyle(fontSize: 16)),
//                            Text('185/6', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//                            Text('(18.4 overs)', style: TextStyle(fontSize: 12)),
//                         ],
//                       ),
//                        Text('vs', style: TextStyle(fontSize: 18)),
//                       Column(
//                         children: [
//                            Text('AUS', style: TextStyle(fontSize: 16)),
//                            Text('142/8', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//                            Text('(16.2 overs)', style: TextStyle(fontSize: 12)),
//                         ],
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 10),
//                   Container(
//                     padding: const EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       color: Colors.green,
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                     child: const Text(
//                       'India won by 43 runs',
//                       style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//           Expanded(
//             child: ListView(
//               children: [
//                 _buildPlayerStats('Virat Kohli', '75*', '52 balls, 8x4, 2x6'),
//                 _buildPlayerStats('Steve Smith', '45', '38 balls, 5x4, 1x6'),
//                 _buildPlayerStats('Jasprit Bumrah', '3/25', '4 overs'),
//                 _buildPlayerStats('Pat Cummins', '2/35', '4 overs'),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPlayerStats(String name, String score, String details) {
//     return Card(
//       child: ListTile(
//         leading: const CircleAvatar(child: Icon(Icons.person)),
//         title: Text(name),
//         subtitle: Text(details),
//         trailing: Text(score, style: const TextStyle(fontWeight: FontWeight.bold)),
//       ),
//     );
//   }
// }

// // Upcoming Matches Tab
// class UpcomingMatchesTab extends StatelessWidget {
//   const UpcomingMatchesTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: 5,
//       itemBuilder: (context, index) {
//         return Card(
//           margin: const EdgeInsets.only(bottom: 12),
//           child: ListTile(
//             leading: const Icon(Icons.schedule, color: Colors.orange),
//             title: Text('Match ${index + 1}: Team A vs Team B'),
//             subtitle: Text('Date: ${DateTime.now().add(Duration(days: index + 1)).toLocal()}'.split(' ')[0]),
//             trailing: const Text('T20'),
//             onTap: () {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text('Match ${index + 1} details')),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }

// // Past Matches Tab
// class PastMatchesTab extends StatelessWidget {
//   const PastMatchesTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: 10,
//       itemBuilder: (context, index) {
//         final results = ['Won', 'Lost', 'Won', 'Won', 'Lost', 'Won', 'Lost', 'Won', 'Won', 'Lost'];
//         final colors = [Colors.green, Colors.red];
//         final resultColor = results[index] == 'Won' ? colors[0] : colors[1];

//         return Card(
//           margin: const EdgeInsets.only(bottom: 12),
//           child: ListTile(
//             leading: Icon(Icons.sports_cricket, color: resultColor),
//             title: Text('India vs Team ${String.fromCharCode(65 + index)}'),
//             subtitle: Text('Date: ${DateTime.now().subtract(Duration(days: index + 1)).toLocal()}'.split(' ')[0]),
//             trailing: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//               decoration: BoxDecoration(
//                 color: resultColor,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Text(
//                 results[index],
//                 style: const TextStyle(color: Colors.white, fontSize: 12),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// // Match Stats Tab
// class MatchStatsTab extends StatelessWidget {
//   const MatchStatsTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Match Statistics',
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 20),

//           // MVP Section
//         const  Card(
//             child: Padding(
//               padding:  EdgeInsets.all(16),
//               child: Column(
//                 children: [
//                    Text('Player of the Match', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                    SizedBox(height: 10),
//                   Row(
//                     children: [
//                        CircleAvatar(
//                         radius: 30,
//                         child: Icon(Icons.person, size: 30),
//                       ),
//                        SizedBox(width: 16),
//                        Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text('Virat Kohli', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                             Text('75* runs (52 balls)'),
//                             Text('Strike Rate: 144.23'),
//                           ],
//                         ),
//                       ),
//                        Icon(Icons.star, color: Colors.amber, size: 30),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           const SizedBox(height: 16),

//           // Best Bowler Section
//         const  Card(
//             child: Padding(
//               padding:  EdgeInsets.all(16),
//               child: Column(
//                 children: [
//                    Text('Best Bowler', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                    SizedBox(height: 10),
//                   Row(
//                     children: [
//                        CircleAvatar(
//                         radius: 30,
//                         child: Icon(Icons.person, size: 30),
//                       ),
//                        SizedBox(width: 16),
//                        Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text('Jasprit Bumrah', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                             Text('3/25 (4 overs)'),
//                             Text('Economy: 6.25'),
//                           ],
//                         ),
//                       ),
//                        Icon(Icons.sports_cricket, color: Colors.blue, size: 30),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           const SizedBox(height: 16),

//           // Battle of the Match
//           Card(
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text('Battle of the Match', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 16),
//                   const Text('Kohli vs Cummins'),
//                   const SizedBox(height: 10),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Column(
//                           children: [
//                             const Text('Virat Kohli', style: TextStyle(fontWeight: FontWeight.bold)),
//                             const SizedBox(height: 8),
//                             Container(
//                               height: 8,
//                               decoration: BoxDecoration(
//                                 color: Colors.green,
//                                 borderRadius: BorderRadius.circular(4),
//                               ),
//                             ),
//                             const SizedBox(height: 4),
//                             const Text('18 runs scored', style: TextStyle(fontSize: 12)),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(width: 20),
//                       const Text('vs'),
//                       const SizedBox(width: 20),
//                       Expanded(
//                         child: Column(
//                           children: [
//                             const Text('Pat Cummins', style: TextStyle(fontWeight: FontWeight.bold)),
//                             const SizedBox(height: 8),
//                             Container(
//                               height: 8,
//                               decoration: BoxDecoration(
//                                 color: Colors.red,
//                                 borderRadius: BorderRadius.circular(4),
//                               ),
//                             ),
//                             const SizedBox(height: 4),
//                             const Text('0 wickets taken', style: TextStyle(fontSize: 12)),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           const SizedBox(height: 16),

//           // Performance Chart
//           Card(
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text('Team Performance', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 16),
//                   SizedBox(
//                     height: 200,
//                     child: CustomPaint(
//                       painter: BarChartPainter(),
//                       size: const Size(double.infinity, 200),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           const SizedBox(height: 16),

//           // Match Summary Stats
//           Card(
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text('Match Summary', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 16),
//                   _buildStatRow('Total Runs', '327'),
//                   _buildStatRow('Total Wickets', '14'),
//                   _buildStatRow('Total Boundaries', '32'),
//                   _buildStatRow('Total Sixes', '8'),
//                   _buildStatRow('Highest Partnership', '89 runs'),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildStatRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(label),
//           Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
//         ],
//       ),
//     );
//   }
// }

// class TeamDetailsTab extends StatelessWidget {
//   const TeamDetailsTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Team Details',
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 20),

//           // Team Header Section
//           Card(
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Row(
//                 children: [
//                   Container(
//                     width: 60,
//                     height: 60,
//                     decoration: BoxDecoration(
//                       color: Colors.blue,
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: const Icon(
//                       Icons.sports_cricket,
//                       color: Colors.white,
//                       size: 30,
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   const Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Team India',
//                           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                         ),
//                         Text('ICC Ranking: #1'),
//                         Text('Captain: Rohit Sharma'),
//                         Text('Coach: Rahul Dravid'),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           const SizedBox(height: 16),

//           // Captain Section
//           const Card(
//             child: Padding(
//               padding: EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Captain', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                   SizedBox(height: 10),
//                   Row(
//                     children: [
//                       CircleAvatar(
//                         radius: 30,
//                         child: Icon(Icons.person, size: 30),
//                       ),
//                       SizedBox(width: 16),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text('Rohit Sharma', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                             Text('Batsman • Right-handed'),
//                             Text('Matches: 243 • Runs: 9782'),
//                           ],
//                         ),
//                       ),
//                       Icon(Icons.stars, color: Colors.amber, size: 30),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           const SizedBox(height: 16),

//           // Vice Captain Section
//           const Card(
//             child: Padding(
//               padding: EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Vice Captain', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                   SizedBox(height: 10),
//                   Row(
//                     children: [
//                       CircleAvatar(
//                         radius: 30,
//                         child: Icon(Icons.person, size: 30),
//                       ),
//                       SizedBox(width: 16),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text('Hardik Pandya', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                             Text('All-rounder • Right-handed'),
//                             Text('Matches: 89 • Runs: 1769'),
//                           ],
//                         ),
//                       ),
//                       Icon(Icons.sports_cricket, color: Colors.orange, size: 30),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           const SizedBox(height: 16),

//           // Squad Section
//           Card(
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text('Squad Overview', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 16),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       _buildSquadStat('Batsmen', '6', Colors.green),
//                       _buildSquadStat('Bowlers', '5', Colors.red),
//                       _buildSquadStat('All-rounders', '3', Colors.orange),
//                       _buildSquadStat('W. Keepers', '2', Colors.blue),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           const SizedBox(height: 16),

//           // Key Players Section
//           Card(
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text('Key Players', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 16),
//                   _buildPlayerTile('Virat Kohli', 'Batsman', '12738 runs', Icons.trending_up, Colors.green),
//                   const SizedBox(height: 8),
//                   _buildPlayerTile('Jasprit Bumrah', 'Bowler', '138 wickets', Icons.sports_cricket, Colors.red),
//                   const SizedBox(height: 8),
//                   _buildPlayerTile('Ravindra Jadeja', 'All-rounder', '2706 runs, 220 wickets', Icons.all_inclusive, Colors.orange),
//                   const SizedBox(height: 8),
//                   _buildPlayerTile('KL Rahul', 'Wicket Keeper', '2321 runs', Icons.sports_baseball, Colors.blue),
//                 ],
//               ),
//             ),
//           ),

//           const SizedBox(height: 16),

//           // Team Statistics
//           Card(
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text('Team Statistics', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 16),
//                   _buildStatRow('Matches Played', '567'),
//                   _buildStatRow('Matches Won', '298'),
//                   _buildStatRow('Win Percentage', '52.6%'),
//                   _buildStatRow('Highest Score', '418/5'),
//                   _buildStatRow('Lowest Score', '36'),
//                   _buildStatRow('Current Streak', '3 wins'),
//                 ],
//               ),
//             ),
//           ),

//           const SizedBox(height: 16),

//           // Recent Form
//           Card(
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text('Recent Form (Last 10 matches)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 16),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       _buildFormIndicator('W', Colors.green),
//                       _buildFormIndicator('W', Colors.green),
//                       _buildFormIndicator('L', Colors.red),
//                       _buildFormIndicator('W', Colors.green),
//                       _buildFormIndicator('W', Colors.green),
//                       _buildFormIndicator('L', Colors.red),
//                       _buildFormIndicator('W', Colors.green),
//                       _buildFormIndicator('W', Colors.green),
//                       _buildFormIndicator('W', Colors.green),
//                       _buildFormIndicator('L', Colors.red),
//                     ],
//                   ),
//                   const SizedBox(height: 8),
//                   const Text('7 Wins, 3 Losses', style: TextStyle(fontSize: 12, color: Colors.grey)),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildStatRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(label),
//           Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
//         ],
//       ),
//     );
//   }

//   Widget _buildSquadStat(String label, String count, Color color) {
//     return Column(
//       children: [
//         Container(
//           width: 50,
//           height: 50,
//           decoration: BoxDecoration(
//             color: color.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(25),
//             border: Border.all(color: color, width: 2),
//           ),
//           child: Center(
//             child: Text(
//               count,
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: color,
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           label,
//           style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
//         ),
//       ],
//     );
//   }

//   Widget _buildPlayerTile(String name, String role, String stats, IconData icon, Color color) {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.05),
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: color.withOpacity(0.2)),
//       ),
//       child: Row(
//         children: [
//           CircleAvatar(
//             radius: 20,
//             backgroundColor: color.withOpacity(0.1),
//             child: Icon(icon, color: color, size: 20),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
//                 Text(role, style: const TextStyle(fontSize: 12, color: Colors.grey)),
//                 Text(stats, style: const TextStyle(fontSize: 12)),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildFormIndicator(String result, Color color) {
//     return Container(
//       width: 30,
//       height: 30,
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Center(
//         child: Text(
//           result,
//           style: const TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             fontSize: 12,
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Custom Painter for Bar Chart
// class BarChartPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.blue
//       ..strokeCap = StrokeCap.round;

//     final barWidth = size.width / 10;
//     final maxHeight = size.height * 0.8;

//     // Sample data for the chart
//     final List<double> data = [0.7, 0.5, 0.8, 0.6, 0.9, 0.4, 0.7, 0.6, 0.8, 0.5];

//     for (int i = 0; i < data.length; i++) {
//       final barHeight = maxHeight * data[i];
//       final x = i * barWidth + barWidth / 2;
//       final y = size.height - barHeight;

//       // Draw bar
//       canvas.drawRRect(
//         RRect.fromRectAndRadius(
//           Rect.fromLTWH(x - barWidth / 4, y, barWidth / 2, barHeight),
//           const Radius.circular(4),
//         ),
//         paint,
//       );

//       // Draw value text
//       final textPainter = TextPainter(
//         text: TextSpan(
//           text: (data[i] * 100).toInt().toString(),
//           style: const TextStyle(
//             color: Colors.black,
//             fontSize: 10,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         textDirection: TextDirection.ltr,
//       );

//       textPainter.layout();
//       textPainter.paint(
//         canvas,
//         Offset(x - textPainter.width / 2, y - 20),
//       );
//     }

//     // Draw labels
//     final labels = ['Over 1-2', '3-4', '5-6', '7-8', '9-10', '11-12', '13-14', '15-16', '17-18', '19-20'];
//     for (int i = 0; i < labels.length; i++) {
//       final x = i * barWidth + barWidth / 2;
//       final textPainter = TextPainter(
//         text: TextSpan(
//           text: labels[i],
//           style: const TextStyle(
//             color: Colors.grey,
//             fontSize: 8,
//           ),
//         ),
//         textDirection: TextDirection.ltr,
//       );

//       textPainter.layout();
//       textPainter.paint(
//         canvas,
//         Offset(x - textPainter.width / 2, size.height - 15),
//       );
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MatchDetails extends StatefulWidget {
  const MatchDetails({super.key});

  @override
  State<MatchDetails> createState() => _MatchDetailsState();
}

class _MatchDetailsState extends State<MatchDetails>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 7, vsync: this); // Updated length to 7
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Match Center',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        // backgroundColor: Colors.teal,
        foregroundColor: Colors.black,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Colors.black,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.blue,
          tabs: const [
            Tab(icon: Icon(Icons.add_circle), text: 'Create Match'),
            Tab(icon: Icon(Icons.group_add), text: 'Create Team'), // New tab
            Tab(icon: Icon(Icons.sports_cricket), text: 'Live Score'),
            Tab(icon: Icon(Icons.schedule), text: 'Upcoming'),
            Tab(icon: Icon(Icons.history), text: 'Past Matches'),
            Tab(icon: Icon(Icons.analytics), text: 'Match Stats'),
            Tab(icon: Icon(Icons.supervised_user_circle), text: 'Team Details'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          CreateMatchTab(),
          CreateTeamTab(), // New tab widget
          LiveScoreTab(),
          UpcomingMatchesTab(),
          PastMatchesTab(),
          MatchStatsTab(),
          TeamDetailsTab(),
        ],
      ),
    );
  }
}

// New Create Team Tab
class CreateTeamTab extends StatefulWidget {
  const CreateTeamTab({super.key});

  @override
  State<CreateTeamTab> createState() => _CreateTeamTabState();
}

class _CreateTeamTabState extends State<CreateTeamTab> {
  final _formKey = GlobalKey<FormState>();
  final _teamNameController = TextEditingController();
  final _coachController = TextEditingController();
  final _captainController = TextEditingController();
  final _viceCaptainController = TextEditingController();

  String _teamType = 'Professional';
  String _homeGround = '';
  List<Map<String, dynamic>> _players = [];

  @override
  void dispose() {
    _teamNameController.dispose();
    _coachController.dispose();
    _captainController.dispose();
    _viceCaptainController.dispose();
    super.dispose();
  }

  void _addPlayer() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String playerName = '';
        String playerRole = 'Batsman';
        String battingStyle = 'Right-handed';
        String bowlingStyle = 'Right-arm Fast';

        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Add Player'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Player Name',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) => playerName = value,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: playerRole,
                      decoration: const InputDecoration(
                        labelText: 'Role',
                        border: OutlineInputBorder(),
                      ),
                      items:
                          ['Batsman', 'Bowler', 'All-rounder', 'Wicket Keeper']
                              .map((role) => DropdownMenuItem(
                                    value: role,
                                    child: Text(role),
                                  ))
                              .toList(),
                      onChanged: (value) =>
                          setDialogState(() => playerRole = value!),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: battingStyle,
                      decoration: const InputDecoration(
                        labelText: 'Batting Style',
                        border: OutlineInputBorder(),
                      ),
                      items: ['Right-handed', 'Left-handed']
                          .map((style) => DropdownMenuItem(
                                value: style,
                                child: Text(style),
                              ))
                          .toList(),
                      onChanged: (value) =>
                          setDialogState(() => battingStyle = value!),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: bowlingStyle,
                      decoration: const InputDecoration(
                        labelText: 'Bowling Style',
                        border: OutlineInputBorder(),
                      ),
                      items: [
                        'Right-arm Fast',
                        'Left-arm Fast',
                        'Right-arm Spin',
                        'Left-arm Spin',
                        'Right-arm Medium',
                        'Left-arm Medium',
                        'None'
                      ]
                          .map((style) => DropdownMenuItem(
                                value: style,
                                child: Text(style),
                              ))
                          .toList(),
                      onChanged: (value) =>
                          setDialogState(() => bowlingStyle = value!),
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
                  onPressed: () {
                    if (playerName.isNotEmpty) {
                      setState(() {
                        _players.add({
                          'name': playerName,
                          'role': playerRole,
                          'battingStyle': battingStyle,
                          'bowlingStyle': bowlingStyle,
                        });
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _removePlayer(int index) {
    setState(() {
      _players.removeAt(index);
    });
  }

  Color _getRoleColor(String role) {
    switch (role) {
      case 'Batsman':
        return Colors.green;
      case 'Bowler':
        return Colors.red;
      case 'All-rounder':
        return Colors.orange;
      case 'Wicket Keeper':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  IconData _getRoleIcon(String role) {
    switch (role) {
      case 'Batsman':
        return Icons.trending_up;
      case 'Bowler':
        return Icons.sports_cricket;
      case 'All-rounder':
        return Icons.all_inclusive;
      case 'Wicket Keeper':
        return Icons.sports_baseball;
      default:
        return Icons.person;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const Text(
              'Create New Team',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Team Basic Info
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Team Information',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _teamNameController,
                              decoration: const InputDecoration(
                                labelText: 'Team Name',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.group),
                              ),
                              validator: (value) => value?.isEmpty ?? true
                                  ? 'Please enter team name'
                                  : null,
                            ),
                            const SizedBox(height: 16),
                            DropdownButtonFormField<String>(
                              value: _teamType,
                              decoration: const InputDecoration(
                                labelText: 'Team Type',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.category),
                              ),
                              items: [
                                'Professional',
                                'Club',
                                'School',
                                'College',
                                'Corporate'
                              ]
                                  .map((type) => DropdownMenuItem(
                                        value: type,
                                        child: Text(type),
                                      ))
                                  .toList(),
                              onChanged: (value) =>
                                  setState(() => _teamType = value!),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Home Ground',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.location_on),
                              ),
                              onSaved: (value) => _homeGround = value ?? '',
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _coachController,
                              decoration: const InputDecoration(
                                labelText: 'Coach Name',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.person_outline),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Leadership
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Team Leadership',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _captainController,
                              decoration: const InputDecoration(
                                labelText: 'Captain',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.stars),
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _viceCaptainController,
                              decoration: const InputDecoration(
                                labelText: 'Vice Captain',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.star_outline),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Players Section
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Players (${_players.length})',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                ElevatedButton.icon(
                                  onPressed: _addPlayer,
                                  icon: const Icon(Icons.add),
                                  label: const Text('Add Player'),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            // Players List
                            if (_players.isEmpty)
                              Container(
                                padding: const EdgeInsets.all(32),
                                child: const Column(
                                  children: [
                                    Icon(Icons.group_add,
                                        size: 64, color: Colors.grey),
                                    SizedBox(height: 16),
                                    Text(
                                      'No players added yet',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.grey),
                                    ),
                                    Text(
                                      'Tap "Add Player" to start building your team',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              )
                            else
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: _players.length,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 8),
                                itemBuilder: (context, index) {
                                  final player = _players[index];
                                  return Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: _getRoleColor(player['role'])
                                          .withOpacity(0.05),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: _getRoleColor(player['role'])
                                            .withOpacity(0.2),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 20,
                                          backgroundColor:
                                              _getRoleColor(player['role'])
                                                  .withOpacity(0.1),
                                          child: Icon(
                                            _getRoleIcon(player['role']),
                                            color:
                                                _getRoleColor(player['role']),
                                            size: 20,
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                player['name'],
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                player['role'],
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: _getRoleColor(
                                                      player['role']),
                                                ),
                                              ),
                                              Text(
                                                '${player['battingStyle']} • ${player['bowlingStyle']}',
                                                style: const TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () => _removePlayer(index),
                                          icon: const Icon(Icons.delete,
                                              color: Colors.red),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),

                            // Team Composition Summary
                            if (_players.isNotEmpty) ...[
                              const SizedBox(height: 16),
                              const Divider(),
                              const SizedBox(height: 8),
                              const Text(
                                'Team Composition',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                children: [
                                  _buildCompositionChip(
                                      'Batsmen',
                                      _players
                                          .where((p) => p['role'] == 'Batsman')
                                          .length,
                                      Colors.green),
                                  _buildCompositionChip(
                                      'Bowlers',
                                      _players
                                          .where((p) => p['role'] == 'Bowler')
                                          .length,
                                      Colors.red),
                                  _buildCompositionChip(
                                      'All-rounders',
                                      _players
                                          .where(
                                              (p) => p['role'] == 'All-rounder')
                                          .length,
                                      Colors.orange),
                                  _buildCompositionChip(
                                      'W. Keepers',
                                      _players
                                          .where((p) =>
                                              p['role'] == 'Wicket Keeper')
                                          .length,
                                      Colors.blue),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Create Team Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            if (_teamNameController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Please enter team name')),
                              );
                              return;
                            }
                            if (_players.length < 11) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Incomplete Team'),
                                  content: Text(
                                      'A cricket team needs at least 11 players. You have ${_players.length} players.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Continue Adding'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        _createTeam();
                                      },
                                      child: const Text('Create Anyway'),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              _createTeam();
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text('Create Team',
                            style: TextStyle(fontSize: 16)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompositionChip(String label, int count, Color color) {
    return Chip(
      label: Text('$label: $count'),
      backgroundColor: color.withOpacity(0.1),
      side: BorderSide(color: color.withOpacity(0.3)),
      labelStyle: TextStyle(
        color: color,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  void _createTeam() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'Team "${_teamNameController.text}" created successfully with ${_players.length} players!'),
        backgroundColor: Colors.green,
      ),
    );

    // Reset form
    _formKey.currentState!.reset();
    _teamNameController.clear();
    _coachController.clear();
    _captainController.clear();
    _viceCaptainController.clear();
    setState(() {
      _players.clear();
      _teamType = 'Professional';
      _homeGround = '';
    });
  }
}

// Create Match Tab
class CreateMatchTab extends StatefulWidget {
  const CreateMatchTab({super.key});

  @override
  State<CreateMatchTab> createState() => _CreateMatchTabState();
}

class _CreateMatchTabState extends State<CreateMatchTab> {
  final _formKey = GlobalKey<FormState>();
  String _team1 = '';
  String _team2 = '';
  String _venue = '';
  DateTime _matchDate = DateTime.now();
  TimeOfDay _matchTime = TimeOfDay.now();
  String _matchType = 'T20';
  String _typeball = 'Tennis';

  String _formatTime(TimeOfDay time) {
    final hour = time.hour;
    final minute = time.minute;
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '${displayHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            const Text(
              'Create New Match',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Team 1',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.group),
              ),
              onSaved: (value) => _team1 = value ?? '',
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Please enter team name' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Team 2',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.group),
              ),
              onSaved: (value) => _team2 = value ?? '',
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Please enter team name' : null,
            ),

            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Venue',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.location_on),
              ),
              onSaved: (value) => _venue = value ?? '',
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Please enter venue' : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _matchType,
              decoration: const InputDecoration(
                labelText: 'Match Type',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.sports_cricket),
              ),
              items: ['T20', 'ODI', 'Test']
                  .map((type) => DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      ))
                  .toList(),
              onChanged: (value) => setState(() => _matchType = value!),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _typeball,
              decoration: const InputDecoration(
                  labelText: 'Type of ball',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(FontAwesomeIcons.baseball, size: 30)),
              items: ['Tennis', 'Leather', 'Others']
                  .map((type) => DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      ))
                  .toList(),
              onChanged: (value) => setState(() => _typeball = value!),
            ),
            const SizedBox(height: 16),
            ListTile(
              title: Text(
                  'Date: ${_matchDate.day.toString().padLeft(2, '0')}-${_matchDate.month.toString().padLeft(2, '0')}-${_matchDate.year} at ${_formatTime(_matchTime)}'),
              leading: const Icon(Icons.calendar_today),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _matchDate.isAfter(DateTime.now())
                      ? _matchDate
                      : DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (date != null) {
                  setState(() {
                    _matchDate = date;
                  });
                }
              },
            ),
            const SizedBox(height: 8),
            ListTile(
              title: Text('Time: ${_formatTime(_matchTime)}'),
              leading: const Icon(Icons.access_time),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () async {
                final time = await showTimePicker(
                  context: context,
                  initialTime: _matchTime,
                );
                if (time != null) {
                  setState(() {
                    _matchTime = time;
                  });
                }
              },
            ),
            const SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () {
            //     if (_formKey.currentState!.validate()) {
            //       _formKey.currentState!.save();
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         SnackBar(
            //           content: Text('Match scheduled for ${_matchDate.day.toString().padLeft(2, '0')}-${_matchDate.month.toString().padLeft(2, '0')}-${_matchDate.year} at ${_formatTime(_matchTime)}'),
            //         ),
            //       );
            //     }
            //   },
            //   child: const Text('Create Match',style: TextStyle(color: Colors.black),),
            // ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal, // Button background
                foregroundColor: Colors.white, // Text color
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Rounded edges
                ),
                elevation: 5, // Shadow depth
                shadowColor: Colors.tealAccent.withOpacity(0.5),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.teal,
                      content: Text(
                        'Match scheduled for ${_matchDate.day.toString().padLeft(2, '0')}-${_matchDate.month.toString().padLeft(2, '0')}-${_matchDate.year} at ${_formatTime(_matchTime)}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                }
              },
              child: const Text(
                'Create Match',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Live Score Tab
class LiveScoreTab extends StatelessWidget {
  const LiveScoreTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            elevation: 4,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    'India vs Australia',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text('IND', style: TextStyle(fontSize: 16)),
                          Text('185/6',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold)),
                          Text('(18.4 overs)', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      Text('vs', style: TextStyle(fontSize: 18)),
                      Column(
                        children: [
                          Text('AUS', style: TextStyle(fontSize: 16)),
                          Text('142/8',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold)),
                          Text('(16.2 overs)', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'India won by 43 runs',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                _buildPlayerStats('Virat Kohli', '75*', '52 balls, 8x4, 2x6'),
                _buildPlayerStats('Steve Smith', '45', '38 balls, 5x4, 1x6'),
                _buildPlayerStats('Jasprit Bumrah', '3/25', '4 overs'),
                _buildPlayerStats('Pat Cummins', '2/35', '4 overs'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerStats(String name, String score, String details) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.person)),
        title: Text(name),
        subtitle: Text(details),
        trailing:
            Text(score, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}

// Upcoming Matches Tab
class UpcomingMatchesTab extends StatelessWidget {
  const UpcomingMatchesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: const Icon(Icons.schedule, color: Colors.orange),
            title: Text('Match ${index + 1}: Team A vs Team B'),
            subtitle: Text(
                'Date: ${DateTime.now().add(Duration(days: index + 1)).toLocal()}'
                    .split(' ')[0]),
            trailing: const Text('T20'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Match ${index + 1} details')),
              );
            },
          ),
        );
      },
    );
  }
}

// Past Matches Tab
class PastMatchesTab extends StatelessWidget {
  const PastMatchesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 10,
      itemBuilder: (context, index) {
        final results = [
          'Won',
          'Lost',
          'Won',
          'Won',
          'Lost',
          'Won',
          'Lost',
          'Won',
          'Won',
          'Lost'
        ];
        final colors = [Colors.green, Colors.red];
        final resultColor = results[index] == 'Won' ? colors[0] : colors[1];

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: Icon(Icons.sports_cricket, color: resultColor),
            title: Text('India vs Team ${String.fromCharCode(65 + index)}'),
            subtitle: Text(
                'Date: ${DateTime.now().subtract(Duration(days: index + 1)).toLocal()}'
                    .split(' ')[0]),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: resultColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                results[index],
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
        );
      },
    );
  }
}

// Match Stats Tab
class MatchStatsTab extends StatelessWidget {
  const MatchStatsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Match Statistics',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // MVP Section
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text('Player of the Match',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        child: Icon(Icons.person, size: 30),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Virat Kohli',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Text('75* runs (52 balls)'),
                            Text('Strike Rate: 144.23'),
                          ],
                        ),
                      ),
                      Icon(Icons.star, color: Colors.amber, size: 30),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Best Bowler Section
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text('Best Bowler',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        child: Icon(Icons.person, size: 30),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Jasprit Bumrah',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Text('3/25 (4 overs)'),
                            Text('Economy: 6.25'),
                          ],
                        ),
                      ),
                      Icon(Icons.sports_cricket, color: Colors.blue, size: 30),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Battle of the Match
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Battle of the Match',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  const Text('Kohli vs Cummins'),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            const Text('Virat Kohli',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            Container(
                              height: 8,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text('18 runs scored',
                                style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      const Text('vs'),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          children: [
                            const Text('Pat Cummins',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            Container(
                              height: 8,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text('0 wickets taken',
                                style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Performance Chart
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Team Performance',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 200,
                    child: CustomPaint(
                      painter: BarChartPainter(),
                      size: const Size(double.infinity, 200),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Match Summary Stats
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Match Summary',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  _buildStatRow('Total Runs', '327'),
                  _buildStatRow('Total Wickets', '14'),
                  _buildStatRow('Total Boundaries', '32'),
                  _buildStatRow('Total Sixes', '8'),
                  _buildStatRow('Highest Partnership', '89 runs'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class TeamDetailsTab extends StatelessWidget {
  const TeamDetailsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Team Details',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // Team Header Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.sports_cricket,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Team India',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text('ICC Ranking: #1'),
                        Text('Captain: Rohit Sharma'),
                        Text('Coach: Rahul Dravid'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Captain Section
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Captain',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        child: Icon(Icons.person, size: 30),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Rohit Sharma',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Text('Batsman • Right-handed'),
                            Text('Matches: 243 • Runs: 9782'),
                          ],
                        ),
                      ),
                      Icon(Icons.stars, color: Colors.amber, size: 30),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Vice Captain Section
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Vice Captain',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        child: Icon(Icons.person, size: 30),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Hardik Pandya',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Text('All-rounder • Right-handed'),
                            Text('Matches: 89 • Runs: 1769'),
                          ],
                        ),
                      ),
                      Icon(Icons.sports_cricket,
                          color: Colors.orange, size: 30),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Squad Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Squad Overview',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildSquadStat('Batsmen', '6', Colors.green),
                      _buildSquadStat('Bowlers', '5', Colors.red),
                      _buildSquadStat('All-rounders', '3', Colors.orange),
                      _buildSquadStat('W. Keepers', '2', Colors.blue),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Key Players Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Key Players',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  _buildPlayerTile('Virat Kohli', 'Batsman', '12738 runs',
                      Icons.trending_up, Colors.green),
                  const SizedBox(height: 8),
                  _buildPlayerTile('Jasprit Bumrah', 'Bowler', '138 wickets',
                      Icons.sports_cricket, Colors.red),
                  const SizedBox(height: 8),
                  _buildPlayerTile(
                      'Ravindra Jadeja',
                      'All-rounder',
                      '2706 runs, 220 wickets',
                      Icons.all_inclusive,
                      Colors.orange),
                  const SizedBox(height: 8),
                  _buildPlayerTile('KL Rahul', 'Wicket Keeper', '2321 runs',
                      Icons.sports_baseball, Colors.blue),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Team Statistics
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Team Statistics',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  _buildStatRow('Matches Played', '567'),
                  _buildStatRow('Matches Won', '298'),
                  _buildStatRow('Win Percentage', '52.6%'),
                  _buildStatRow('Highest Score', '418/5'),
                  _buildStatRow('Lowest Score', '36'),
                  _buildStatRow('Current Streak', '3 wins'),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Recent Form
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Recent Form (Last 10 matches)',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildFormIndicator('W', Colors.green),
                      _buildFormIndicator('W', Colors.green),
                      _buildFormIndicator('L', Colors.red),
                      _buildFormIndicator('W', Colors.green),
                      _buildFormIndicator('W', Colors.green),
                      _buildFormIndicator('L', Colors.red),
                      _buildFormIndicator('W', Colors.green),
                      _buildFormIndicator('W', Colors.green),
                      _buildFormIndicator('W', Colors.green),
                      _buildFormIndicator('L', Colors.red),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text('7 Wins, 3 Losses',
                      style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildSquadStat(String label, String count, Color color) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: color, width: 2),
          ),
          child: Center(
            child: Text(
              count,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildPlayerTile(
      String name, String role, String stats, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: color.withOpacity(0.1),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(role,
                    style: const TextStyle(fontSize: 12, color: Colors.grey)),
                Text(stats, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormIndicator(String result, Color color) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(
          result,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

// Custom Painter for Bar Chart
class BarChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round;

    final barWidth = size.width / 10;
    final maxHeight = size.height * 0.8;

    // Sample data for the chart
    final List<double> data = [
      0.7,
      0.5,
      0.8,
      0.6,
      0.9,
      0.4,
      0.7,
      0.6,
      0.8,
      0.5
    ];

    for (int i = 0; i < data.length; i++) {
      final barHeight = maxHeight * data[i];
      final x = i * barWidth + barWidth / 2;
      final y = size.height - barHeight;

      // Draw bar
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x - barWidth / 4, y, barWidth / 2, barHeight),
          const Radius.circular(4),
        ),
        paint,
      );

      // Draw value text
      final textPainter = TextPainter(
        text: TextSpan(
          text: (data[i] * 100).toInt().toString(),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(x - textPainter.width / 2, y - 20),
      );
    }

    // Draw labels
    final labels = [
      'Over 1-2',
      '3-4',
      '5-6',
      '7-8',
      '9-10',
      '11-12',
      '13-14',
      '15-16',
      '17-18',
      '19-20'
    ];
    for (int i = 0; i < labels.length; i++) {
      final x = i * barWidth + barWidth / 2;
      final textPainter = TextPainter(
        text: TextSpan(
          text: labels[i],
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 8,
          ),
        ),
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(x - textPainter.width / 2, size.height - 15),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
