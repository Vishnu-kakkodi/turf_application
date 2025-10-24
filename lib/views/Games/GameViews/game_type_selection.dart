import 'package:booking_application/views/Games/GameViews/format_selection.dart';
import 'package:booking_application/views/Games/GameViews/participants_selection.dart';
import 'package:booking_application/views/Games/sport_congig.dart';
import 'package:flutter/material.dart';

class ScoreTypeSelectionScreen extends StatefulWidget {
  final SportConfig baseSportConfig;
  final String categoryName;
  final String userId;
  final String categoryId;

  const ScoreTypeSelectionScreen({
    super.key,
    required this.baseSportConfig,
    required this.categoryName,
    required this.userId,
    required this.categoryId,
  });

  @override
  State<ScoreTypeSelectionScreen> createState() =>
      _ScoreTypeSelectionScreenState();
}

class _ScoreTypeSelectionScreenState extends State<ScoreTypeSelectionScreen> {
  ScoreType? selectedScoreType;

  // Map category -> allowed score types
  List<ScoreType> _getAllowedScoreTypes(String categoryName) {
    switch (categoryName.toLowerCase()) {
      case "football":
        return [ScoreType.goalBased];
      case "chess":
        return [ScoreType.winBased];
      case "tennis":
      case "badminton":
      case "volleyball":
      case "pickleball":
        return [ScoreType.setBased];
      case "golf":
        return [ScoreType.pointBased];
      default:
        // fallback: show all
        return SportConfigurations.getAvailableScoreTypes();
    }
  }

  @override
  Widget build(BuildContext context) {
    final allowedScoreTypes = _getAllowedScoreTypes(widget.categoryName);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Setup: ${widget.baseSportConfig.displayName}',
          style: const TextStyle(
            color: Color(0xFF2E7D32),
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF2E7D32)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select scoring method.',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF666666),
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: ListView.builder(
                  itemCount: allowedScoreTypes.length,
                  itemBuilder: (context, index) {
                    final scoreType = allowedScoreTypes[index];
                    final isSelected = selectedScoreType == scoreType;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedScoreType = scoreType;
                          });
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFF2E7D32)
                                  : const Color(0xFFE0E0E0),
                              width: isSelected ? 2 : 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xFF2E7D32).withOpacity(0.1)
                                      : const Color(0xFFF5F5F5),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Icon(
                                  _getScoreTypeIcon(scoreType),
                                  color: isSelected
                                      ? const Color(0xFF2E7D32)
                                      : const Color(0xFF666666),
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _getScoreTypeText(scoreType),
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: isSelected
                                            ? const Color(0xFF2E7D32)
                                            : const Color(0xFF333333),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      SportConfigurations
                                          .getScoreTypeDescription(scoreType),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF666666),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (isSelected)
                                const Icon(
                                  Icons.check_circle,
                                  color: Color(0xFF2E7D32),
                                  size: 24,
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              if (selectedScoreType != null)
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () => _proceedToNextStep(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E7D32),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Continue with ${_getScoreTypeText(selectedScoreType!)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getScoreTypeIcon(ScoreType scoreType) {
    switch (scoreType) {
      case ScoreType.goalBased:
        return Icons.sports_score;
      case ScoreType.setBased:
        return Icons.looks_3;
      case ScoreType.winBased:
        return Icons.emoji_events;
      case ScoreType.pointBased:
        return Icons.timeline;
    }
  }

  String _getScoreTypeText(ScoreType scoreType) {
    switch (scoreType) {
      case ScoreType.goalBased:
        return 'Goal Based';
      case ScoreType.setBased:
        return 'Set Based';
      case ScoreType.winBased:
        return 'Win Based';
      case ScoreType.pointBased:
        return 'Point Based';
    }
  }

  void _proceedToNextStep() {
    if (selectedScoreType == null) return;

    final updatedConfig = widget.baseSportConfig.copyWith(
      scoreType: selectedScoreType,
    );

    switch (selectedScoreType!) {
      case ScoreType.goalBased:
      case ScoreType.winBased:
      case ScoreType.pointBased:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ParticipantSelectionScreen(
              sportConfig: updatedConfig,
              categoryId: widget.categoryId,
            ),
          ),
        );
        break;
      case ScoreType.setBased:
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => SetFormatSelectionScreen(
        //       sportConfig: updatedConfig,
        //       categoryId: widget.categoryId,
        //     ),
        //   ),
        // );

                Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ParticipantSelectionScreen(
              sportConfig: updatedConfig,
              setFormat: 2,
              categoryId: widget.categoryId,
            ),
          ),
        );
        break;
    }
  }
}
