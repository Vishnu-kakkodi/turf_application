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
//   String _matchType = 'T20';
//   String _typeball='Tennis';

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
//               ListTile(
//               title: Text('Match Date: ${_matchDate.day}/${_matchDate.month}/${_matchDate.year}'),
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
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 if (_formKey.currentState!.validate()) {
//                   _formKey.currentState!.save();
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text('Match created successfully!')),
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
//                 Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
//                 Text(role, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
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
//       width: 24,
//       height: 24,
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Center(
//         child: Text(
//           result,
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 12,
//             fontWeight: FontWeight.bold,
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
//     final paint = Paint()..style = PaintingStyle.fill;
    
//     // Sample data for team runs per over
//     final data = [6, 8, 12, 15, 9, 11, 14, 16, 10, 13, 18, 20, 8, 15, 12, 14, 16, 19, 7, 11];
//     final barWidth = size.width / data.length * 0.8;
//     final maxValue = data.reduce((a, b) => a > b ? a : b).toDouble();
    
//     for (int i = 0; i < data.length; i++) {
//       final barHeight = (data[i] / maxValue) * size.height * 0.8;
//       final x = i * (size.width / data.length) + (size.width / data.length - barWidth) / 2;
//       final y = size.height - barHeight;
      
//       paint.color = i % 2 == 0 ? Colors.blue : Colors.orange;
//       canvas.drawRect(
//         Rect.fromLTWH(x, y, barWidth, barHeight),
//         paint,
//       );
      
//       // Draw over number
//       final textPainter = TextPainter(
//         text: TextSpan(
//           text: '${i + 1}',
//           style: const TextStyle(color: Colors.black, fontSize: 10),
//         ),
//         textDirection: TextDirection.ltr,
//       );
//       textPainter.layout();
//       textPainter.paint(canvas, Offset(x + barWidth / 2 - textPainter.width / 2, size.height - 15));
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
    _tabController = TabController(length: 6, vsync: this);
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
        title: const Text('Match Center',style: TextStyle(fontWeight: FontWeight.bold),),
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
                prefixIcon: Icon(FontAwesomeIcons.baseball, size: 30)
              ),
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
              title: Text('Date: ${_matchDate.day.toString().padLeft(2, '0')}-${_matchDate.month.toString().padLeft(2, '0')}-${_matchDate.year} at ${_formatTime(_matchTime)}'),
              leading: const Icon(Icons.calendar_today),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _matchDate.isAfter(DateTime.now()) ? _matchDate : DateTime.now(),
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
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Match scheduled for ${_matchDate.day.toString().padLeft(2, '0')}-${_matchDate.month.toString().padLeft(2, '0')}-${_matchDate.year} at ${_formatTime(_matchTime)}'),
                    ),
                  );
                }
              },
              child: const Text('Create Match'),
            ),
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
               const   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                           Text('IND', style: TextStyle(fontSize: 16)),
                           Text('185/6', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                           Text('(18.4 overs)', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                       Text('vs', style: TextStyle(fontSize: 18)),
                      Column(
                        children: [
                           Text('AUS', style: TextStyle(fontSize: 16)),
                           Text('142/8', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
        trailing: Text(score, style: const TextStyle(fontWeight: FontWeight.bold)),
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
            subtitle: Text('Date: ${DateTime.now().add(Duration(days: index + 1)).toLocal()}'.split(' ')[0]),
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
        final results = ['Won', 'Lost', 'Won', 'Won', 'Lost', 'Won', 'Lost', 'Won', 'Won', 'Lost'];
        final colors = [Colors.green, Colors.red];
        final resultColor = results[index] == 'Won' ? colors[0] : colors[1];
        
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: Icon(Icons.sports_cricket, color: resultColor),
            title: Text('India vs Team ${String.fromCharCode(65 + index)}'),
            subtitle: Text('Date: ${DateTime.now().subtract(Duration(days: index + 1)).toLocal()}'.split(' ')[0]),
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
        const  Card(
            child: Padding(
              padding:  EdgeInsets.all(16),
              child: Column(
                children: [
                   Text('Player of the Match', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                            Text('Virat Kohli', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
        const  Card(
            child: Padding(
              padding:  EdgeInsets.all(16),
              child: Column(
                children: [
                   Text('Best Bowler', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                            Text('Jasprit Bumrah', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
                  const Text('Battle of the Match', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  const Text('Kohli vs Cummins'),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            const Text('Virat Kohli', style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            Container(
                              height: 8,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text('18 runs scored', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      const Text('vs'),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          children: [
                            const Text('Pat Cummins', style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            Container(
                              height: 8,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text('0 wickets taken', style: TextStyle(fontSize: 12)),
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
                  const Text('Team Performance', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                  const Text('Match Summary', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                  Text('Captain', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                            Text('Rohit Sharma', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
                  Text('Vice Captain', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                            Text('Hardik Pandya', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            Text('All-rounder • Right-handed'),
                            Text('Matches: 89 • Runs: 1769'),
                          ],
                        ),
                      ),
                      Icon(Icons.sports_cricket, color: Colors.orange, size: 30),
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
                  const Text('Squad Overview', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                  const Text('Key Players', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  _buildPlayerTile('Virat Kohli', 'Batsman', '12738 runs', Icons.trending_up, Colors.green),
                  const SizedBox(height: 8),
                  _buildPlayerTile('Jasprit Bumrah', 'Bowler', '138 wickets', Icons.sports_cricket, Colors.red),
                  const SizedBox(height: 8),
                  _buildPlayerTile('Ravindra Jadeja', 'All-rounder', '2706 runs, 220 wickets', Icons.all_inclusive, Colors.orange),
                  const SizedBox(height: 8),
                  _buildPlayerTile('KL Rahul', 'Wicket Keeper', '2321 runs', Icons.sports_baseball, Colors.blue),
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
                  const Text('Team Statistics', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                  const Text('Recent Form (Last 10 matches)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                  const Text('7 Wins, 3 Losses', style: TextStyle(fontSize: 12, color: Colors.grey)),
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
  
  Widget _buildPlayerTile(String name, String role, String stats, IconData icon, Color color) {
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
                Text(role, style: const TextStyle(fontSize: 12, color: Colors.grey)),
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
    final List<double> data = [0.7, 0.5, 0.8, 0.6, 0.9, 0.4, 0.7, 0.6, 0.8, 0.5];
    
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
    final labels = ['Over 1-2', '3-4', '5-6', '7-8', '9-10', '11-12', '13-14', '15-16', '17-18', '19-20'];
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






// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

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

// // QR Code Scanner Screen
// class QRCodeScannerScreen extends StatefulWidget {
//   final String matchId;
//   final String team1;
//   final String team2;
//   final String venue;
  
//   const QRCodeScannerScreen({
//     super.key,
//     required this.matchId,
//     required this.team1,
//     required this.team2,
//     required this.venue,
//   });

//   @override
//   State<QRCodeScannerScreen> createState() => _QRCodeScannerScreenState();
// }

// class _QRCodeScannerScreenState extends State<QRCodeScannerScreen> {
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   QRViewController? controller;
//   String? scannedData;

//   @override
//   void reassemble() {
//     super.reassemble();
//     if (controller != null) {
//       controller!.pauseCamera();
//       controller!.resumeCamera();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Scan QR Code'),
//         backgroundColor: Colors.teal,
//         foregroundColor: Colors.white,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.flash_on),
//             onPressed: () async {
//               await controller?.toggleFlash();
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           // Match Info Header
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.all(16),
//             color: Colors.teal.shade50,
//             child: Column(
//               children: [
//                 Text(
//                   'Match Created Successfully!',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.teal.shade700,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   '${widget.team1} vs ${widget.team2}',
//                   style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//                 ),
//                 Text(
//                   'Venue: ${widget.venue}',
//                   style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   'Match ID: ${widget.matchId}',
//                   style: TextStyle(fontSize: 12, color: Colors.grey[500]),
//                 ),
//               ],
//             ),
//           ),
          
//           // Instructions
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               children: [
//                 const Icon(
//                   Icons.qr_code_scanner,
//                   size: 48,
//                   color: Colors.teal,
//                 ),
//                 const SizedBox(height: 8),
//                 const Text(
//                   'Scan QR Code to Join Match',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   'Ask players to scan the QR code to join this match',
//                   style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             ),
//           ),
          
//           // QR Scanner
//           Expanded(
//             flex: 4,
//             child: Container(
//               margin: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(color: Colors.teal, width: 2),
//               ),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(10),
//                 child: QRView(
//                   key: qrKey,
//                   onQRViewCreated: _onQRViewCreated,
//                   overlay: QrScannerOverlayShape(
//                     borderColor: Colors.teal,
//                     borderRadius: 10,
//                     borderLength: 30,
//                     borderWidth: 10,
//                     cutOutSize: 250,
//                   ),
//                 ),
//               ),
//             ),
//           ),
          
//           // Scanned Data Display
//           if (scannedData != null)
//             Container(
//               width: double.infinity,
//               margin: const EdgeInsets.all(16),
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.green.shade50,
//                 borderRadius: BorderRadius.circular(8),
//                 border: Border.all(color: Colors.green),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Scanned Data:',
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(scannedData!),
//                 ],
//               ),
//             ),
          
//           // Action Buttons
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton.icon(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     icon: const Icon(Icons.arrow_back),
//                     label: const Text('Back to Match'),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.grey[300],
//                       foregroundColor: Colors.black,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 Expanded(
//                   child: ElevatedButton.icon(
//                     onPressed: () {
//                       _showShareDialog(context);
//                     },
//                     icon: const Icon(Icons.share),
//                     label: const Text('Share Match'),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.teal,
//                       foregroundColor: Colors.white,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _onQRViewCreated(QRViewController controller) {
//     setState(() {
//       this.controller = controller;
//     });
//     controller.scannedDataStream.listen((scanData) {
//       setState(() {
//         scannedData = scanData.code;
//       });
//       // You can handle the scanned data here
//       _handleScannedData(scanData.code);
//     });
//   }

//   void _handleScannedData(String? data) {
//     if (data != null) {
//       // Handle the scanned QR code data
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Player joined: $data'),
//           backgroundColor: Colors.green,
//         ),
//       );
//     }
//   }

//   void _showShareDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Share Match'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Text('Share match details with players:'),
//             const SizedBox(height: 16),
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.grey[100],
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Match: ${widget.team1} vs ${widget.team2}'),
//                   Text('Venue: ${widget.venue}'),
//                   Text('Match ID: ${widget.matchId}'),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.pop(context);
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(content: Text('Match details shared!')),
//               );
//             },
//             child: const Text('Share'),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
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
//   String _matchType = 'T20';
//   String _typeball = 'Tennis';

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
//               title: Text('Match Date: ${_matchDate.day}/${_matchDate.month}/${_matchDate.year}'),
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
//             const SizedBox(height: 20),
//             ElevatedButton.icon(
//               onPressed: () {
//                 if (_formKey.currentState!.validate()) {
//                   _formKey.currentState!.save();
                  
//                   // Generate a unique match ID
//                   final matchId = 'MATCH_${DateTime.now().millisecondsSinceEpoch}';
                  
//                   // Navigate to QR Scanner screen
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => QRCodeScannerScreen(
//                         matchId: matchId,
//                         team1: _team1,
//                         team2: _team2,
//                         venue: _venue,
//                       ),
//                     ),
//                   );
//                 }
//               },
//               icon: const Icon(Icons.qr_code_scanner),
//               label: const Text('Create Match & Show QR Scanner'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.teal,
//                 foregroundColor: Colors.white,
//                 padding: const EdgeInsets.symmetric(vertical: 16),
//               ),
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
//            Card(
//             child: Padding(
//               padding: EdgeInsets.all(16),
// child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text('Vice Captain', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 10),
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
//                             Text('Batsman • Right-handed'),
//                             Text('Matches: 262 • Runs: 12169'),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         padding:  EdgeInsets.all(4),
//                         decoration: BoxDecoration(
//                           color: Colors.orange,
//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                         child: const Text(
//                           'VC',
//                           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                         ),
//                       ),
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
//                   const Text('Squad', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 16),
                  
//                   // Batsmen
//                   const Text('Batsmen', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.blue)),
//                   const SizedBox(height: 8),
//                   _buildPlayerTile('Rohit Sharma', 'C', Icons.star),
//                   _buildPlayerTile('Virat Kohli', 'VC', Icons.star_border),
//                   _buildPlayerTile('Shubman Gill', '', Icons.sports_cricket),
//                   _buildPlayerTile('KL Rahul', 'WK', Icons.sports_cricket),
                  
//                   const SizedBox(height: 16),
                  
//                   // All-rounders
//                   const Text('All-rounders', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.green)),
//                   const SizedBox(height: 8),
//                   _buildPlayerTile('Hardik Pandya', '', Icons.sports_cricket),
//                   _buildPlayerTile('Ravindra Jadeja', '', Icons.sports_cricket),
//                   _buildPlayerTile('Axar Patel', '', Icons.sports_cricket),
                  
//                   const SizedBox(height: 16),
                  
//                   // Bowlers
//                   const Text('Bowlers', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.red)),
//                   const SizedBox(height: 8),
//                   _buildPlayerTile('Jasprit Bumrah', '', Icons.sports_cricket),
//                   _buildPlayerTile('Mohammed Shami', '', Icons.sports_cricket),
//                   _buildPlayerTile('Kuldeep Yadav', '', Icons.sports_cricket),
//                   _buildPlayerTile('Mohammed Siraj', '', Icons.sports_cricket),
//                 ],
//               ),
//             ),
//           ),
          
//           const SizedBox(height: 16),
          
//           // Team Stats
//           Card(
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text('Team Statistics', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 16),
//                   _buildStatRow('Matches Played', '156'),
//                   _buildStatRow('Matches Won', '98'),
//                   _buildStatRow('Matches Lost', '52'),
//                   _buildStatRow('Win Percentage', '62.8%'),
//                   _buildStatRow('Highest Score', '418/5'),
//                   _buildStatRow('Lowest Score', '92'),
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
//                   const Text(
//                     'W = Win, L = Loss',
//                     style: TextStyle(fontSize: 12, color: Colors.grey),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
  
//   Widget _buildPlayerTile(String name, String role, IconData icon) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         children: [
//           Icon(icon, size: 20, color: Colors.grey[600]),
//           const SizedBox(width: 12),
//           Expanded(child: Text(name)),
//           if (role.isNotEmpty)
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//               decoration: BoxDecoration(
//                 color: role == 'C' ? Colors.amber : Colors.orange,
//                 borderRadius: BorderRadius.circular(4),
//               ),
//               child: Text(
//                 role,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 10,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
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
  
//   Widget _buildFormIndicator(String result, Color color) {
//     return Container(
//       width: 24,
//       height: 24,
//       decoration: BoxDecoration(
//         color: color,
//         shape: BoxShape.circle,
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
//       ..style = PaintingStyle.fill;
    
//     final paint2 = Paint()
//       ..color = Colors.red
//       ..style = PaintingStyle.fill;
    
//     final barWidth = size.width / 10;
//     final maxHeight = size.height - 40;
    
//     // Sample data for demonstration
//     final data1 = [120, 150, 180, 140, 160]; // Team 1 scores
//     final data2 = [100, 130, 160, 120, 140]; // Team 2 scores
//     final maxValue = 200.0;
    
//     // Draw bars for Team 1
//     for (int i = 0; i < data1.length; i++) {
//       final barHeight = (data1[i] / maxValue) * maxHeight;
//       final rect = Rect.fromLTWH(
//         i * barWidth * 2,
//         size.height - barHeight,
//         barWidth * 0.8,
//         barHeight,
//       );
//       canvas.drawRect(rect, paint);
//     }
    
//     // Draw bars for Team 2
//     for (int i = 0; i < data2.length; i++) {
//       final barHeight = (data2[i] / maxValue) * maxHeight;
//       final rect = Rect.fromLTWH(
//         i * barWidth * 2 + barWidth * 0.8,
//         size.height - barHeight,
//         barWidth * 0.8,
//         barHeight,
//       );
//       canvas.drawRect(rect, paint2);
//     }
    
//     // Draw labels
//     final textPainter = TextPainter(
//       textDirection: TextDirection.ltr,
//     );
    
//     for (int i = 0; i < 5; i++) {
//       textPainter.text = TextSpan(
//         text: 'M${i + 1}',
//         style: const TextStyle(color: Colors.black, fontSize: 12),
//       );
//       textPainter.layout();
//       textPainter.paint(
//         canvas,
//         Offset(i * barWidth * 2 + barWidth * 0.4, size.height - 20),
//       );
//     }
//   }
  
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }