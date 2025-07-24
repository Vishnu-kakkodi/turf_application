import 'package:booking_application/views/subscription_screen.dart';
import 'package:flutter/material.dart';

class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get invoice',style: TextStyle(fontWeight: FontWeight.bold),),
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon: Icon(Icons.arrow_back_ios)),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.edit,color: Colors.blue,),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: const Color.fromARGB(255, 84, 84, 84), width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Invoice",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  const Text("Date: 02-05-2025"),
                  const Text("Invoice: #123456"),
                  const SizedBox(height: 12),
                  Table(
                    border: TableBorder.symmetric(
                      inside: const BorderSide(width: 0.5, color: Colors.grey),
                      outside: BorderSide.none,
                    ),
                    columnWidths: const {
                      0: FlexColumnWidth(2),
                      1: FlexColumnWidth(1),
                      2: FlexColumnWidth(1.5),
                    },
                    children: const [
                      TableRow(
                        decoration: BoxDecoration(color: Color(0xFFF5F5F5)),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('DESCRIPTION', style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Hrs', style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('SUBTOTAL', style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      TableRow(children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Cricket Turf'),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('2'),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('₹599'),
                        ),
                      ]),
                      TableRow(children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Football'),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('4'),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('₹1500'),
                        ),
                      ]),
                    ],
                  ),
                  const Divider(height: 30),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total'),
                          
                          ],
                        ),
                        SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Sub Total'),
                            Text('₹225.00'),
                          ],
                        ),
                        SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Discount'),
                            Text('₹10.00'),
                          ],
                        ),
                        SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Tax'),
                            Text('₹22.00'),
                          ],
                        ),
                        Divider(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                            Text(
                              '₹2100',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.download, color: Colors.white),
                  label: const Text('Download',style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const SubscriptionScreen()));
                  },
                  icon: const Icon(Icons.share, color: Colors.blue),
                  label: const Text('Share', style: TextStyle(color: Colors.blue)),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.blue),
                    padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
