
// innings_break_dialog.dart
import 'package:flutter/material.dart';

class InningsBreakDialog extends StatelessWidget {
  final int targetRuns;
  final Function() onStartChase;
  
  const InningsBreakDialog({
    Key? key,
    required this.targetRuns,
    required this.onStartChase,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.sports_cricket,
              size: 48,
              color: Colors.lightBlue,
            ),
            const SizedBox(height: 16),
            const Text(
              'Innings Break',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.lightBlue,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'First Innings Complete!',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Column(
                children: [
                  const Text(
                    'Team B needs',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$targetRuns runs',
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlue,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'in 2 overs to win',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onStartChase,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Start Second Innings',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}