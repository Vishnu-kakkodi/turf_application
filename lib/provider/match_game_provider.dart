// match_game_provider.dart
import 'package:flutter/material.dart';

class MatchGameProvider with ChangeNotifier {
  // Teams
  final List<String> teamAPlayers = [
    'Player A1', 'Player A2', 'Player A3', 'Player A4', 'Player A5',
    'Player A6', 'Player A7', 'Player A8', 'Player A9', 'Player A10', 'Player A11'
  ];
  
  final List<String> teamBPlayers = [
    'Player B1', 'Player B2', 'Player B3', 'Player B4', 'Player B5',
    'Player B6', 'Player B7', 'Player B8', 'Player B9', 'Player B10', 'Player B11'
  ];

  // Match state
  String? tossWinner;
  String? electedTo;
  bool isFirstInnings = true;
  String battingTeam = 'Team A';
  String bowlingTeam = 'Team B';
  
  // Score tracking
  int teamAScore = 0;
  int teamBScore = 0;
  int teamAWickets = 0;
  int teamBWickets = 0;
  int currentOvers = 0;
  int currentBalls = 0;
  
  // Current players
  String striker = '';
  String nonStriker = '';
  String currentBowler = '';
  String currentBowlingStyle = '';
  
  // Player stats
  int strikerRuns = 0;
  int strikerBalls = 0;
  int nonStrikerRuns = 0;
  int nonStrikerBalls = 0;
  
  // Bowler stats
  int bowlerRuns = 0;
  int bowlerWickets = 0;
  int bowlerBalls = 0;
  
  // Current over
  List<String> currentOverBalls = [];
  List<String> outPlayers = [];

  bool isSecondInnings = false;
bool isOverComplete = false;
bool isInningsComplete = false;
bool isMatchComplete = false;
int target = 0;

  // Setters
  void setTossWinner(String winner) {
    tossWinner = winner;
    notifyListeners();
  }

  void setElectedTo(String elected) {
    electedTo = elected;
    if (tossWinner == 'Team A') {
      battingTeam = elected == 'Bat' ? 'Team A' : 'Team B';
      bowlingTeam = elected == 'Bat' ? 'Team B' : 'Team A';
    } else {
      battingTeam = elected == 'Bat' ? 'Team B' : 'Team A';
      bowlingTeam = elected == 'Bat' ? 'Team A' : 'Team B';
    }
    notifyListeners();
  }

  void setOpeningBatsmen(String striker, String nonStriker) {
    this.striker = striker;
    this.nonStriker = nonStriker;
    notifyListeners();
  }

  void setBowler(String bowler, String style) {
    currentBowler = bowler;
    currentBowlingStyle = style;
    notifyListeners();
  }

  // Getters
  List<String> getBattingTeamPlayers() {
    return battingTeam == 'Team A' ? teamAPlayers : teamBPlayers;
  }

  List<String> getBowlingTeamPlayers() {
    return bowlingTeam == 'Team A' ? teamAPlayers : teamBPlayers;
  }

  List<String> getAvailableBatsmen() {
    final battingPlayers = getBattingTeamPlayers();
    return battingPlayers.where((player) => 
      player != striker && 
      player != nonStriker && 
      !outPlayers.contains(player)
    ).toList();
  }

  String getOversString() {
    return '$currentOvers.$currentBalls';
  }

  String getRunRate() {
    if (currentOvers == 0 && currentBalls == 0) return '0.00';
    double totalOvers = currentOvers + (currentBalls / 6.0);
    int totalRuns = battingTeam == 'Team A' ? teamAScore : teamBScore;
    double runRate = totalRuns / totalOvers;
    return runRate.toStringAsFixed(2);
  }

  String getBowlerOvers() {
    int overs = bowlerBalls ~/ 6;
    int balls = bowlerBalls % 6;
    return '$overs.$balls';
  }

  String getBowlerEconomy() {
    if (bowlerBalls == 0) return '0.00';
    double overs = bowlerBalls / 6.0;
    double economy = bowlerRuns / overs;
    return economy.toStringAsFixed(2);
  }

  // Game actions
  void addRuns(int runs) {
    _addRuns(runs, runs.toString());
    _completeBall();
  }

  void addWide() {
    _addRuns(1, 'Wd');
    // Don't complete ball for wide
  }

  void addNoBall() {
    _addRuns(1, 'NB');
    // Don't complete ball for no ball
  }

  void addBye() {
    _addRuns(1, 'Bye');
    _completeBall();
  }

  void addLegBye() {
    _addRuns(1, 'LB');
    _completeBall();
  }

  void addWicket(String wicketType, String? fielder) {
    currentOverBalls.add('W');
    outPlayers.add(striker);
    
    if (battingTeam == 'Team A') {
      teamAWickets++;
    } else {
      teamBWickets++;
    }
    
    bowlerWickets++;
    _completeBall();
  }

  void setNewBatsman(String batsman) {
    striker = batsman;
    strikerRuns = 0;
    strikerBalls = 0;
    notifyListeners();
  }

  void _addRuns(int runs, String ballDisplay) {
    // Update team score
    if (battingTeam == 'Team A') {
      teamAScore += runs;
    } else {
      teamBScore += runs;
    }
    
    // Update striker stats (only for actual runs, not extras)
    if (!['Wd', 'NB', 'Bye', 'LB'].contains(ballDisplay)) {
      strikerRuns += runs;
      strikerBalls++;
    }
    
    // Update bowler stats
    bowlerRuns += runs;
    
    // Add to current over
    currentOverBalls.add(ballDisplay);
    
    // Swap strike for odd runs
    if (runs % 2 == 1) {
      _swapStrike();
    }
    
    notifyListeners();
  }

  void _completeBall() {
    if (!['Wd', 'NB'].contains(currentOverBalls.last)) {
      currentBalls++;
      bowlerBalls++;
      
      if (currentBalls == 6) {
        _completeOver();
      }
    }
    notifyListeners();
  }

  // void _completeOver() {
  //   currentOvers++;
  //   currentBalls = 0;
  //   currentOverBalls.clear();
  //   bowlerBalls = 0;
  //   bowlerRuns = 0;
  //   bowlerWickets = 0;
    
  //   // Swap strike at end of over
  //   _swapStrike();
    
  //   // Check for innings end or match end
  //   _checkInningsEnd();
    
  //   notifyListeners();
  // }

  void _swapStrike() {
    String temp = striker;
    striker = nonStriker;
    nonStriker = temp;
    
    int tempRuns = strikerRuns;
    strikerRuns = nonStrikerRuns;
    nonStrikerRuns = tempRuns;
    
    int tempBalls = strikerBalls;
    strikerBalls = nonStrikerBalls;
    nonStrikerBalls = tempBalls;
  }

  // void _checkInningsEnd() {
  //   int currentWickets = battingTeam == 'Team A' ? teamAWickets : teamBWickets;
    
  //   // Check if 10 wickets or overs completed (assuming 1 over match for demo)
  //   if (currentWickets >= 10 || currentOvers >= 1) {
  //     if (isFirstInnings) {
  //       _endFirstInnings();
  //     } else {
  //       _endMatch();
  //     }
  //   }
  // }

  // void _endFirstInnings() {
  //   isFirstInnings = false;
  //   // Swap teams
  //   String temp = battingTeam;
  //   battingTeam = bowlingTeam;
  //   bowlingTeam = temp;
    
  //   // Reset for second innings
  //   currentOvers = 0;
  //   currentBalls = 0;
  //   currentOverBalls.clear();
  //   outPlayers.clear();
    
  //   notifyListeners();
  // }

  void _endMatch() {
    // Match completed logic
    notifyListeners();
  }

  void undoLastBall() {
    // Simple undo implementation
    if (currentOverBalls.isNotEmpty) {
      currentOverBalls.removeLast();
      notifyListeners();
    }
  }

  String getRequiredRunRate() {
  if (!isSecondInnings) return '0.00';
  
  int remainingRuns = target - teamBScore;
  double remainingOvers = (1 - currentOvers) - (currentBalls / 6.0); // Assuming 1 over match
  
  if (remainingOvers <= 0) return '0.00';
  
  double requiredRate = remainingRuns / remainingOvers;
  return requiredRate.toStringAsFixed(2);
}

// Get available bowlers
List<String> getAvailableBowlers() {
  final bowlingPlayers = getBowlingTeamPlayers();
  // Return all bowling team players except current bowler
  return bowlingPlayers.where((player) => player != currentBowler).toList();
}

// Set next bowler
void setNextBowler(String bowler, String style) {
  currentBowler = bowler;
  currentBowlingStyle = style;
  isOverComplete = false;
  
  // Reset bowler stats for new bowler
  bowlerRuns = 0;
  bowlerWickets = 0;
  bowlerBalls = 0;
  
  notifyListeners();
}

// Start second innings
void startSecondInnings() {
  isSecondInnings = true;
  isInningsComplete = false;
  target = teamAScore + 1; // Target is first innings score + 1
  
  // Reset current players
  striker = '';
  nonStriker = '';
  strikerRuns = 0;
  strikerBalls = 0;
  nonStrikerRuns = 0;
  nonStrikerBalls = 0;
  
  // Reset bowler
  currentBowler = '';
  bowlerRuns = 0;
  bowlerWickets = 0;
  bowlerBalls = 0;
  
  notifyListeners();
}

// Get winner team
String getWinnerTeam() {
  if (!isMatchComplete) return '';
  
  if (isSecondInnings) {
    if (teamBScore >= target) {
      return battingTeam; // Current batting team won
    } else {
      return bowlingTeam; // Bowling team won
    }
  } else {
    // If match ends in first innings (all out), first batting team wins
    return battingTeam;
  }
}

// Get win margin
String getWinMargin() {
  if (!isMatchComplete) return '';
  
  if (isSecondInnings) {
    if (teamBScore >= target) {
      int wicketsLeft = 10 - teamBWickets;
      return '$wicketsLeft wickets';
    } else {
      int runs = target - teamBScore - 1;
      return '$runs runs';
    }
  }
  
  return '';
}

// Update the _completeOver method to set isOverComplete
void _completeOver() {
  currentOvers++;
  currentBalls = 0;
  isOverComplete = true; // Set this flag
  currentOverBalls.clear();
  
  // Don't reset bowler stats here if over is complete
  // They will be reset when new bowler is selected
  
  // Swap strike at end of over
  _swapStrike();
  
  // Check for innings end or match end
  _checkInningsEnd();
  
  notifyListeners();
}

// Update the _checkInningsEnd method
void _checkInningsEnd() {
  int currentWickets = battingTeam == 'Team A' ? teamAWickets : teamBWickets;
  int currentScore = battingTeam == 'Team A' ? teamAScore : teamBScore;
  
  // Check if 10 wickets or overs completed
  bool allOut = currentWickets >= 10;
  bool oversComplete = currentOvers >= 1; // Assuming 1 over match
  bool targetReached = isSecondInnings && currentScore >= target;
  
  if (allOut || oversComplete || targetReached) {
    if (isFirstInnings) {
      isInningsComplete = true;
      _endFirstInnings();
    } else {
      isMatchComplete = true;
      _endMatch();
    }
  }
}

// Update the _endFirstInnings method
void _endFirstInnings() {
  isFirstInnings = false;
  isInningsComplete = true;
  
  // Set target
  target = (battingTeam == 'Team A' ? teamAScore : teamBScore) + 1;
  
  // Don't swap teams here, it will be done in startSecondInnings
  
  notifyListeners();
}
}