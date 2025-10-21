import 'package:booking_application/views/Games/games_view_screen.dart';
import 'package:flutter/material.dart';

class MatchDetailsCard extends StatelessWidget {
  final MatchData match;
  final String status;
  final VoidCallback? onStartMatch;
  final VoidCallback? onViewLive;
  final VoidCallback? onViewDetails;

  const MatchDetailsCard({
    Key? key,
    required this.match,
    required this.status,
    this.onStartMatch,
    this.onViewLive,
    this.onViewDetails,
  }) : super(key: key);

  // Helper method to get game image URL based on category
  String _getGameImageUrl(String categoryName) {
    switch (categoryName.toLowerCase()) {
      case 'football':
      case 'soccer':
        return 'https://images.unsplash.com/photo-1579952363873-27f3bade9f55?w=400';
      case 'badminton':
        return 'https://images.unsplash.com/photo-1626224583764-f87db24ac4ea?w=400';
      case 'cricket':
        return 'https://images.unsplash.com/photo-1531415074968-036ba1b575da?w=400';
      case 'tennis':
        return 'https://images.unsplash.com/photo-1554068865-24cecd4e34b8?w=400';
      case 'basketball':
        return 'https://images.unsplash.com/photo-1546519638-68e109498ffc?w=400';
      case 'volleyball':
        return 'https://images.unsplash.com/photo-1612872087720-bb876e2e67d1?w=400';
      case 'tennis':
        return 'https://images.unsplash.com/photo-1609710228159-0fa9bd7c0827?w=400';
      case 'hockey':
        return 'https://images.unsplash.com/photo-1515703407324-5f753afd8be8?w=400';
      default:
        return 'https://images.unsplash.com/photo-1461896836934-ffe607ba8211?w=400';
    }
  }

  // Helper method to get game color based on category
  Color _getGameColor(String categoryName) {
    switch (categoryName.toLowerCase()) {
      case 'football':
      case 'soccer':
        return const Color(0xFF2E7D32);
      case 'badminton':
        return const Color(0xFF1976D2);
      case 'cricket':
        return const Color(0xFFE65100);
      case 'tennis':
        return const Color(0xFF7B1FA2);
      case 'basketball':
        return const Color(0xFFD84315);
      case 'volleyball':
        return const Color(0xFF0277BD);
      case 'table tennis':
      case 'tennis':
        return const Color(0xFFC62828);
      case 'hockey':
        return const Color(0xFF00695C);
      default:
        return const Color(0xFF616161);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 3,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              Colors.grey.shade50,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMatchTitleWithImage(),
                  const SizedBox(height: 12),
                  _buildMatchInfo(),
                  const SizedBox(height: 16),
                  _buildParticipantsSection(),
                  const SizedBox(height: 20),
                  _buildActionButtons(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: _getStatusColor().withOpacity(0.1),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _getStatusColor(),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: _getStatusColor().withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _getStatusIcon(),
                  size: 14,
                  color: Colors.white,
                ),
                const SizedBox(width: 6),
                Text(
                  _getStatusText(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Icon(
            Icons.calendar_today,
            size: 14,
            color: Colors.grey.shade600,
          ),
          const SizedBox(width: 6),
          Text(
            _formatDateTime(match.createdAt),
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // NEW: Match title with game image
  Widget _buildMatchTitleWithImage() {
    return Row(
      children: [
        // Game Image Container
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _getGameColor(match.categoryName).withOpacity(0.3),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: _getGameColor(match.categoryName).withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              _getGameImageUrl(match.categoryName),
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                // Fallback to icon if image fails to load
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        _getGameColor(match.categoryName),
                        _getGameColor(match.categoryName).withOpacity(0.7),
                      ],
                    ),
                  ),
                  child: Icon(
                    Icons.sports,
                    color: Colors.white,
                    size: 32,
                  ),
                );
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                  ),
                  child: Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        _getGameColor(match.categoryName),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(width: 16),
        // Match Name
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                match.name,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getGameColor(match.categoryName).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  match.categoryName,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getGameColor(match.categoryName),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMatchInfo() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          _buildInfoChip(
            icon: Icons.sports_score,
            label: match.scoringMethod,
          ),
          Container(
            width: 1,
            height: 20,
            color: Colors.grey.shade300,
            margin: const EdgeInsets.symmetric(horizontal: 12),
          ),
          _buildInfoChip(
            icon: match.gameMode == 'team' ? Icons.groups : Icons.person,
            label: match.gameMode == 'team' ? 'Team' : 'Singles',
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip({required IconData icon, required String label}) {
    return Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: const Color(0xFF2E7D32)),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade800,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParticipantsSection() {
    if (match.teams.isNotEmpty) {
      return _buildParticipantCard(
        icon: Icons.groups_rounded,
        title: 'Teams Participating',
        count: '${match.teams.length} teams',
        color: const Color(0xFF2E7D32),
      );
    } else if (match.players.isNotEmpty) {
      return _buildParticipantCard(
        icon: Icons.person_rounded,
        title: 'Players',
        count: match.players.join(', '),
        color: const Color(0xFF1976D2),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildParticipantCard({
    required IconData icon,
    required String title,
    required String count,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 24, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  count,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey.shade900,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    if (status == 'upcoming') {
      return Row(
        children: [
          Expanded(
            flex: 2,
            child: ElevatedButton.icon(
              onPressed: onStartMatch,
              icon: const Icon(Icons.play_arrow, size: 20),
              label: const Text('Start Match'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E7D32),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
            ),
          ),
        ],
      );
    } else if (status == 'live') {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: onViewLive,
          icon: const Icon(Icons.visibility, size: 20),
          label: const Text('View Live Match'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFD32F2F),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
        ),
      );
    }else if(status == 'cancel'){
      return SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: (){},
          icon: const Icon(Icons.info_outline, size: 20),
          label: const Text('Match cancelled'),
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFF2E7D32),
            side: const BorderSide(color: Color(0xFF2E7D32), width: 1.5),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      );
    } else {
      return SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: onViewDetails,
          icon: const Icon(Icons.info_outline, size: 20),
          label: const Text('View Details'),
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFF2E7D32),
            side: const BorderSide(color: Color(0xFF2E7D32), width: 1.5),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      );
    }
  }

  Color _getStatusColor() {
    switch (status.toLowerCase()) {
      case 'live':
        return const Color(0xFFD32F2F);
      case 'upcoming':
        return const Color(0xFF1976D2);
      case 'completed':
        return const Color(0xFF388E3C);
      default:
        return const Color(0xFF757575);
    }
  }

  IconData _getStatusIcon() {
    switch (status.toLowerCase()) {
      case 'live':
        return Icons.circle;
      case 'upcoming':
        return Icons.schedule;
      case 'completed':
        return Icons.check_circle;
      default:
        return Icons.info;
    }
  }

  String _getStatusText() {
    switch (status.toLowerCase()) {
      case 'live':
        return 'LIVE';
      case 'upcoming':
        return 'UPCOMING';
      case 'completed':
        return 'COMPLETED';
      default:
        return status.toUpperCase();
    }
  }

  String _formatDateTime(DateTime dateTime) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[dateTime.month - 1]} ${dateTime.day}, ${dateTime.year}';
  }
}