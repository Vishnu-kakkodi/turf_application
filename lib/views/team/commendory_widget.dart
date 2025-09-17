import 'package:flutter/material.dart';

class CommentaryWidget extends StatelessWidget {
  final List<String> commentary;

  const CommentaryWidget({super.key, required this.commentary});

  @override
  Widget build(BuildContext context) {
    return Align( // 👈 keep widget aligned instead of stretched
      alignment: Alignment.topCenter,
      child: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // 👈 shrink to fit content
          children: [
            const Text(
              "Commentary",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 8),
            ...commentary.map((line) => Text(line)).toList(),
          ],
        ),
      ),
    );
  }
}
