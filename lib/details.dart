import 'package:flutter/material.dart';

class EnrollDetails extends StatefulWidget {
  const EnrollDetails({super.key});

  @override
  State<EnrollDetails> createState() => _EnrollDetailsState();
}

class _EnrollDetailsState extends State<EnrollDetails>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'Tournament Details',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black87,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isDesktop = constraints.maxWidth > 900;
          
          if (isDesktop) {
            return _buildDesktopLayout();
          } else {
            return _buildMobileLayout();
          }
        },
      ),
    );
  }

  Widget _buildDesktopLayout(){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left side - Main content
        Expanded(
          flex: 3,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildTournamentHeader(),
                _buildInfoCards(),
                _buildTabSection(),
              ],
            ),
          ),
        ),
        
        // Right side - Registration and Help
        Container(
          width: 300,
          color: Colors.white,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildRegistrationCard(),
                const SizedBox(height: 20),
                _buildHelpCard(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildTournamentHeader(),
          _buildInfoCards(),
          const SizedBox(height: 16),
          _buildTabSection(),
        ],
      ),
    );
  }

  Widget _buildTournamentHeader() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.all(24.0),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Summer Cricket Championship 2025',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Join us for the annual Summer Cricket Championship. This tournament features teams from across the region competing in T20 format matches.',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF64748B),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCards() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return Row(
              children: [
                Expanded(child: _buildInfoCard(Icons.calendar_today, 'Duration', 'July 15 - July 30, 2025')),
                const SizedBox(width: 16),
                Expanded(child: _buildInfoCard(Icons.location_on, 'Location', 'Central Cricket Stadium')),
                const SizedBox(width: 16),
                Expanded(child: _buildInfoCard(Icons.people, 'Participants', '16 Teams/Players')),
                const SizedBox(width: 16),
                Expanded(child: _buildInfoCard(Icons.currency_rupee, 'Entry Fee', '₹2000 per team')),
              ],
            );
          } else {
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(child: _buildInfoCard(Icons.calendar_today, 'Duration', 'July 15 - July 30, 2025')),
                    const SizedBox(width: 16),
                    Expanded(child: _buildInfoCard(Icons.location_on, 'Location', 'Central Cricket Stadium')),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(child: _buildInfoCard(Icons.people, 'Participants', '16 Teams/Players')),
                    const SizedBox(width: 16),
                    Expanded(child: _buildInfoCard(Icons.currency_rupee, 'Entry Fee', '₹2000 per team')),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF2563EB), size: 16),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF64748B),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E293B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Tab Bar
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: const Color(0xFF2563EB),
              unselectedLabelColor: const Color(0xFF64748B),
              labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
              indicatorColor: const Color(0xFF2563EB),
              indicatorWeight: 2,
              tabs:const  [
                Tab(text: 'Schedule'),
                Tab(text: 'Rules'),
                Tab(text: 'Prizes',)
              ],
            ),
          ),
          
          // Tab Content
          SizedBox(
            height: 400,
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildScheduleTabWithRegister(),
                _buildRulesTabWithRegister(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleTabWithRegister() {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 80), // Added bottom padding for button
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tournament Schedule',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 16),
              _buildScheduleTable(),
            ],
          ),
        ),
        // Register Button positioned at bottom
        Positioned(
          left: 20,
          right: 20,
          bottom: 20,
          child: SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                // Add your registration logic here
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Registration clicked!')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2563EB),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Register',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildScheduleTable() {
    final scheduleData = [
      {'date': 'July 15, 2025', 'time': '10:00 AM', 'event': 'Opening Ceremony'},
      {'date': 'July 16, 2025', 'time': '11:30 AM', 'event': 'Group Stage Begins'},
      {'date': 'July 25, 2025', 'time': '09:00 AM', 'event': 'Quarter Finals'},
      {'date': 'July 28, 2025', 'time': '10:00 AM', 'event': 'Semi Finals'},
      {'date': 'July 30, 2025', 'time': '02:00 PM', 'event': 'Finals & Closing Ceremony'},
    ];

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE2E8F0)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: Color(0xFFF8FAFC),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: const Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Date',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF374151),
                      fontSize: 12,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Time',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF374151),
                      fontSize: 12,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Event',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF374151),
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Data rows
          ...scheduleData.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final isLast = index == scheduleData.length - 1;
            
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                border: isLast ? null : const Border(
                  bottom: BorderSide(color: Color(0xFFE2E8F0), width: 0.5),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      item['date']!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF374151),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item['time']!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF374151),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      item['event']!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF374151),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildRulesTabWithRegister() {
    return Stack(
      children: [
      const  SingleChildScrollView(
          padding:  EdgeInsets.fromLTRB(20, 20, 20, 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                'Tournament Rules',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
               SizedBox(height: 16),
               Text(
                '• All matches will be played in T20 format\n'
                '• Each team must have a minimum of 11 players and maximum of 15 players\n'
                '• Teams must arrive 30 minutes before their scheduled match\n'
                '• Standard ICC cricket rules will be followed\n'
                '• Disputes will be resolved by the tournament committee\n'
                '• Weather delays may result in match rescheduling\n'
                '• All players must have valid identification\n'
                '• Team captains are responsible for team conduct\n'
                '• No external coaching allowed during matches\n'
                '• Fair play and sportsmanship are mandatory',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF64748B),
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
        // Register Button positioned at bottom
        Positioned(
          left: 20,
          right: 20,
          bottom: 20,
          child: SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                // Add your registration logic here
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Registration clicked!')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2563EB),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Register',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRulesTab() {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tournament Rules',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          SizedBox(height: 16),
          Text(
            '• All matches will be played in T20 format\n'
            '• Each team must have a minimum of 11 players and maximum of 15 players\n'
            '• Teams must arrive 30 minutes before their scheduled match\n'
            '• Standard ICC cricket rules will be followed\n'
            '• Disputes will be resolved by the tournament committee\n'
            '• Weather delays may result in match rescheduling\n'
            '• All players must have valid identification\n'
            '• Team captains are responsible for team conduct\n'
            '• No external coaching allowed during matches\n'
            '• Fair play and sportsmanship are mandatory',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF64748B),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  // Keep the registration and help cards for desktop layout
  Widget _buildRegistrationCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Registration',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Registrations are open! Secure your spot today.',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 16),
          
          _buildRegistrationInfo('• Entry Fee: ₹2000 per team'),
          _buildRegistrationInfo('• Max Teams: 16'),
          _buildRegistrationInfo('• Last Date: July 5, 2025'),
          _buildRegistrationInfo('• Prizes Worth: ₹1L+'),
          _buildRegistrationInfo('• Limited Seats Available'),
        ],
      ),
    );
  }

  Widget _buildRegistrationInfo(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          color: Color(0xFF64748B),
        ),
      ),
    );
  }

  Widget _buildHelpCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Need Help?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Have questions about this tournament? Contact the organizers for more information.',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 44,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF2563EB),
                side: const BorderSide(color: Color(0xFF2563EB)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Contact Organizer',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}