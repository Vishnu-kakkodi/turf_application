// import 'package:flutter/material.dart';

// class CartScreen extends StatefulWidget {
//   const CartScreen({super.key});

//   @override
//   State<CartScreen> createState() => _CartScreenState();
// }

// class _CartScreenState extends State<CartScreen> with TickerProviderStateMixin {
//   final List<Map<String, dynamic>> cartItems = [
//     {
//       'name': 'Professional Cricket Bat',
//       'price': 14999,
//       'originalPrice': 19999,
//       'category': 'Equipment • cricket',
//       'rating': 4.8,
//       'image': 'assets/cricket_bat.jpg',
//       'isBestseller': true,
//       'quantity': 1,
//       'stock': 5,
//       'sku': 'CB-001',
//       'stockStatus': 'low',
//     },
//     {
//       'name': 'Sports T-Shirt',
//       'price': 2999,
//       'originalPrice': 3999,
//       'category': 'Apparel • sports',
//       'rating': 4.5,
//       'image': 'assets/tshirt.jpg',
//       'isBestseller': false,
//       'quantity': 2,
//       'stock': 25,
//       'sku': 'TS-002',
//       'stockStatus': 'in_stock',
//     },
//     {
//       'name': 'Running Shoes',
//       'price': 9999,
//       'originalPrice': 12999,
//       'category': 'Footwear • running',
//       'rating': 4.7,
//       'image': 'assets/shoes.jpg',
//       'isBestseller': true,
//       'quantity': 1,
//       'stock': 0,
//       'sku': 'RS-003',
//       'stockStatus': 'out_of_stock',
//     },
//     {
//       'name': 'Tennis Racket',
//       'price': 7999,
//       'originalPrice': 9999,
//       'category': 'Equipment • tennis',
//       'rating': 4.6,
//       'image': 'assets/tennis_racket.jpg',
//       'isBestseller': false,
//       'quantity': 1,
//       'stock': 15,
//       'sku': 'TR-004',
//       'stockStatus': 'in_stock',
//     },
//   ];

//   final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

//   void removeItem(int index) {
//     final removedItem = cartItems.removeAt(index);
//     _listKey.currentState?.removeItem(
//       index,
//       (context, animation) => buildCartItem(removedItem, index, animation),
//       duration: const Duration(milliseconds: 300),
//     );
//     setState(() {});
//   }

//   void updateQuantity(int index, int newQuantity) {
//     final item = cartItems[index];
//     final availableStock = item['stock'] as int;

//     if (newQuantity > 0 && newQuantity <= availableStock) {
//       setState(() {
//         cartItems[index]['quantity'] = newQuantity;
//       });
//     } else if (newQuantity > availableStock) {
//       // Show stock limit message
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Only ${availableStock} items available in stock'),
//           backgroundColor: Colors.orange,
//           duration: const Duration(seconds: 2),
//         ),
//       );
//     }
//   }

//   Widget buildStockIndicator(Map<String, dynamic> item) {
//     final stock = item['stock'] as int;
//     final stockStatus = item['stockStatus'] as String;

//     Color statusColor;
//     String statusText;
//     IconData statusIcon;

//     switch (stockStatus) {
//       case 'out_of_stock':
//         statusColor = Colors.red;
//         statusText = 'Out of Stock';
//         statusIcon = Icons.cancel_outlined;
//         break;
//       case 'low':
//         statusColor = Colors.orange;
//         statusText = 'Only $stock left';
//         statusIcon = Icons.warning_amber_outlined;
//         break;
//       case 'in_stock':
//         statusColor = Colors.green;
//         statusText = '$stock in stock';
//         statusIcon = Icons.check_circle_outline;
//         break;
//       default:
//         statusColor = Colors.grey;
//         statusText = 'Unknown';
//         statusIcon = Icons.help_outline;
//     }

//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       decoration: BoxDecoration(
//         color: statusColor.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: statusColor.withOpacity(0.3)),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(statusIcon, size: 12, color: statusColor),
//           const SizedBox(width: 4),
//           Text(
//             statusText,
//             style: TextStyle(
//               fontSize: 11,
//               fontWeight: FontWeight.w600,
//               color: statusColor,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildCartItem(Map<String, dynamic> item, int index, Animation<double> animation) {
//     return SizeTransition(
//       sizeFactor: animation,
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.1),
//               spreadRadius: 1,
//               blurRadius: 6,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Product Image
//               Stack(
//                 children: [
//                   Container(
//                     width: 80,
//                     height: 80,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       color: Colors.grey[200],
//                       image: const DecorationImage(
//                         image: NetworkImage('https://i.pinimg.com/originals/f5/f8/9b/f5f89bb422eafe7da71f7f6d9d221a6f.jpg'),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   if (item['isBestseller'])
//                     Positioned(
//                       top: -2,
//                       left: -2,
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                         decoration: BoxDecoration(
//                           color: Colors.orange,
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: const Text(
//                           'Bestseller',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 10,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//               const SizedBox(width: 16),
//               // Product Details
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       item['name'],
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black87,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Row(
//                       children: [
//                         Text(
//                           item['category'],
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Colors.grey[600],
//                           ),
//                         ),
//                         const SizedBox(width: 8),
//                         Text(
//                           'SKU: ${item['sku']}',
//                           style: TextStyle(
//                             fontSize: 11,
//                             color: Colors.grey[500],
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 6),
//                     buildStockIndicator(item),
//                     const SizedBox(height: 8),
//                     Row(
//                       children: [
//                         ...List.generate(5, (starIndex) {
//                           return Icon(
//                             starIndex < item['rating'].floor()
//                                 ? Icons.star
//                                 : starIndex < item['rating']
//                                     ? Icons.star_half
//                                     : Icons.star_border,
//                             size: 14,
//                             color: Colors.amber,
//                           );
//                         }),
//                         const SizedBox(width: 4),
//                         Text(
//                           '(${item['rating']})',
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Colors.grey[600],
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     Row(
//                       children: [
//                         Text(
//                           '₹${item['price']}',
//                           style: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black87,
//                           ),
//                         ),
//                         const SizedBox(width: 8),
//                         Text(
//                           '₹${item['originalPrice']}',
//                           style: TextStyle(
//                             fontSize: 14,
//                             decoration: TextDecoration.lineThrough,
//                             color: Colors.grey[600],
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 12),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         // Quantity Controls
//                         Row(
//                           children: [
//                             GestureDetector(
//                               onTap: item['stockStatus'] == 'out_of_stock'
//                                 ? null
//                                 : () => updateQuantity(index, item['quantity'] - 1),
//                               child: Container(
//                                 width: 32,
//                                 height: 32,
//                                 decoration: BoxDecoration(
//                                   border: Border.all(
//                                     color: item['stockStatus'] == 'out_of_stock'
//                                       ? Colors.grey[200]!
//                                       : Colors.grey[300]!
//                                   ),
//                                   borderRadius: BorderRadius.circular(6),
//                                   color: item['stockStatus'] == 'out_of_stock'
//                                     ? Colors.grey[100]
//                                     : Colors.white,
//                                 ),
//                                 child: Icon(
//                                   Icons.remove,
//                                   size: 16,
//                                   color: item['stockStatus'] == 'out_of_stock'
//                                     ? Colors.grey[400]
//                                     : Colors.black87,
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               width: 40,
//                               height: 32,
//                               alignment: Alignment.center,
//                               child: Text(
//                                 '${item['quantity']}',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w600,
//                                   color: item['stockStatus'] == 'out_of_stock'
//                                     ? Colors.grey[400]
//                                     : Colors.black87,
//                                 ),
//                               ),
//                             ),
//                             GestureDetector(
//                               onTap: item['stockStatus'] == 'out_of_stock'
//                                 ? null
//                                 : () => updateQuantity(index, item['quantity'] + 1),
//                               child: Container(
//                                 width: 32,
//                                 height: 32,
//                                 decoration: BoxDecoration(
//                                   border: Border.all(
//                                     color: item['stockStatus'] == 'out_of_stock'
//                                       ? Colors.grey[200]!
//                                       : Colors.grey[300]!
//                                   ),
//                                   borderRadius: BorderRadius.circular(6),
//                                   color: item['stockStatus'] == 'out_of_stock'
//                                     ? Colors.grey[100]
//                                     : Colors.white,
//                                 ),
//                                 child: Icon(
//                                   Icons.add,
//                                   size: 16,
//                                   color: item['stockStatus'] == 'out_of_stock'
//                                     ? Colors.grey[400]
//                                     : Colors.black87,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         // Delete Button
//                         GestureDetector(
//                           onTap: () => removeItem(index),
//                           child: Container(
//                             padding: const EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                               color: Colors.red[50],
//                               borderRadius: BorderRadius.circular(6),
//                             ),
//                             child: const Icon(
//                               Icons.delete_outline,
//                               color: Colors.red,
//                               size: 20,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   int getTotalPrice() {
//     return cartItems.fold(0, (sum, item) {

//       if (item['stockStatus'] != 'out_of_stock') {
//         return sum + (item['price'] as int) * (item['quantity'] as int);
//       }
//       return sum;
//     });
//   }

//   int getTotalSavings() {
//     return cartItems.fold(0, (sum, item) {

//       if (item['stockStatus'] != 'out_of_stock') {
//         return sum + ((item['originalPrice'] as int) - (item['price'] as int)) * (item['quantity'] as int);
//       }
//       return sum;
//     });
//   }

//   int getAvailableItemsCount() {
//     return cartItems.where((item) => item['stockStatus'] != 'out_of_stock').length;
//   }

//   bool hasOutOfStockItems() {
//     return cartItems.any((item) => item['stockStatus'] == 'out_of_stock');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: AppBar(
//         title: const Text(
//           'My Cart',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Colors.black87,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         elevation: 1,
//         automaticallyImplyLeading: false,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.more_vert, color: Colors.black87),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           // Cart Items Count
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.all(16),
//             color: Colors.white,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   '${cartItems.length} items in cart',
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey[700],
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 if (hasOutOfStockItems()) ...[
//                   const SizedBox(height: 8),
//                   // Container(
//                   //   padding: const EdgeInsets.all(12),
//                   //   decoration: BoxDecoration(
//                   //     color: Colors.red[50],
//                   //     borderRadius: BorderRadius.circular(8),
//                   //     border: Border.all(color: Colors.red[200]!),
//                   //   ),
//                   //   child: Row(
//                   //     children: [
//                   //       Icon(Icons.warning_amber_outlined, size: 16, color: Colors.red[600]),
//                   //       const SizedBox(width: 8),
//                   //       // Expanded(
//                   //       //   child: Text(
//                   //       //     'Some items are out of stock and will be removed from total',
//                   //       //     style: TextStyle(
//                   //       //       fontSize: 12,
//                   //       //       color: Colors.red[700],
//                   //       //       fontWeight: FontWeight.w500,
//                   //       //     ),
//                   //       //   ),
//                   //       // ),
//                   //     ],
//                   //   ),
//                   // ),
//                 ],
//               ],
//             ),
//           ),
//           const SizedBox(height: 8),
//           // Cart Items List
//           Expanded(
//             child: AnimatedList(
//               key: _listKey,
//               initialItemCount: cartItems.length,
//               padding: const EdgeInsets.only(bottom: 16),
//               itemBuilder: (context, index, animation) {
//                 return buildCartItem(cartItems[index], index, animation);
//               },
//             ),
//           ),
//           // Bottom Summary and Checkout
//           Container(
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.1),
//                   blurRadius: 10,
//                   offset: const Offset(0, -5),
//                 ),
//               ],
//             ),
//             child: Column(
//               children: [
//                 // Price Summary
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Subtotal',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.grey[700],
//                       ),
//                     ),
//                     Text(
//                       '₹${getTotalPrice() + getTotalSavings()}',
//                       style: TextStyle(
//                         fontSize: 16,
//                         decoration: TextDecoration.lineThrough,
//                         color: Colors.grey[600],
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 8),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Discount',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.green[700],
//                       ),
//                     ),
//                     Text(
//                       '-₹${getTotalSavings()}',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.green[700],
//                       ),
//                     ),
//                   ],
//                 ),
//                 const Divider(height: 24),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       'Total',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black87,
//                       ),
//                     ),
//                     Text(
//                       '₹${getTotalPrice()}',
//                       style: const TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black87,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 // Checkout Button
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: getAvailableItemsCount() > 0 ? () {
//                       if (hasOutOfStockItems()) {
//                         showDialog(
//                           context: context,
//                           builder: (BuildContext context) {
//                             return AlertDialog(
//                               title: const Text('Confirm Checkout'),
//                               content: const Text(
//                                 'Some items are out of stock and will be removed from your order. Do you want to proceed with available items?'
//                               ),
//                               actions: [
//                                 TextButton(
//                                   onPressed: () => Navigator.of(context).pop(),
//                                   child: const Text('Cancel'),
//                                 ),
//                                 ElevatedButton(
//                                   onPressed: () {
//                                     Navigator.of(context).pop();
//                                     ScaffoldMessenger.of(context).showSnackBar(
//                                       const SnackBar(
//                                         content: Text("Proceeding to Checkout with available items..."),
//                                         backgroundColor: Colors.green,
//                                       ),
//                                     );
//                                   },
//                                   child: const Text('Proceed'),
//                                 ),
//                               ],
//                             );
//                           },
//                         );
//                       } else {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             content: Text("Proceeding to Checkout..."),
//                             backgroundColor: Colors.green,
//                           ),
//                         );
//                       }
//                     } : null,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: getAvailableItemsCount() > 0
//                         ? const Color(0xFF2C3E50)
//                         : Colors.grey[400],
//                       foregroundColor: Colors.white,
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       elevation: getAvailableItemsCount() > 0 ? 2 : 0,
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.shopping_cart_checkout,
//                           size: 20,
//                           color: getAvailableItemsCount() > 0 ? Colors.white : Colors.grey[600],
//                         ),
//                         const SizedBox(width: 8),
//                         Text(
//                           getAvailableItemsCount() > 0 ? 'Proceed to Checkout' : 'No Items Available',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                             color: getAvailableItemsCount() > 0 ? Colors.white : Colors.grey[600],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with TickerProviderStateMixin {
  final List<Map<String, dynamic>> allCartItems = [
    {
      'name': 'Professional Cricket Bat',
      'price': 14999,
      'originalPrice': 19999,
      'category': 'Equipment • cricket',
      'rating': 4.8,
      'image': 'assets/cricket_bat.jpg',
      'isBestseller': true,
      'quantity': 1,
      'stock': 5,
      'sku': 'CB-001',
      'stockStatus': 'low',
      'filterCategory': 'cricket',
    },
    {
      'name': 'Sports T-Shirt',
      'price': 2999,
      'originalPrice': 3999,
      'category': 'Apparel • sports',
      'rating': 4.5,
      'image': 'assets/tshirt.jpg',
      'isBestseller': false,
      'quantity': 2,
      'stock': 25,
      'sku': 'TS-002',
      'stockStatus': 'in_stock',
      'filterCategory': 'sports',
    },
    {
      'name': 'Running Shoes',
      'price': 9999,
      'originalPrice': 12999,
      'category': 'Footwear • running',
      'rating': 4.7,
      'image': 'assets/shoes.jpg',
      'isBestseller': true,
      'quantity': 1,
      'stock': 0,
      'sku': 'RS-003',
      'stockStatus': 'out_of_stock',
      'filterCategory': 'running',
    },
    {
      'name': 'Tennis Racket',
      'price': 7999,
      'originalPrice': 9999,
      'category': 'Equipment • tennis',
      'rating': 4.6,
      'image': 'assets/tennis_racket.jpg',
      'isBestseller': false,
      'quantity': 1,
      'stock': 15,
      'sku': 'TR-004',
      'stockStatus': 'in_stock',
      'filterCategory': 'tennis',
    },
    {
      'name': 'Football',
      'price': 3999,
      'originalPrice': 4999,
      'category': 'Equipment • football',
      'rating': 4.4,
      'image': 'assets/football.jpg',
      'isBestseller': false,
      'quantity': 1,
      'stock': 12,
      'sku': 'FB-005',
      'stockStatus': 'in_stock',
      'filterCategory': 'football',
    },
    {
      'name': 'Cricket Gloves',
      'price': 2499,
      'originalPrice': 3499,
      'category': 'Equipment • cricket',
      'rating': 4.3,
      'image': 'assets/cricket_gloves.jpg',
      'isBestseller': false,
      'quantity': 1,
      'stock': 8,
      'sku': 'CG-006',
      'stockStatus': 'in_stock',
      'filterCategory': 'cricket',
    },
    {
      'name': 'Football Boots',
      'price': 8999,
      'originalPrice': 11999,
      'category': 'Footwear • football',
      'rating': 4.6,
      'image': 'assets/football_boots.jpg',
      'isBestseller': true,
      'quantity': 1,
      'stock': 6,
      'sku': 'FBt-007',
      'stockStatus': 'low',
      'filterCategory': 'football',
    },
  ];

  late TabController _tabController;
  List<Map<String, dynamic>> cartItems = [];
  String selectedCategory = 'all';

  final List<Map<String, String>> categories = [
    {'key': 'all', 'label': 'All Products'},
    {'key': 'cricket', 'label': 'Cricket'},
    {'key': 'football', 'label': 'Football'},
    {'key': 'tennis', 'label': 'Tennis'},
    {'key': 'running', 'label': 'Running'},
    {'key': 'sports', 'label': 'Sports'},
  ];

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: categories.length, vsync: this);
    cartItems = List.from(allCartItems);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          selectedCategory = categories[_tabController.index]['key']!;
          filterItems();
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void filterItems() {
    setState(() {
      if (selectedCategory == 'all') {
        cartItems = List.from(allCartItems);
      } else {
        cartItems = allCartItems
            .where((item) => item['filterCategory'] == selectedCategory)
            .toList();
      }
    });
  }

  void removeItem(int index) {
    final removedItem = cartItems[index];

    // Remove from both filtered and all items
    cartItems.removeAt(index);
    allCartItems.removeWhere((item) => item['sku'] == removedItem['sku']);

    setState(() {});
  }

  void updateQuantity(int index, int newQuantity) {
    final item = cartItems[index];
    final availableStock = item['stock'] as int;

    if (newQuantity > 0 && newQuantity <= availableStock) {
      setState(() {
        cartItems[index]['quantity'] = newQuantity;
        // Update in allCartItems as well
        final allItemIndex =
            allCartItems.indexWhere((allItem) => allItem['sku'] == item['sku']);
        if (allItemIndex != -1) {
          allCartItems[allItemIndex]['quantity'] = newQuantity;
        }
      });
    } else if (newQuantity > availableStock) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Only ${availableStock} items available in stock'),
          backgroundColor: Colors.orange,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Widget buildStockIndicator(Map<String, dynamic> item) {
    final stock = item['stock'] as int;
    final stockStatus = item['stockStatus'] as String;

    Color statusColor;
    String statusText;
    IconData statusIcon;

    switch (stockStatus) {
      case 'out_of_stock':
        statusColor = Colors.red;
        statusText = 'Out of Stock';
        statusIcon = Icons.cancel_outlined;
        break;
      case 'low':
        statusColor = Colors.orange;
        statusText = 'Only $stock left';
        statusIcon = Icons.warning_amber_outlined;
        break;
      case 'in_stock':
        statusColor = Colors.green;
        statusText = '$stock in stock';
        statusIcon = Icons.check_circle_outline;
        break;
      default:
        statusColor = Colors.grey;
        statusText = 'Unknown';
        statusIcon = Icons.help_outline;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: statusColor.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(statusIcon, size: 12, color: statusColor),
          const SizedBox(width: 4),
          Text(
            statusText,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: statusColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCartItem(
      Map<String, dynamic> item, int index, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Stack(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[200],
                      image: const DecorationImage(
                        image: NetworkImage(
                            'https://i.pinimg.com/originals/f5/f8/9b/f5f89bb422eafe7da71f7f6d9d221a6f.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  if (item['isBestseller'])
                    Positioned(
                      top: -2,
                      left: -2,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'Bestseller',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 16),
              // Product Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['name'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          item['category'],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'SKU: ${item['sku']}',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[500],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    buildStockIndicator(item),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        ...List.generate(5, (starIndex) {
                          return Icon(
                            starIndex < item['rating'].floor()
                                ? Icons.star
                                : starIndex < item['rating']
                                    ? Icons.star_half
                                    : Icons.star_border,
                            size: 14,
                            color: Colors.amber,
                          );
                        }),
                        const SizedBox(width: 4),
                        Text(
                          '(${item['rating']})',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          '₹${item['price']}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '₹${item['originalPrice']}',
                          style: TextStyle(
                            fontSize: 14,
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Quantity Controls
                        Row(
                          children: [
                            GestureDetector(
                              onTap: item['stockStatus'] == 'out_of_stock'
                                  ? null
                                  : () => updateQuantity(
                                      index, item['quantity'] - 1),
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color:
                                          item['stockStatus'] == 'out_of_stock'
                                              ? Colors.grey[200]!
                                              : Colors.grey[300]!),
                                  borderRadius: BorderRadius.circular(6),
                                  color: item['stockStatus'] == 'out_of_stock'
                                      ? Colors.grey[100]
                                      : Colors.white,
                                ),
                                child: Icon(
                                  Icons.remove,
                                  size: 16,
                                  color: item['stockStatus'] == 'out_of_stock'
                                      ? Colors.grey[400]
                                      : Colors.black87,
                                ),
                              ),
                            ),
                            Container(
                              width: 40,
                              height: 32,
                              alignment: Alignment.center,
                              child: Text(
                                '${item['quantity']}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: item['stockStatus'] == 'out_of_stock'
                                      ? Colors.grey[400]
                                      : Colors.black87,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: item['stockStatus'] == 'out_of_stock'
                                  ? null
                                  : () => updateQuantity(
                                      index, item['quantity'] + 1),
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color:
                                          item['stockStatus'] == 'out_of_stock'
                                              ? Colors.grey[200]!
                                              : Colors.grey[300]!),
                                  borderRadius: BorderRadius.circular(6),
                                  color: item['stockStatus'] == 'out_of_stock'
                                      ? Colors.grey[100]
                                      : Colors.white,
                                ),
                                child: Icon(
                                  Icons.add,
                                  size: 16,
                                  color: item['stockStatus'] == 'out_of_stock'
                                      ? Colors.grey[400]
                                      : Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Delete Button
                        GestureDetector(
                          onTap: () => removeItem(index),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.red[50],
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Item added to cart')),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xFF2C3E50),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text('Add to Cart'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int getTotalPrice() {
    return allCartItems.fold(0, (sum, item) {
      if (item['stockStatus'] != 'out_of_stock') {
        return sum + (item['price'] as int) * (item['quantity'] as int);
      }
      return sum;
    });
  }

  int getTotalSavings() {
    return allCartItems.fold(0, (sum, item) {
      if (item['stockStatus'] != 'out_of_stock') {
        return sum +
            ((item['originalPrice'] as int) - (item['price'] as int)) *
                (item['quantity'] as int);
      }
      return sum;
    });
  }

  int getAvailableItemsCount() {
    return allCartItems
        .where((item) => item['stockStatus'] != 'out_of_stock')
        .length;
  }

  bool hasOutOfStockItems() {
    return allCartItems.any((item) => item['stockStatus'] == 'out_of_stock');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'My Cart',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        automaticallyImplyLeading: false,
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.more_vert, color: Colors.black87),
        //     onPressed: () {},
        //   ),
        // ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: const Color(0xFF2C3E50),
          unselectedLabelColor: Colors.grey[600],
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
          indicatorColor: const Color(0xFF2C3E50),
          indicatorWeight: 3,
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: categories.map((category) {
            return Tab(
              text: category['label'],
            );
          }).toList(),
        ),
      ),
      body: Column(
        children: [
          // Cart Items Count
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  selectedCategory == 'all'
                      ? '${allCartItems.length} items in cart'
                      : '${cartItems.length} ${categories.firstWhere((cat) => cat['key'] == selectedCategory)['label']} items in cart',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (hasOutOfStockItems()) ...[
                  const SizedBox(height: 8),
                ],
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Cart Items List
          Expanded(
            child: cartItems.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_cart_outlined,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No items in this category',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 16),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      return buildCartItem(cartItems[index], index,
                          const AlwaysStoppedAnimation(1.0));
                    },
                  ),
          ),
          // Bottom Summary and Checkout
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Column(
              children: [
                // Price Summary
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Subtotal',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                    Text(
                      '₹${getTotalPrice() + getTotalSavings()}',
                      style: TextStyle(
                        fontSize: 16,
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Discount',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.green[700],
                      ),
                    ),
                    Text(
                      '-₹${getTotalSavings()}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.green[700],
                      ),
                    ),
                  ],
                ),
                const Divider(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      '₹${getTotalPrice()}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Checkout Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: getAvailableItemsCount() > 0
                        ? () {
                            if (hasOutOfStockItems()) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Confirm Checkout'),
                                    content: const Text(
                                        'Some items are out of stock and will be removed from your order. Do you want to proceed with available items?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        child: const Text('Cancel'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  "Proceeding to Checkout with available items..."),
                                              backgroundColor: Colors.green,
                                            ),
                                          );
                                        },
                                        child: const Text('Proceed'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Proceeding to Checkout..."),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            }
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: getAvailableItemsCount() > 0
                          ? const Color(0xFF2C3E50)
                          : Colors.grey[400],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: getAvailableItemsCount() > 0 ? 2 : 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_cart_checkout,
                          size: 20,
                          color: getAvailableItemsCount() > 0
                              ? Colors.white
                              : Colors.grey[600],
                        ),
                        const SizedBox(width: 8),
                        Text(
                          getAvailableItemsCount() > 0
                              ? 'Proceed to Checkout'
                              : 'No Items Available',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: getAvailableItemsCount() > 0
                                ? Colors.white
                                : Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
