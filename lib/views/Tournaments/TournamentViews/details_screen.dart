import 'package:booking_application/views/Tournaments/TournamentModel/tournament.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:share_plus/share_plus.dart';

class TournamentDetailScreen extends StatelessWidget {
  final Tournament tournament;

  const TournamentDetailScreen({
    Key? key,
    required this.tournament,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          tournament.name,
          style: const TextStyle(
            color: Color(0xFF2E7D32),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF333333)),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Color(0xFF2E7D32)),
            onPressed: () => _shareTournament(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tournament Header Card
            _buildHeaderCard(),
            const SizedBox(height: 20),
            
            // Tournament Details
            _buildDetailsSection(),
            const SizedBox(height: 20),
            
            // Tournament Information
            _buildInformationSection(),
            const SizedBox(height: 20),
            
            // Rules and Prizes
            if (tournament.rules.isNotEmpty || tournament.prizes.isNotEmpty)
              _buildRulesAndPrizesSection(),
            
            const SizedBox(height: 30),
            
            // Action Buttons
            _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2E7D32), Color(0xFF4CAF50)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2E7D32).withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  tournament.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  _getStatusText(tournament.status),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            tournament.description,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.white, size: 16),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  tournament.location,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE0E0E0)),
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
            'Tournament Details',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 16),
          
          // Date Information
          _buildDetailRow(
            icon: Icons.event_available,
            label: 'Tournament Period',
            value: '${_formatDate(tournament.startDate)} - ${_formatDate(tournament.endDate)}',
          ),
          const SizedBox(height: 12),
          
          _buildDetailRow(
            icon: Icons.event_busy,
            label: 'Registration Ends',
            value: _formatDate(tournament.registrationEndDate),
          ),
          const SizedBox(height: 12),
          
          // Tournament Info
          _buildDetailRow(
            icon: Icons.groups,
            label: 'Number of Teams',
            value: '${tournament.numberOfTeams} teams',
          ),
          const SizedBox(height: 12),
          
          _buildDetailRow(
            icon: Icons.sports_esports,
            label: 'Format',
            value: tournament.format,
          ),
          const SizedBox(height: 12),
          
          // Entry Fee
          _buildDetailRow(
            icon: Icons.monetization_on,
            label: 'Entry Fee',
            value: tournament.isPaidEntry 
                ? '₹${tournament.entryFee!.toStringAsFixed(0)}' 
                : 'Free Entry',
          ),
        ],
      ),
    );
  }

  Widget _buildInformationSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Additional Information',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 16),
          
          _buildInfoRow(
            label: 'Tournament ID',
            value: tournament.id,
          ),
          const SizedBox(height: 8),
          
          _buildInfoRow(
            label: 'Created On',
            value: _formatDateTime(tournament.createdAt),
          ),
          const SizedBox(height: 8),
          
          _buildInfoRow(
            label: 'Tournament Type',
            value: tournament.isPaidEntry ? 'Paid Tournament' : 'Free Tournament',
          ),
        ],
      ),
    );
  }

  Widget _buildRulesAndPrizesSection() {
    return Column(
      children: [
        if (tournament.rules.isNotEmpty) ...[
          _buildTextSection(
            title: 'Rules & Regulations',
            content: tournament.rules,
            icon: Icons.rule,
          ),
          const SizedBox(height: 20),
        ],
        
        if (tournament.prizes.isNotEmpty) ...[
          _buildTextSection(
            title: 'Prizes & Awards',
            content: tournament.prizes,
            icon: Icons.emoji_events,
          ),
        ],
      ],
    );
  }

  Widget _buildTextSection({
    required String title,
    required String content,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE0E0E0)),
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
          Row(
            children: [
              Icon(icon, color: const Color(0xFF2E7D32), size: 22),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF666666),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        // Share Tournament Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () => _shareTournament(context),
            icon: const Icon(Icons.share, color: Colors.white),
            label: const Text(
              'Share Tournament Link',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E7D32),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        
        // Copy Link Button
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () => _copyTournamentLink(context),
            icon: const Icon(Icons.copy, color: Color(0xFF2E7D32)),
            label: const Text(
              'Copy Tournament Link',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFF2E7D32),
              ),
            ),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: const BorderSide(color: Color(0xFF2E7D32)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
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
        Icon(icon, color: const Color(0xFF2E7D32), size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF666666),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF333333),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow({
    required String label,
    required String value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF666666),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF333333),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
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

  String _formatDateTime(DateTime date) {
    return '${_formatDate(date)} at ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  String _generateTournamentLink() {
    // Generate a shareable link for the tournament
    // In a real app, this would be your app's deep link or web URL
    return 'https://yourapp.com/tournament/${tournament.id}';
  }

  void _shareTournament(BuildContext context) {
    final String tournamentLink = _generateTournamentLink();
    final String shareText = '''
🏆 ${tournament.name}

📝 ${tournament.description}

📅 ${_formatDate(tournament.startDate)} - ${_formatDate(tournament.endDate)}
📍 ${tournament.location}
👥 ${tournament.numberOfTeams} teams
🎮 ${tournament.format}
💰 ${tournament.isPaidEntry ? '₹${tournament.entryFee!.toStringAsFixed(0)}' : 'Free Entry'}

Join the tournament: $tournamentLink

#Tournament #Sports #Competition
''';

    // Share.share(shareText, subject: 'Join ${tournament.name} Tournament');
  }

  void _copyTournamentLink(BuildContext context) {
    final String tournamentLink = _generateTournamentLink();
    
    Clipboard.setData(ClipboardData(text: tournamentLink));
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white, size: 20),
            SizedBox(width: 8),
            Text('Tournament link copied to clipboard!'),
          ],
        ),
        backgroundColor: const Color(0xFF2E7D32),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}