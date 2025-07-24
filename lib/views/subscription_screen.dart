import 'package:booking_application/views/profile/profile_screen.dart';
import 'package:flutter/material.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:  IconButton(onPressed: (){
              Navigator.of(context).pop();
        }, icon: Icon(Icons.arrow_back_ios)),
        title: const Text('Subscription',style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Image Placeholder
            SizedBox(
              height: 200,
              child: Image.network(
                'https://img.freepik.com/free-vector/billboard-advertisement-street-advertising-promo-poster-advantageous-proposition-gift-customer-client-attraction-passerby-cartoon-character_335657-2972.jpg?semt=ais_hybrid&w=740',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 12),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Upgrade to premium',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            const FeaturePoint(text: 'Lorem Ipsum is simply dummy'),
            const FeaturePoint(text: 'Lorem Ipsum is simply dummy'),
            const FeaturePoint(text: 'Lorem Ipsum is simply dummy'),
            const FeaturePoint(text: 'Lorem Ipsum is simply dummy'),
            const SizedBox(height: 20),
            const SubscriptionTile(title: 'One month', price: '₹299'),
            const SizedBox(height: 12),
            const SubscriptionTile(title: 'Three months', price: '₹299'),
            const SizedBox(height: 12),
            const SubscriptionTile(title: 'One year', price: '₹299'),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FeaturePoint extends StatelessWidget {
  final String text;
  const FeaturePoint({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          const Icon(Icons.check, color: Colors.black),
          const SizedBox(width: 8),
          Expanded(
            child: Text(text),
          ),
        ],
      ),
    );
  }
}

class SubscriptionTile extends StatelessWidget {
  final String title;
  final String price;

  const SubscriptionTile({super.key, required this.title, required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(
            price,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
