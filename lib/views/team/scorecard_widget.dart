import 'package:flutter/material.dart';

class ScorecardWidget extends StatelessWidget {
  const ScorecardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tabs
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTab("1st innings", false),
              _buildTab("2nd innings", true),
            ],
          ),
          const SizedBox(height: 12),

          // Batting card
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Team A Batting",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 8),
                _buildBattingHeader(),
                const Divider(),
                _buildBatsmanRow("Player A1", "Yet to bat", "", "", "", ""),
                _buildBatsmanRow("Player A2", "5", "2", "0", "0", "250.00",
                    isNotOut: true),
                _buildBatsmanRow("Player A3", "1", "1", "1", "0", "250.00"),
                _buildBatsmanRow("Player A4", "Yet to bat", "", "", "", ""),
                _buildBatsmanRow("Player A5", "Yet to bat", "", "", "", ""),
                _buildBatsmanRow("Player A6", "Yet to bat", "", "", "", ""),
                _buildBatsmanRow("Player A7", "Yet to bat", "", "", "", ""),
                _buildBatsmanRow("Player A8", "Yet to bat", "", "", "", ""),
                _buildBatsmanRow("Player A9", "Yet to bat", "", "", "", ""),
                _buildBatsmanRow("Player A10", "Yet to bat", "", "", "", ""),
                _buildBatsmanRow("Player A11", "Yet to bat", "", "", "", ""),
                const Divider(),
                const Text("Extras: 0 (B: 0, LB: 0, WD: 0, NB: 0)"),
                const SizedBox(height: 4),
                const Text("Total: 6/0 (0.3 Overs)",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Bowling card
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Team B Bowling",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 8),
                _buildBowlingHeader(),
                const Divider(),
                _buildBowlerRow("Player B3", "0.3", "0", "6", "0", "0", "0",
                    "12.00"),
                const SizedBox(height: 8),
                const Text("Left Arm Medium",
                    style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String title, bool selected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? Colors.blue : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: selected ? Colors.white : Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildBattingHeader() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(flex: 3, child: Text("BATSMAN")),
        Expanded(child: Text("R")),
        Expanded(child: Text("B")),
        Expanded(child: Text("4s")),
        Expanded(child: Text("6s")),
        Expanded(child: Text("SR")),
      ],
    );
  }

  Widget _buildBatsmanRow(
      String name, String r, String b, String fours, String sixes, String sr,
      {bool isNotOut = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              flex: 3,
              child: Text(
                isNotOut ? "$name *" : name,
                style: const TextStyle(fontWeight: FontWeight.w500),
              )),
          Expanded(child: Text(r)),
          Expanded(child: Text(b)),
          Expanded(child: Text(fours)),
          Expanded(child: Text(sixes)),
          Expanded(child: Text(sr)),
        ],
      ),
    );
  }

  Widget _buildBowlingHeader() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(flex: 3, child: Text("BOWLER")),
        Expanded(child: Text("O")),
        Expanded(child: Text("M")),
        Expanded(child: Text("R")),
        Expanded(child: Text("W")),
        Expanded(child: Text("WD")),
        Expanded(child: Text("NB")),
        Expanded(child: Text("ECON")),
      ],
    );
  }

  Widget _buildBowlerRow(String name, String o, String m, String r, String w,
      String wd, String nb, String econ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            flex: 3,
            child: Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.w500),
            )),
        Expanded(child: Text(o)),
        Expanded(child: Text(m)),
        Expanded(child: Text(r)),
        Expanded(child: Text(w)),
        Expanded(child: Text(wd)),
        Expanded(child: Text(nb)),
        Expanded(child: Text(econ)),
      ],
    );
  }
}
