// import 'package:booking_application/views/card_details.dart';
// import 'package:flutter/material.dart';

// class PaymentScreen extends StatefulWidget {
//   const PaymentScreen({super.key});

//   @override
//   State<PaymentScreen> createState() => _PaymentScreenState();
// }

// class _PaymentScreenState extends State<PaymentScreen> {
//   String selectedPayment = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             // App Bar
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               child: Row(
//                 children: [
//                   GestureDetector(
//                     onTap: () => Navigator.pop(context),
//                     child: const Icon(
//                       Icons.arrow_back,
//                       color: Colors.black,
//                       size: 24,
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   const Text(
//                     'Payment Method',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
            
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(height: 20),
                    
//                     // Preferred Payment Section
//                     const Text(
//                       'Preferred Payment',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black,
//                       ),
//                     ),
                    
//                     const SizedBox(height: 16),
                    
//                     // PhonePe Option
//                     PaymentOptionTile(
//                       title: 'Phonepe',
//                       icon: Container(
//                         width: 32,
//                         height: 32,
//                         decoration: const BoxDecoration(
//                           color: Color(0xFF5F259F),
//                           shape: BoxShape.circle,
//                         ),
//                         child: const Center(
//                           child: Text(
//                             'P',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16,
//                             ),
//                           ),
//                         ),
//                       ),
//                       isSelected: selectedPayment == 'phonepe',
//                       onTap: () => setState(() => selectedPayment = 'phonepe'),
//                     ),
                    
//                     const SizedBox(height: 12),
                    
//                     // Google Pay Option
//                     PaymentOptionTile(
//                       title: 'Google pay',
//                       icon: Container(
//                         width: 32,
//                         height: 32,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(6),
//                           gradient: const LinearGradient(
//                             colors: [
//                               Color(0xFF4285F4),
//                               Color(0xFF34A853),
//                               Color(0xFFFBBC05),
//                               Color(0xFFEA4335),
//                             ],
//                           ),
//                         ),
//                         child: const Center(
//                           child: Text(
//                             'G',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16,
//                             ),
//                           ),
//                         ),
//                       ),
//                       isSelected: selectedPayment == 'googlepay',
//                       onTap: () => setState(() => selectedPayment = 'googlepay'),
//                     ),
                    
//                     const SizedBox(height: 12),
                    
//                     // Paytm Option
//                     PaymentOptionTile(
//                       title: 'Paytm',
//                       icon: Container(
//                         width: 32,
//                         height: 32,
//                         decoration: BoxDecoration(
//                           color: const Color(0xFF00BAF2),
//                           borderRadius: BorderRadius.circular(6),
//                         ),
//                         child: const Center(
//                           child: Text(
//                             'P',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16,
//                             ),
//                           ),
//                         ),
//                       ),
//                       isSelected: selectedPayment == 'paytm',
//                       onTap: () => setState(() => selectedPayment = 'paytm'),
//                     ),
                    
//                     const SizedBox(height: 12),
                    
//                     // Add New UPI ID Option
//                     PaymentOptionTile(
//                       title: 'Add New UPI ID',
//                       icon: Container(
//                         width: 32,
//                         height: 32,
//                         decoration: BoxDecoration(
//                           color: Colors.grey[200],
//                           shape: BoxShape.circle,
//                         ),
//                         child: const Icon(
//                           Icons.add,
//                           color: Colors.grey,
//                           size: 20,
//                         ),
//                       ),
//                       isSelected: selectedPayment == 'newupi',
//                       onTap: () => setState(() => selectedPayment = 'newupi'),
//                     ),
                    
//                     const SizedBox(height: 32),
                    
//                     // More Payment Options Section
//                     const Text(
//                       'More Payment Options',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black,
//                       ),
//                     ),
                    
//                     const SizedBox(height: 16),
                    
//                     // Credit/Debit Card Option
//                     PaymentOptionTile(
//                       title: 'Credit/Debit card',
//                       icon: Container(
//                         width: 32,
//                         height: 32,
//                         decoration: BoxDecoration(
//                           color: const Color(0xFF4CAF50),
//                           borderRadius: BorderRadius.circular(6),
//                         ),
//                         child: const Icon(
//                           Icons.credit_card,
//                           color: Colors.white,
//                           size: 18,
//                         ),
//                       ),
//                       trailingIcon: Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                         decoration: BoxDecoration(
//                           color: Colors.blue[50],
//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Container(
//                               width: 16,
//                               height: 12,
//                               decoration: BoxDecoration(
//                                 color: Colors.blue,
//                                 borderRadius: BorderRadius.circular(2),
//                               ),
//                             ),
//                             const SizedBox(width: 4),
//                             Container(
//                               width: 16,
//                               height: 12,
//                               decoration: BoxDecoration(
//                                 color: Colors.orange,
//                                 borderRadius: BorderRadius.circular(2),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       isSelected: selectedPayment == 'card',
//                       onTap: () => setState(() => selectedPayment = 'card'),
//                     ),
                    
//                     const SizedBox(height: 12),
                    
//                     // Add New Card Option
//                     PaymentOptionTile(
//                       title: 'Add New Card',
//                       icon: Container(
//                         width: 32,
//                         height: 32,
//                         decoration: BoxDecoration(
//                           color: Colors.grey[200],
//                           shape: BoxShape.circle,
//                         ),
//                         child: const Icon(
//                           Icons.add,
//                           color: Colors.grey,
//                           size: 20,
//                         ),
//                       ),
//                       isSelected: selectedPayment == 'newcard',
//                       onTap: () => setState(() => selectedPayment = 'newcard'),
//                     ),
                    
//                     const Spacer(),
//                   ],
//                 ),
//               ),
//             ),
            
//             // Proceed to Pay Button
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton(
//                   onPressed: selectedPayment.isNotEmpty ? () {
//                     Navigator.push(context, MaterialPageRoute(builder: (context)=>CardDetails()));
//                   } : null,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue,
//                     disabledBackgroundColor: Colors.grey[300],
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                   ),
//                   child: const Text(
//                     'Proceed to pay',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class PaymentOptionTile extends StatelessWidget {
//   final String title;
//   final Widget icon;
//   final Widget? trailingIcon;
//   final bool isSelected;
//   final VoidCallback onTap;

//   const PaymentOptionTile({
//     super.key,
//     required this.title,
//     required this.icon,
//     this.trailingIcon,
//     required this.isSelected,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//         decoration: BoxDecoration(
//           color: Colors.grey[50],
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//             color: isSelected ? Colors.blue : Colors.grey[200]!,
//             width: isSelected ? 2 : 1,
//           ),
//         ),
//         child: Row(
//           children: [
//             // Radio Button
//             Container(
//               width: 20,
//               height: 20,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: Border.all(
//                   color: isSelected ? Colors.blue : Colors.grey,
//                   width: 2,
//                 ),
//               ),
//               child: isSelected
//                   ? Center(
//                       child: Container(
//                         width: 10,
//                         height: 10,
//                         decoration: const BoxDecoration(
//                           color: Colors.blue,
//                           shape: BoxShape.circle,
//                         ),
//                       ),
//                     )
//                   : null,
//             ),
            
//             const SizedBox(width: 16),
            
//             // Payment Icon
//             icon,
            
//             const SizedBox(width: 12),
            
//             // Payment Title
//             Expanded(
//               child: Text(
//                 title,
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
            
//             // Trailing Icon (for card brands)
//             if (trailingIcon != null) trailingIcon!,
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:booking_application/views/card_details.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String selectedPayment = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Payment Method',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    
                    // Preferred Payment Section
                    const Text(
                      'Preferred Payment',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    
                    const SizedBox(height: 10),
                    
                    // PhonePe Option
                    PaymentOptionTile(
                      title: 'PhonePe',
                      icon: Container(
                        width: 40,
                        height: 30,
                        decoration: BoxDecoration(
                          color: const Color(0xFF5F259F),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // PhonePe logo-like design
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            const Text(
                              'Pe',
                              style: TextStyle(
                                color: Color(0xFF5F259F),
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                      isSelected: selectedPayment == 'phonepe',
                      onTap: () => setState(() => selectedPayment = 'phonepe'),
                    ),
                    
                    const SizedBox(height: 10),
                    
                    // Google Pay Option
                    PaymentOptionTile(
                      title: 'Google Pay',
                      icon: Container(
                        width: 40,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            // Google Pay colors
                            Positioned(
                              left: 8,
                              top: 8,
                              child: Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF4285F4), // Blue
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            Positioned(
                              right: 8,
                              top: 8,
                              child: Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFEA4335), // Red
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 8,
                              bottom: 8,
                              child: Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFBBC05), // Yellow
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            Positioned(
                              right: 8,
                              bottom: 8,
                              child: Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF34A853), // Green
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            const Center(
                              child: Text(
                                'G',
                                style: TextStyle(
                                  color: Color(0xFF4285F4),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      isSelected: selectedPayment == 'googlepay',
                      onTap: () => setState(() => selectedPayment = 'googlepay'),
                    ),
                    
                    const SizedBox(height: 10),
                    
                    // Paytm Option
                    PaymentOptionTile(
                      title: 'Paytm',
                      icon: Container(
                        width: 40,
                        height: 30,
                        decoration: BoxDecoration(
                          color: const Color(0xFF00BAF2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Paytm logo-like design
                            Container(
                              width: 28,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF00BAF2),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 2),
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF00BAF2),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 2),
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF00BAF2),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      isSelected: selectedPayment == 'paytm',
                      onTap: () => setState(() => selectedPayment = 'paytm'),
                    ),
                    
                    const SizedBox(height: 10),
                    
                    // Add New UPI ID Option
                    PaymentOptionTile(
                      title: 'Add New UPI ID',
                      icon: Container(
                        width: 40,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.grey,
                          size: 24,
                        ),
                      ),
                      isSelected: selectedPayment == 'newupi',
                      onTap: () => setState(() => selectedPayment = 'newupi'),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // More Payment Options Section
                    const Text(
                      'More Payment Options',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Credit/Debit Card Option
                    PaymentOptionTile(
                      title: 'Credit/Debit card',
                      icon: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF1976D2), Color(0xFF42A5F5)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Stack(
                          children: [
                            // Card design
                            Positioned(
                              left: 6,
                              top: 6,
                              right: 6,
                              child: Container(
                                height: 3,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(1),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 6,
                              bottom: 6,
                              child: Container(
                                width: 12,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                            const Positioned(
                              right: 8,
                              bottom: 8,
                              child: Icon(
                                Icons.credit_card,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      trailingIcon: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Visa-like
                            Container(
                              width: 20,
                              height: 12,
                              decoration: BoxDecoration(
                                color: const Color(0xFF1A1F71),
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: const Center(
                                child: Text(
                                  'VISA',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 6,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 4),
                            // Mastercard-like
                            Container(
                              width: 20,
                              height: 12,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 2,
                                    child: Container(
                                      width: 8,
                                      height: 12,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFEB001B),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 2,
                                    child: Container(
                                      width: 8,
                                      height: 12,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFF79E1B),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      isSelected: selectedPayment == 'card',
                      onTap: () => setState(() => selectedPayment = 'card'),
                    ),
                    
                    const SizedBox(height: 12),
                    
                    // Add New Card Option
                    PaymentOptionTile(
                      title: 'Add New Card',
                      icon: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.grey,
                          size: 24,
                        ),
                      ),
                      isSelected: selectedPayment == 'newcard',
                      onTap: () => setState(() => selectedPayment = 'newcard'),
                    ),
                    
                    const Spacer(),
                  ],
                ),
              ),
            ),
            
            // Proceed to Pay Button
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: selectedPayment.isNotEmpty ? () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CardDetails()));
                  } : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    disabledBackgroundColor: Colors.grey[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    'Proceed to pay',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
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

class PaymentOptionTile extends StatelessWidget {
  final String title;
  final Widget icon;
  final Widget? trailingIcon;
  final bool isSelected;
  final VoidCallback onTap;

  const PaymentOptionTile({
    super.key,
    required this.title,
    required this.icon,
    this.trailingIcon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.green : Colors.grey[200]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            // Radio Button
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Colors.green : Colors.grey,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : null,
            ),
            
            const SizedBox(width: 16),
            
            // Payment Title
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            
            const SizedBox(width: 12),
            
            // Trailing Icon (for card brands) - moved before payment icon
            if (trailingIcon != null) ...[
              trailingIcon!,
              const SizedBox(width: 12),
            ],
            
            // Payment Icon - now on the right side
            icon,
          ],
        ),
      ),
    );
  }
}