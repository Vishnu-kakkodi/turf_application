import 'package:booking_application/views/Games/participants_selection.dart';
import 'package:booking_application/views/Games/sport_congig.dart';
import 'package:flutter/material.dart';

class SetFormatSelectionScreen extends StatefulWidget {
  final SportConfig sportConfig;
  final String categoryId;

  const SetFormatSelectionScreen({
    super.key,
    required this.sportConfig,
    required this.categoryId
  });

  @override
  State<SetFormatSelectionScreen> createState() => _SetFormatSelectionScreenState();
}

class _SetFormatSelectionScreenState extends State<SetFormatSelectionScreen> {
  int? selectedSetFormat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Setup: ${widget.sportConfig.displayName}',
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
                'Select the match format.',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF666666),
                ),
              ),
              const SizedBox(height: 40),
              ...widget.sportConfig.setOptions!.map((setCount) {
                final isSelected = selectedSetFormat == setCount;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedSetFormat = setCount;
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: isSelected ? const Color(0xFF2E7D32) : const Color(0xFFE0E0E0),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Best of $setCount',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? const Color(0xFF2E7D32) : const Color(0xFF333333),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'The first player/team to win ${(setCount / 2).ceil()} sets wins the match.',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xFF666666),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
              const Spacer(),
              if (selectedSetFormat != null)
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ParticipantSelectionScreen(
                            sportConfig: widget.sportConfig,
                            setFormat: selectedSetFormat,
                            categoryId: widget.categoryId,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E7D32),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Continue',
                      style: TextStyle(
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
}