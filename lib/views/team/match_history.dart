import 'package:booking_application/helper/storage_helper.dart';
import 'package:booking_application/modal/match_model.dart';
import 'package:booking_application/provider/match_provider.dart';
import 'package:booking_application/views/team/chambion_screen.dart';
import 'package:booking_application/views/team/create_match.dart';
import 'package:booking_application/views/team/toss_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MatchesScreen extends StatefulWidget {
  const MatchesScreen({super.key});

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  String? userId;

  final List<String> statuses = [
    "Live",
    "UpComing",
    "Completed",
    "Cancelled",
    "Postponed",
  ];

  @override
  void initState() {
    super.initState();
    loadUserId();
    _tabController = TabController(length: statuses.length, vsync: this);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      _fetchMatches();
    });
  }

  void loadUserId() async {
    final currentUser = await UserPreferences.getUser();
    setState(() {
      userId = currentUser?.id.toString();
    });
    _fetchMatches();
  }

  void _fetchMatches() {
    if (userId != null) {
      final provider = Provider.of<MatchProvider>(context, listen: false);
      final status = statuses[_tabController.index];
      provider.loadMatchesByStatus(userId!, status);
    }
  }

  Widget _buildMatchCard(Match match) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title + Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                match.matchName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _getStatusBackgroundColor(match.status),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  match.status,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Category
          Row(
            children: [
              Icon(Icons.sports_cricket, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 8),
              Text(
                match.categoryName,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Date and Time
          Row(
            children: [
              Icon(Icons.calendar_today_outlined,
                  size: 16, color: Colors.grey[600]),
              const SizedBox(width: 8),
              Text(
                "${DateFormat('dd/MM/yyyy').format(match.dateTime)} ${DateFormat('hh:mm a').format(match.dateTime)}",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Location
          Row(
            children: [
              Icon(Icons.location_on_outlined,
                  size: 16, color: Colors.grey[600]),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  match.location,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 16),
              Icon(Icons.group_outlined, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(
                "${match.maxParticipants} Players",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Action button
          SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton(
              onPressed: () {
                match.status == "Live" ? 
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) =>CricketChampionshipScreen(matchId: match.id),
                  ),
                ):Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => TossScreen(
                      matchId: match.id,
                      userId: userId.toString(),
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2196F3),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child:  Text(
                match.status == "Live" ? "Continue" : "Start",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "live":
        return Colors.red;
      case "scheduled":
      case "upcoming":
        return Colors.orange;
      case "completed":
        return Colors.green;
      case "cancelled":
        return Colors.grey;
      case "postponed":
        return Colors.purple;
      default:
        return Colors.blueGrey;
    }
  }

  Color _getStatusBackgroundColor(String status) {
    switch (status.toLowerCase()) {
      case "live":
        return const Color(0xFFFF5252);
      case "scheduled":
      case "upcoming":
        return Colors.orange;
      case "completed":
        return Colors.green;
      case "cancelled":
        return Colors.grey;
      case "postponed":
        return Colors.purple;
      default:
        return Colors.blueGrey;
    }
  }

  Widget _buildEmptyState(String status) {
    return Center(
      child: Text("No $status matches"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Matches",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
              height: 50,
              color: Colors.white,
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey[600],
                indicatorSize: TabBarIndicatorSize.label,
                indicator: BoxDecoration(
                  color: const Color(0xFF2196F3),
                  borderRadius: BorderRadius.circular(20),
                ),
                labelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                tabs: statuses
                    .map((s) => Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8),
                          child: Text(s),
                        ))
                    .toList(),
              )),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<MatchProvider>(
              builder: (context, matchProvider, child) {
                final matches = matchProvider.currentMatches;
                final status = statuses[_tabController.index];

                if (matches.isEmpty) {
                  return _buildEmptyState(status);
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: matches.length,
                  itemBuilder: (context, index) {
                    return _buildMatchCard(matches[index]);
                  },
                );
              },
            ),
          ),
          // Create New Match Button
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => CreateMatchForm(
                      userId: userId.toString(),
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2196F3),
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: const Icon(
                Icons.add,
                color: Colors.white,
                size: 20,
              ),
              label: const Text(
                "Create a New Match",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
