
// select_next_bowler_dialog.dart
import 'package:flutter/material.dart';

class SelectNextBowlerDialog extends StatefulWidget {
  final List<String> availableBowlers;
  final Function(String bowler, String style) onBowlerSelected;
  
  const SelectNextBowlerDialog({
    Key? key,
    required this.availableBowlers,
    required this.onBowlerSelected,
  }) : super(key: key);

  @override
  State<SelectNextBowlerDialog> createState() => _SelectNextBowlerDialogState();
}

class _SelectNextBowlerDialogState extends State<SelectNextBowlerDialog> {
  String? _selectedBowler;
  String? _bowlingStyle;
  
  final List<String> _bowlingStyles = [
    'Fast',
    'Medium Fast',
    'Medium',
    'Off Spin',
    'Leg Spin',
    'Left Arm Orthodox',
    'Left Arm Chinaman',
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Next Bowler',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.lightBlue,
              ),
            ),
            const SizedBox(height: 16),
            
            const Text(
              'Bowler',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              items: widget.availableBowlers.map((bowler) {
                return DropdownMenuItem(value: bowler, child: Text(bowler));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedBowler = value;
                });
              },
            ),
            
            const SizedBox(height: 16),
            const Text(
              'Bowling Style',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              items: _bowlingStyles.map((style) {
                return DropdownMenuItem(value: style, child: Text(style));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _bowlingStyle = value;
                });
              },
            ),
            
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (_selectedBowler != null && _bowlingStyle != null) ? () {
                  widget.onBowlerSelected(_selectedBowler!, _bowlingStyle!);
                  Navigator.pop(context);
                } : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Confirm',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}