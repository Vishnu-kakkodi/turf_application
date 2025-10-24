import 'package:booking_application/helper/storage_helper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CompletedScreen extends StatefulWidget {
  final String matchId;

  const CompletedScreen({Key? key, required this.matchId}) : super(key: key);

  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
  bool isLoading = true;
  String? error;
  Map<String, dynamic>? matchData;
        String? userId;


@override
void initState() {
  super.initState();
  initData();
}

Future<void> initData() async {
  await loadUserId(); // ✅ Waits for user ID to finish loading
  fetchMatchData();   // ✅ Only called after user ID is ready
}


Future<void> loadUserId() async {
  final currentUser = await UserPreferences.getUser();
  if (!mounted) return; // prevents setState on unmounted widget
  setState(() {
    userId = currentUser?.id.toString();
  });
}


  Future<void> fetchMatchData() async { 
    try {
      
      final response = await http.get(
        Uri.parse('http://31.97.206.144:3081/users/completedmatches/${widget.matchId}'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          matchData = data['match'];
          isLoading = false;
        });
      } else {
        setState(() {
          error = 'Failed to load match data';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = 'Error: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.green.shade50, Colors.blue.shade50],
            ),
          ),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: Colors.green),
                SizedBox(height: 16),
                Text(
                  'Loading Scorecard...',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (error != null) {
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.green.shade50, Colors.blue.shade50],
            ),
          ),
          child: Center(
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                border: Border.all(color: Colors.red.shade300, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                error!,
                style: TextStyle(
                  color: Colors.red.shade700,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      );
    }

    final scorecard = matchData!['scorecard'];
    final innings1 = scorecard['innings'][0];
    final innings2 = scorecard['innings'][1];
    final summary = scorecard['matchSummary'];

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.green.shade50, Colors.blue.shade50],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Header Card
                _buildHeaderCard(summary),
                const SizedBox(height: 16),
                
                // Innings 1
                _buildInningsCard(innings1, Colors.blue),
                const SizedBox(height: 16),
                
                // Innings 2
                _buildInningsCard(innings2, Colors.purple),
                // const SizedBox(height: 16),
                
                // Top Performer
                // _buildTopPerformer(innings2),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard(Map<String, dynamic> summary) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.emoji_events, color: Colors.amber, size: 32),
                  const SizedBox(width: 12),
                  Text(
                    '${matchData!['matchType']} Match',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              // Container(
              //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              //   decoration: BoxDecoration(
              //     color: Colors.green.shade100,
              //     borderRadius: BorderRadius.circular(20),
              //   ),
              //   child: Text(
              //     summary['result'],
              //     style: TextStyle(
              //       color: Colors.green.shade800,
              //       fontWeight: FontWeight.w600,
              //     ),
              //   ),
              // ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade500, Colors.purple.shade500],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${summary['toss']['winnerName']} won the toss and elected to ${summary['toss']['elected']}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInningsCard(Map<String, dynamic> innings, Color accentColor) {
    final batting = innings['batting'] as List;
    final bowling = innings['bowling'] as List;
    final extras = innings['extras'];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Team Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.people, color: accentColor, size: 24),
                  const SizedBox(width: 8),
                  Text(
                    "Innings ${innings['inningsNumber'].toString()}",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${innings['totalRuns']}/${innings['totalWickets']}',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: accentColor,
                    ),
                  ),
                  Text(
                    '(${innings['totalOvers']} overs)',
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  Text(
                    'RR: ${innings['runRate'].toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 10, color: Colors.black45),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Batting Table
           Text(
            '${innings['battingTeam']['name']}    Batting',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(thickness: 2),
          _buildBattingTable(batting),
          const SizedBox(height: 8),
          Text(
            'Extras: ${extras['total']} (wd ${extras['wides']}, nb ${extras['noBalls']}, b ${extras['byes']}, lb ${extras['legByes']})',
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
          const SizedBox(height: 20),
          
          // Bowling Table
           Text(
            '${innings['bowlingTeam']['name']}    Bowling',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(thickness: 2),
          _buildBowlingTable(bowling),
        ],
      ),
    );
  }

  Widget _buildBattingTable(List batting) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(3),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(1),
        3: FlexColumnWidth(1),
        4: FlexColumnWidth(1),
        5: FlexColumnWidth(1.5),
      },
      children: [
        TableRow(
          decoration: BoxDecoration(color: Colors.grey.shade100),
          children: const [
            Padding(
              padding: EdgeInsets.all(8),
              child: Text('Batsman', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text('R', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text('B', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text('4s', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text('6s', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text('SR', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            ),
          ],
        ),
        ...batting.map((batsman) => TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(batsman['playerName'], style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12)),
                  Text(batsman['status'], style: TextStyle(fontSize: 10, color: Colors.green.shade700)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text('${batsman['runs']}', textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text('${batsman['balls']}', textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text('${batsman['fours']}', textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text('${batsman['sixes']}', textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text('${batsman['strikeRate'].toInt()}', textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
            ),
          ],
        )),
      ],
    );
  }

  Widget _buildBowlingTable(List bowling) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(3),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(1),
        3: FlexColumnWidth(1),
        4: FlexColumnWidth(1),
        5: FlexColumnWidth(1.5),
      },
      children: [
        TableRow(
          decoration: BoxDecoration(color: Colors.grey.shade100),
          children: const [
            Padding(
              padding: EdgeInsets.all(8),
              child: Text('Bowler', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text('O', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text('M', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text('R', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text('W', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text('Econ', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            ),
          ],
        ),
        ...bowling.map((bowler) => TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(bowler['playerName'], style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12)),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text('${bowler['overs']}', textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text('${bowler['maidens']}', textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text('${bowler['runs']}', textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text('${bowler['wickets']}', textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(bowler['economy'].toStringAsFixed(2), textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
            ),
          ],
        )),
      ],
    );
  }

  Widget _buildTopPerformer(Map<String, dynamic> innings2) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.yellow.shade400, Colors.orange.shade400],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.trending_up, color: Colors.white, size: 32),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Top Performer',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'kakkodi - 18 runs off 3 balls (SR: 600.00) with 3 sixes!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}