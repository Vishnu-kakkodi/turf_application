import 'package:flutter/material.dart';

class MvpLeaderboardWidget extends StatelessWidget {
  final List<Map<String, dynamic>> leaderboard;

  const MvpLeaderboardWidget({super.key, required this.leaderboard});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "MVP Leaderboard",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text("PLAYER", style: TextStyle(fontWeight: FontWeight.bold))),
              Text("POINTS", style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const Divider(),
          ...leaderboard.map((entry) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(entry["player"])),
                  Text(entry["points"].toString()),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
