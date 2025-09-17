
// select_batsman_dialog.dart
import 'package:flutter/material.dart';

class SelectBatsmanDialog extends StatefulWidget {
  final List<String> availablePlayers;
  final Function(String batsman) onBatsmanSelected;
  
  const SelectBatsmanDialog({
    Key? key,
    required this.availablePlayers,
    required this.onBatsmanSelected,
  }) : super(key: key);

  @override
  State<SelectBatsmanDialog> createState() => _SelectBatsmanDialogState();
}

class _SelectBatsmanDialogState extends State<SelectBatsmanDialog> {
  String? _selectedBatsman;

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
              'Select Next Batsman',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.lightBlue,
              ),
            ),
            const SizedBox(height: 16),
            
            const Text(
              'Incoming Batsman',
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
              items: widget.availablePlayers.map((player) {
                return DropdownMenuItem(value: player, child: Text(player));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedBatsman = value;
                });
              },
            ),
            
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _selectedBatsman != null ? () {
                  widget.onBatsmanSelected(_selectedBatsman!);
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