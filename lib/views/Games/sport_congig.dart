

// Enum for different score types
enum ScoreType {
  goalBased,
  setBased,
  winBased,
  pointBased
}

// Enum for different sports
enum SportType {
  badminton,
  tennis,
  football,
  chess,
  volleyball,
  pickleball,
  golf
}


// Model class for sport configuration
class SportConfig {
  final SportType sport;
  final ScoreType scoreType;
  final bool isTeamBased;
  final int? winConditions;
  final List<int>? setOptions; // For set-based games like [3, 5]
  final String displayName;

  const SportConfig({
    required this.sport,
    required this.scoreType,
    this.winConditions,
    required this.isTeamBased,
    this.setOptions,
    required this.displayName,
  });

  // Create a copy with different parameters
  SportConfig copyWith({
    SportType? sport,
    ScoreType? scoreType,
    bool? isTeamBased,
    List<int>? setOptions,
    String? displayName,
  }) {
    return SportConfig(
      sport: sport ?? this.sport,
      scoreType: scoreType ?? this.scoreType,
      isTeamBased: isTeamBased ?? this.isTeamBased,
      setOptions: setOptions ?? this.setOptions,
      displayName: displayName ?? this.displayName,
    );
  }
}



// Sport configurations - now only contains base sport info
class SportConfigurations {
  static const Map<SportType, SportConfig> configs = {
    SportType.badminton: SportConfig(
      sport: SportType.badminton,
      scoreType: ScoreType.setBased, // Default, but will be selectable
      isTeamBased: false,
      setOptions: [3, 5],
      displayName: 'Badminton',
      winConditions: null,
    ),
    SportType.tennis: SportConfig(
      sport: SportType.tennis,
      scoreType: ScoreType.setBased,
      isTeamBased: false,
      setOptions: [3, 5],
      displayName: 'Tennis',
      winConditions: null,
    ),
    SportType.football: SportConfig(
      sport: SportType.football,
      scoreType: ScoreType.goalBased,
      isTeamBased: true,
      setOptions: [3, 5],
      displayName: 'Football',
      winConditions: null,
    ),
    SportType.chess: SportConfig(
      sport: SportType.chess,
      scoreType: ScoreType.winBased,
      isTeamBased: false,
      setOptions: [3, 5],
      displayName: 'Chess',
      winConditions: null,
    ),
    SportType.volleyball: SportConfig(
      sport: SportType.volleyball,
      scoreType: ScoreType.setBased,
      isTeamBased: true,
      setOptions: [3, 5],
      displayName: 'Volleyball',
      winConditions: null,
    ),
    SportType.pickleball: SportConfig(
      sport: SportType.pickleball,
      scoreType: ScoreType.pointBased,
      isTeamBased: false,
      setOptions: [3, 5],
      displayName: 'Pickleball',
      winConditions: null,
    ),
    SportType.golf: SportConfig(
      sport: SportType.golf,
      scoreType: ScoreType.pointBased,
      isTeamBased: false,
      setOptions: [3, 5],
      displayName: 'Golf',
      winConditions: null,
    ),
  };

  static SportConfig? getConfig(SportType sport) => configs[sport];

  // Get all available score types for any sport
  static List<ScoreType> getAvailableScoreTypes() {
    return [
      ScoreType.goalBased,
      ScoreType.setBased,
      ScoreType.winBased,
      ScoreType.pointBased,
    ];
  }

  // Get description for score type
  static String getScoreTypeDescription(ScoreType scoreType) {
    switch (scoreType) {
      case ScoreType.goalBased:
        return 'Track goals, runs, or similar scoring events';
      case ScoreType.setBased:
        return 'Play in sets with best of format (3 or 5 sets)';
      case ScoreType.winBased:
        return 'Simple win/loss tracking';
      case ScoreType.pointBased:
        return 'Track individual points or scores';
    }
  }
}