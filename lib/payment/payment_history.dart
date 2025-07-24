import 'package:flutter/material.dart';

class PaymentHistory extends StatefulWidget {
  const PaymentHistory({super.key});

  @override
  State<PaymentHistory> createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  final List<Map<String, dynamic>> _cricketPayments = [
    {
      'match': 'India vs Australia',
      'date': 'June 15, 2025',
      'seat': 'Block A - Row 3 - Seat 14',
      'amount': 1200.00,
      'status': 'Success',
    },
    {
      'match': 'England vs South Africa',
      'date': 'June 10, 2025',
      'seat': 'VIP - Balcony B - Seat 5',
      'amount': 2500.00,
      'status': 'Failed',
    },
    {
      'match': 'Mumbai Indians vs RCB',
      'date': 'May 28, 2025',
      'seat': 'Block D - Row 6 - Seat 22',
      'amount': 850.00,
      'status': 'Success',
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Icon _statusIcon(String status) {
    switch (status) {
      case 'Success':
        return const Icon(Icons.check_circle, color: Colors.green);
      case 'Failed':
        return const Icon(Icons.cancel, color: Colors.red);
      default:
        return const Icon(Icons.info_outline);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cricket Match Payments',style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        // backgroundColor: Colors.green.shade700,
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _cricketPayments.length,
            itemBuilder: (context, index) {
              final payment = _cricketPayments[index];
              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          _statusIcon(payment['status']),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              payment['match'],
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text('Date: ${payment['date']}'),
                      Text('Seat: ${payment['seat']}'),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '₹${payment['amount'].toStringAsFixed(2)}',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            payment['status'],
                            style: TextStyle(
                              color: payment['status'] == 'Success' ? Colors.green : Colors.red,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
