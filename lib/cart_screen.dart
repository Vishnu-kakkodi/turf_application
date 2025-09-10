// import 'package:flutter/material.dart';

// class CartScreen extends StatefulWidget {
//   const CartScreen({super.key});

//   @override
//   State<CartScreen> createState() => _CartScreenState();
// }

// class _CartScreenState extends State<CartScreen> with TickerProviderStateMixin {
//   final List<Map<String, dynamic>> allCartItems = [
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
//       'filterCategory': 'cricket',
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
//       'filterCategory': 'sports',
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
//       'filterCategory': 'running',
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
//       'filterCategory': 'tennis',
//     },
//     {
//       'name': 'Football',
//       'price': 3999,
//       'originalPrice': 4999,
//       'category': 'Equipment • football',
//       'rating': 4.4,
//       'image': 'assets/football.jpg',
//       'isBestseller': false,
//       'quantity': 1,
//       'stock': 12,
//       'sku': 'FB-005',
//       'stockStatus': 'in_stock',
//       'filterCategory': 'football',
//     },
//     {
//       'name': 'Cricket Gloves',
//       'price': 2499,
//       'originalPrice': 3499,
//       'category': 'Equipment • cricket',
//       'rating': 4.3,
//       'image': 'assets/cricket_gloves.jpg',
//       'isBestseller': false,
//       'quantity': 1,
//       'stock': 8,
//       'sku': 'CG-006',
//       'stockStatus': 'in_stock',
//       'filterCategory': 'cricket',
//     },
//     {
//       'name': 'Football Boots',
//       'price': 8999,
//       'originalPrice': 11999,
//       'category': 'Footwear • football',
//       'rating': 4.6,
//       'image': 'assets/football_boots.jpg',
//       'isBestseller': true,
//       'quantity': 1,
//       'stock': 6,
//       'sku': 'FBt-007',
//       'stockStatus': 'low',
//       'filterCategory': 'football',
//     },
//   ];

//   late TabController _tabController;
//   List<Map<String, dynamic>> cartItems = [];
//   String selectedCategory = 'all';

//   final List<Map<String, String>> categories = [
//     {'key': 'all', 'label': 'All Products'},
//     {'key': 'cricket', 'label': 'Cricket'},
//     {'key': 'football', 'label': 'Football'},
//     {'key': 'tennis', 'label': 'Tennis'},
//     {'key': 'running', 'label': 'Running'},
//     {'key': 'sports', 'label': 'Sports'},
//   ];

//   final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: categories.length, vsync: this);
//     cartItems = List.from(allCartItems);

//     _tabController.addListener(() {
//       if (_tabController.indexIsChanging) {
//         setState(() {
//           selectedCategory = categories[_tabController.index]['key']!;
//           filterItems();
//         });
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   void filterItems() {
//     setState(() {
//       if (selectedCategory == 'all') {
//         cartItems = List.from(allCartItems);
//       } else {
//         cartItems = allCartItems
//             .where((item) => item['filterCategory'] == selectedCategory)
//             .toList();
//       }
//     });
//   }

//   void removeItem(int index) {
//     final removedItem = cartItems[index];

//     // Remove from both filtered and all items
//     cartItems.removeAt(index);
//     allCartItems.removeWhere((item) => item['sku'] == removedItem['sku']);

//     setState(() {});
//   }

//   void updateQuantity(int index, int newQuantity) {
//     final item = cartItems[index];
//     final availableStock = item['stock'] as int;

//     if (newQuantity > 0 && newQuantity <= availableStock) {
//       setState(() {
//         cartItems[index]['quantity'] = newQuantity;
//         // Update in allCartItems as well
//         final allItemIndex =
//             allCartItems.indexWhere((allItem) => allItem['sku'] == item['sku']);
//         if (allItemIndex != -1) {
//           allCartItems[allItemIndex]['quantity'] = newQuantity;
//         }
//       });
//     } else if (newQuantity > availableStock) {
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

//   Widget buildCartItem(
//       Map<String, dynamic> item, int index, Animation<double> animation) {
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
//                         image: NetworkImage(
//                             'https://i.pinimg.com/originals/f5/f8/9b/f5f89bb422eafe7da71f7f6d9d221a6f.jpg'),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   if (item['isBestseller'])
//                     Positioned(
//                       top: -2,
//                       left: -2,
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 8, vertical: 4),
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
//                                   ? null
//                                   : () => updateQuantity(
//                                       index, item['quantity'] - 1),
//                               child: Container(
//                                 width: 32,
//                                 height: 32,
//                                 decoration: BoxDecoration(
//                                   border: Border.all(
//                                       color:
//                                           item['stockStatus'] == 'out_of_stock'
//                                               ? Colors.grey[200]!
//                                               : Colors.grey[300]!),
//                                   borderRadius: BorderRadius.circular(6),
//                                   color: item['stockStatus'] == 'out_of_stock'
//                                       ? Colors.grey[100]
//                                       : Colors.white,
//                                 ),
//                                 child: Icon(
//                                   Icons.remove,
//                                   size: 16,
//                                   color: item['stockStatus'] == 'out_of_stock'
//                                       ? Colors.grey[400]
//                                       : Colors.black87,
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
//                                       ? Colors.grey[400]
//                                       : Colors.black87,
//                                 ),
//                               ),
//                             ),
//                             GestureDetector(
//                               onTap: item['stockStatus'] == 'out_of_stock'
//                                   ? null
//                                   : () => updateQuantity(
//                                       index, item['quantity'] + 1),
//                               child: Container(
//                                 width: 32,
//                                 height: 32,
//                                 decoration: BoxDecoration(
//                                   border: Border.all(
//                                       color:
//                                           item['stockStatus'] == 'out_of_stock'
//                                               ? Colors.grey[200]!
//                                               : Colors.grey[300]!),
//                                   borderRadius: BorderRadius.circular(6),
//                                   color: item['stockStatus'] == 'out_of_stock'
//                                       ? Colors.grey[100]
//                                       : Colors.white,
//                                 ),
//                                 child: Icon(
//                                   Icons.add,
//                                   size: 16,
//                                   color: item['stockStatus'] == 'out_of_stock'
//                                       ? Colors.grey[400]
//                                       : Colors.black87,
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
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Row(
//                       children: [
//                         ElevatedButton(
//                           onPressed: () {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                   content: Text('Item added to cart')),
//                             );
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor:
//                                 const Color(0xFF2C3E50),
//                             foregroundColor: Colors.white,
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 20, vertical: 12),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                           ),
//                           child: const Text('Add to Cart'),
//                         ),
//                       ],
//                     )
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
//     return allCartItems.fold(0, (sum, item) {
//       if (item['stockStatus'] != 'out_of_stock') {
//         return sum + (item['price'] as int) * (item['quantity'] as int);
//       }
//       return sum;
//     });
//   }

//   int getTotalSavings() {
//     return allCartItems.fold(0, (sum, item) {
//       if (item['stockStatus'] != 'out_of_stock') {
//         return sum +
//             ((item['originalPrice'] as int) - (item['price'] as int)) *
//                 (item['quantity'] as int);
//       }
//       return sum;
//     });
//   }

//   int getAvailableItemsCount() {
//     return allCartItems
//         .where((item) => item['stockStatus'] != 'out_of_stock')
//         .length;
//   }

//   bool hasOutOfStockItems() {
//     return allCartItems.any((item) => item['stockStatus'] == 'out_of_stock');
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
//         // actions: [
//         //   IconButton(
//         //     icon: const Icon(Icons.more_vert, color: Colors.black87),
//         //     onPressed: () {},
//         //   ),
//         // ],
//         bottom: TabBar(
//           controller: _tabController,
//           isScrollable: true,
//           labelColor: const Color(0xFF2C3E50),
//           unselectedLabelColor: Colors.grey[600],
//           labelStyle: const TextStyle(
//             fontWeight: FontWeight.w600,
//             fontSize: 14,
//           ),
//           unselectedLabelStyle: const TextStyle(
//             fontWeight: FontWeight.w500,
//             fontSize: 14,
//           ),
//           indicatorColor: const Color(0xFF2C3E50),
//           indicatorWeight: 3,
//           indicatorSize: TabBarIndicatorSize.tab,
//           tabs: categories.map((category) {
//             return Tab(
//               text: category['label'],
//             );
//           }).toList(),
//         ),
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
//                   selectedCategory == 'all'
//                       ? '${allCartItems.length} items in cart'
//                       : '${cartItems.length} ${categories.firstWhere((cat) => cat['key'] == selectedCategory)['label']} items in cart',
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey[700],
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 if (hasOutOfStockItems()) ...[
//                   const SizedBox(height: 8),
//                 ],
//               ],
//             ),
//           ),
//           const SizedBox(height: 8),
//           // Cart Items List
//           Expanded(
//             child: cartItems.isEmpty
//                 ? Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.shopping_cart_outlined,
//                           size: 64,
//                           color: Colors.grey[400],
//                         ),
//                         const SizedBox(height: 16),
//                         Text(
//                           'No items in this category',
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Colors.grey[600],
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                 : ListView.builder(
//                     padding: const EdgeInsets.only(bottom: 16),
//                     itemCount: cartItems.length,
//                     itemBuilder: (context, index) {
//                       return buildCartItem(cartItems[index], index,
//                           const AlwaysStoppedAnimation(1.0));
//                     },
//                   ),
//           ),
//           // Bottom Summary and Checkout
//           Container(
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius:
//                   const BorderRadius.vertical(top: Radius.circular(20)),
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
//                     onPressed: getAvailableItemsCount() > 0
//                         ? () {
//                             if (hasOutOfStockItems()) {
//                               showDialog(
//                                 context: context,
//                                 builder: (BuildContext context) {
//                                   return AlertDialog(
//                                     title: const Text('Confirm Checkout'),
//                                     content: const Text(
//                                         'Some items are out of stock and will be removed from your order. Do you want to proceed with available items?'),
//                                     actions: [
//                                       TextButton(
//                                         onPressed: () =>
//                                             Navigator.of(context).pop(),
//                                         child: const Text('Cancel'),
//                                       ),
//                                       ElevatedButton(
//                                         onPressed: () {
//                                           Navigator.of(context).pop();
//                                           ScaffoldMessenger.of(context)
//                                               .showSnackBar(
//                                             const SnackBar(
//                                               content: Text(
//                                                   "Proceeding to Checkout with available items..."),
//                                               backgroundColor: Colors.green,
//                                             ),
//                                           );
//                                         },
//                                         child: const Text('Proceed'),
//                                       ),
//                                     ],
//                                   );
//                                 },
//                               );
//                             } else {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(
//                                   content: Text("Proceeding to Checkout..."),
//                                   backgroundColor: Colors.green,
//                                 ),
//                               );
//                             }
//                           }
//                         : null,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: getAvailableItemsCount() > 0
//                           ? const Color(0xFF2C3E50)
//                           : Colors.grey[400],
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
//                           color: getAvailableItemsCount() > 0
//                               ? Colors.white
//                               : Colors.grey[600],
//                         ),
//                         const SizedBox(width: 8),
//                         Text(
//                           getAvailableItemsCount() > 0
//                               ? 'Proceed to Checkout'
//                               : 'No Items Available',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                             color: getAvailableItemsCount() > 0
//                                 ? Colors.white
//                                 : Colors.grey[600],
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






















// // import 'package:flutter/material.dart';

// // class CartScreen extends StatefulWidget {
// //   const CartScreen({super.key});

// //   @override
// //   State<CartScreen> createState() => _CartScreenState();
// // }

// // class _CartScreenState extends State<CartScreen> {
// //   final List<Map<String, dynamic>> cartItems = [
// //     {
// //       'name': 'Professional Cricket Bat',
// //       'price': 14999,
// //       'originalPrice': 19999,
// //       'category': 'Equipment • cricket',
// //       'rating': 4.8,
// //       'image': 'https://images.unsplash.com/photo-1540747913346-19e32dc3e97e?w=400&h=400&fit=crop',
// //       'quantity': 1,
// //       'stock': 5,
// //       'sku': 'CB-001',
// //     },
// //     {
// //       'name': 'Sports T-Shirt',
// //       'price': 2999,
// //       'originalPrice': 3999,
// //       'category': 'Apparel • sports',
// //       'rating': 4.5,
// //       'image': 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=400&h=400&fit=crop',
// //       'quantity': 2,
// //       'stock': 25,
// //       'sku': 'TS-002',
// //     },
// //     {
// //       'name': 'Tennis Racket',
// //       'price': 7999,
// //       'originalPrice': 9999,
// //       'category': 'Equipment • tennis',
// //       'rating': 4.6,
// //       'image': 'https://images.unsplash.com/photo-1551698618-1dfe5d97d256?w=400&h=400&fit=crop',
// //       'quantity': 1,
// //       'stock': 15,
// //       'sku': 'TR-004',
// //     },
// //   ];

// //   void removeItem(int index) {
// //     setState(() {
// //       cartItems.removeAt(index);
// //     });
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       const SnackBar(
// //         content: Text('Item removed from cart'),
// //         duration: Duration(seconds: 2),
// //       ),
// //     );
// //   }

// //   void updateQuantity(int index, int newQuantity) {
// //     if (newQuantity > 0 && newQuantity <= cartItems[index]['stock']) {
// //       setState(() {
// //         cartItems[index]['quantity'] = newQuantity;
// //       });
// //     } else if (newQuantity > cartItems[index]['stock']) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(
// //           content: Text('Only ${cartItems[index]['stock']} items available'),
// //           backgroundColor: Colors.orange,
// //           duration: const Duration(seconds: 2),
// //         ),
// //       );
// //     }
// //   }

// //   int getTotalPrice() {
// //     return cartItems.fold(0, (sum, item) {
// //       return sum + (item['price'] as int) * (item['quantity'] as int);
// //     });
// //   }

// //   int getTotalSavings() {
// //     return cartItems.fold(0, (sum, item) {
// //       return sum + 
// //           ((item['originalPrice'] as int) - (item['price'] as int)) * 
// //           (item['quantity'] as int);
// //     });
// //   }

// //   Widget buildCartItem(Map<String, dynamic> item, int index) {
// //     return Container(
// //       margin: const EdgeInsets.only(bottom: 16),
// //       padding: const EdgeInsets.all(16),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(8),
// //         border: Border.all(color: Colors.grey[200]!),
// //       ),
// //       child: Row(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           // Product Image
// //           Container(
// //             width: 80,
// //             height: 80,
// //             decoration: BoxDecoration(
// //               borderRadius: BorderRadius.circular(8),
// //               color: Colors.grey[100],
// //             ),
// //             child: ClipRRect(
// //               borderRadius: BorderRadius.circular(8),
// //               child: Image.network(
// //                 item['image'],
// //                 fit: BoxFit.cover,
// //                 errorBuilder: (context, error, stackTrace) {
// //                   return Container(
// //                     color: Colors.grey[200],
// //                     child: Icon(
// //                       Icons.sports,
// //                       size: 40,
// //                       color: Colors.grey[400],
// //                     ),
// //                   );
// //                 },
// //               ),
// //             ),
// //           ),
// //           const SizedBox(width: 16),
// //           // Product Details
// //           Expanded(
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(
// //                   item['name'],
// //                   style: const TextStyle(
// //                     fontSize: 16,
// //                     fontWeight: FontWeight.w600,
// //                     color: Colors.black87,
// //                   ),
// //                 ),
// //                 const SizedBox(height: 4),
// //                 Text(
// //                   item['category'],
// //                   style: TextStyle(
// //                     fontSize: 12,
// //                     color: Colors.grey[600],
// //                   ),
// //                 ),
// //                 const SizedBox(height: 8),
// //                 // Rating
// //                 Row(
// //                   children: [
// //                     ...List.generate(5, (starIndex) {
// //                       return Icon(
// //                         starIndex < item['rating'].floor()
// //                             ? Icons.star
// //                             : starIndex < item['rating']
// //                                 ? Icons.star_half
// //                                 : Icons.star_border,
// //                         size: 14,
// //                         color: Colors.amber,
// //                       );
// //                     }),
// //                     const SizedBox(width: 4),
// //                     Text(
// //                       '(${item['rating']})',
// //                       style: TextStyle(
// //                         fontSize: 12,
// //                         color: Colors.grey[600],
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //                 const SizedBox(height: 12),
// //                 // Price
// //                 Row(
// //                   children: [
// //                     Text(
// //                       '₹${item['price']}',
// //                       style: const TextStyle(
// //                         fontSize: 18,
// //                         fontWeight: FontWeight.bold,
// //                         color: Colors.black87,
// //                       ),
// //                     ),
// //                     const SizedBox(width: 8),
// //                     Text(
// //                       '₹${item['originalPrice']}',
// //                       style: TextStyle(
// //                         fontSize: 14,
// //                         decoration: TextDecoration.lineThrough,
// //                         color: Colors.grey[500],
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //                 const SizedBox(height: 16),
// //                 // Quantity and Remove
// //                 Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   children: [
// //                     // Quantity Controls
// //                     Row(
// //                       children: [
// //                         GestureDetector(
// //                           onTap: () {
// //                             if (item['quantity'] > 1) {
// //                               updateQuantity(index, item['quantity'] - 1);
// //                             }
// //                           },
// //                           child: Container(
// //                             width: 32,
// //                             height: 32,
// //                             decoration: BoxDecoration(
// //                               border: Border.all(color: Colors.grey[300]!),
// //                               borderRadius: BorderRadius.circular(6),
// //                             ),
// //                             child: const Icon(
// //                               Icons.remove,
// //                               size: 16,
// //                               color: Colors.black54,
// //                             ),
// //                           ),
// //                         ),
// //                         Container(
// //                           width: 50,
// //                           height: 32,
// //                           alignment: Alignment.center,
// //                           child: Text(
// //                             '${item['quantity']}',
// //                             style: const TextStyle(
// //                               fontSize: 16,
// //                               fontWeight: FontWeight.w600,
// //                             ),
// //                           ),
// //                         ),
// //                         GestureDetector(
// //                           onTap: () => updateQuantity(index, item['quantity'] + 1),
// //                           child: Container(
// //                             width: 32,
// //                             height: 32,
// //                             decoration: BoxDecoration(
// //                               border: Border.all(color: Colors.grey[300]!),
// //                               borderRadius: BorderRadius.circular(6),
// //                             ),
// //                             child: const Icon(
// //                               Icons.add,
// //                               size: 16,
// //                               color: Colors.black54,
// //                             ),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                     // Remove Button
// //                     GestureDetector(
// //                       onTap: () => removeItem(index),
// //                       child: Container(
// //                         padding: const EdgeInsets.all(8),
// //                         child: Icon(
// //                           Icons.delete_outline,
// //                           color: Colors.grey[600],
// //                           size: 20,
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.grey[50],
// //       appBar: AppBar(
// //         title: const Text(
// //           'My Cart',
// //           style: TextStyle(
// //             fontWeight: FontWeight.bold,
// //             color: Colors.black87,
// //             fontSize: 20,
// //           ),
// //         ),
// //         centerTitle: true,
// //         backgroundColor: Colors.white,
// //         elevation: 0,
// //         automaticallyImplyLeading: false,
// //         // leading: IconButton(
// //         //   icon: const Icon(Icons.arrow_back_ios, color: Colors.black87, size: 20),
// //         //   onPressed: () => Navigator.of(context).pop(),
// //         // ),
// //         bottom: PreferredSize(
// //           preferredSize: const Size.fromHeight(1),
// //           child: Container(
// //             height: 1,
// //             color: Colors.grey[200],
// //           ),
// //         ),
// //       ),
// //       body: cartItems.isEmpty
// //           ? Center(
// //               child: Column(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   Icon(
// //                     Icons.shopping_cart_outlined,
// //                     size: 80,
// //                     color: Colors.grey[400],
// //                   ),
// //                   const SizedBox(height: 16),
// //                   Text(
// //                     'Your cart is empty',
// //                     style: TextStyle(
// //                       fontSize: 18,
// //                       color: Colors.grey[600],
// //                       fontWeight: FontWeight.w500,
// //                     ),
// //                   ),
// //                   const SizedBox(height: 8),
// //                   Text(
// //                     'Add some items to get started',
// //                     style: TextStyle(
// //                       fontSize: 14,
// //                       color: Colors.grey[500],
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             )
// //           : Column(
// //               children: [
// //                 // Cart Items List
// //                 Expanded(
// //                   child: ListView(
// //                     padding: const EdgeInsets.all(16),
// //                     children: [
// //                       // Items Count
// //                       Padding(
// //                         padding: const EdgeInsets.only(bottom: 16),
// //                         child: Text(
// //                           '${cartItems.length} item${cartItems.length != 1 ? 's' : ''} in cart',
// //                           style: TextStyle(
// //                             fontSize: 16,
// //                             fontWeight: FontWeight.w500,
// //                             color: Colors.grey[700],
// //                           ),
// //                         ),
// //                       ),
// //                       // Cart Items
// //                       ...cartItems.asMap().entries.map((entry) {
// //                         int index = entry.key;
// //                         Map<String, dynamic> item = entry.value;
// //                         return buildCartItem(item, index);
// //                       }).toList(),
// //                     ],
// //                   ),
// //                 ),
// //                 // Bottom Summary
// //                 Container(
// //                   padding: const EdgeInsets.all(20),
// //                   decoration: BoxDecoration(
// //                     color: Colors.white,
// //                     borderRadius: const BorderRadius.vertical(
// //                       top: Radius.circular(16),
// //                     ),
// //                     boxShadow: [
// //                       BoxShadow(
// //                         color: Colors.black.withOpacity(0.08),
// //                         blurRadius: 10,
// //                         offset: const Offset(0, -2),
// //                       ),
// //                     ],
// //                   ),
// //                   child: Column(
// //                     children: [
// //                       // Price Breakdown
// //                       Row(
// //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                         children: [
// //                           Text(
// //                             'Subtotal',
// //                             style: TextStyle(
// //                               fontSize: 16,
// //                               color: Colors.grey[700],
// //                             ),
// //                           ),
// //                           Text(
// //                             '₹${getTotalPrice() + getTotalSavings()}',
// //                             style: TextStyle(
// //                               fontSize: 16,
// //                               decoration: TextDecoration.lineThrough,
// //                               color: Colors.grey[600],
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                       const SizedBox(height: 8),
// //                       Row(
// //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                         children: [
// //                           Text(
// //                             'Discount',
// //                             style: TextStyle(
// //                               fontSize: 16,
// //                               color: Colors.green[700],
// //                             ),
// //                           ),
// //                           Text(
// //                             '-₹${getTotalSavings()}',
// //                             style: TextStyle(
// //                               fontSize: 16,
// //                               fontWeight: FontWeight.w600,
// //                               color: Colors.green[700],
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                       Padding(
// //                         padding: const EdgeInsets.symmetric(vertical: 16),
// //                         child: Divider(
// //                           height: 1,
// //                           color: Colors.grey[200],
// //                         ),
// //                       ),
// //                       Row(
// //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                         children: [
// //                           const Text(
// //                             'Total',
// //                             style: TextStyle(
// //                               fontSize: 20,
// //                               fontWeight: FontWeight.bold,
// //                               color: Colors.black87,
// //                             ),
// //                           ),
// //                           Text(
// //                             '₹${getTotalPrice()}',
// //                             style: const TextStyle(
// //                               fontSize: 20,
// //                               fontWeight: FontWeight.bold,
// //                               color: Colors.black87,
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                       const SizedBox(height: 20),
// //                       // Checkout Button
// //                       SizedBox(
// //                         width: double.infinity,
// //                         child: ElevatedButton(
// //                           onPressed: cartItems.isNotEmpty
// //                               ? () {
// //                                   ScaffoldMessenger.of(context).showSnackBar(
// //                                     const SnackBar(
// //                                       content: Text("Proceeding to Checkout..."),
// //                                       backgroundColor: Colors.green,
// //                                     ),
// //                                   );
// //                                 }
// //                               : null,
// //                           style: ElevatedButton.styleFrom(
// //                             backgroundColor: const Color(0xFF2C3E50),
// //                             foregroundColor: Colors.white,
// //                             padding: const EdgeInsets.symmetric(vertical: 16),
// //                             shape: RoundedRectangleBorder(
// //                               borderRadius: BorderRadius.circular(10),
// //                             ),
// //                             elevation: 2,
// //                           ),
// //                           child: const Text(
// //                             'Proceed to Checkout',
// //                             style: TextStyle(
// //                               fontSize: 16,
// //                               fontWeight: FontWeight.w600,
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ],
// //             ),
// //     );
// //   }
// // }




































import 'package:booking_application/views/order/order_hystory_screen.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with TickerProviderStateMixin {
  final List<Map<String, dynamic>> allProducts = [
    {
      'name': 'Professional Cricket Bat',
      'price': 14999,
      'originalPrice': 19999,
      'category': 'Equipment • cricket',
      'rating': 4.8,
      'image': 'assets/cricket_bat.jpg',
      'isBestseller': true,
      'quantity': 0,
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
      'quantity': 0,
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
      'quantity': 0,
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
      'quantity': 0,
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
      'quantity': 0,
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
      'quantity': 0,
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
      'quantity': 0,
      'stock': 6,
      'sku': 'FBt-007',
      'stockStatus': 'low',
      'filterCategory': 'football',
    },
    {
      'name': 'Professional Badminton Racket',
      'price': 5999,
      'originalPrice': 7999,
      'category': 'Equipment • badminton',
      'rating': 4.7,
      'image': 'assets/badminton_racket.jpg',
      'isBestseller': true,
      'quantity': 0,
      'stock': 10,
      'sku': 'BR-008',
      'stockStatus': 'in_stock',
      'filterCategory': 'badminton',
    },
    {
      'name': 'Premium Cricket Balls (Set of 6)',
      'price': 4999,
      'originalPrice': 5999,
      'category': 'Equipment • cricket',
      'rating': 4.6,
      'image': 'assets/cricket_balls.jpg',
      'isBestseller': false,
      'quantity': 0,
      'stock': 20,
      'sku': 'CBalls-009',
      'stockStatus': 'in_stock',
      'filterCategory': 'cricket',
    },
    {
      'name': 'Badminton Shuttlecocks (Pack of 12)',
      'price': 1999,
      'originalPrice': 2499,
      'category': 'Equipment • badminton',
      'rating': 4.4,
      'image': 'assets/shuttlecocks.jpg',
      'isBestseller': false,
      'quantity': 0,
      'stock': 30,
      'sku': 'SC-010',
      'stockStatus': 'in_stock',
      'filterCategory': 'badminton',
    },
    {
      'name': 'Cricket Batting Gloves',
      'price': 3999,
      'originalPrice': 4999,
      'category': 'Accessories • cricket',
      'rating': 4.5,
      'image': 'assets/batting_gloves.jpg',
      'isBestseller': false,
      'quantity': 0,
      'stock': 15,
      'sku': 'BG-011',
      'stockStatus': 'in_stock',
      'filterCategory': 'cricket',
    },
    {
      'name': 'Sports Performance T-Shirt',
      'price': 2999,
      'originalPrice': 3499,
      'category': 'Apparel • All Sports',
      'rating': 4.3,
      'image': 'assets/performance_tshirt.jpg',
      'isBestseller': false,
      'quantity': 0,
      'stock': 25,
      'sku': 'PT-012',
      'stockStatus': 'in_stock',
      'filterCategory': 'sports',
    },
  ];

  late TabController _tabController;
  List<Map<String, dynamic>> displayedProducts = [];
  String selectedCategory = 'all';
  List<Map<String, dynamic>> cartItems = [];

  final List<Map<String, String>> categories = [
    {'key': 'all', 'label': 'All Products'},
    {'key': 'cricket', 'label': 'Cricket'},
    {'key': 'football', 'label': 'Football'},
    {'key': 'tennis', 'label': 'Tennis'},
    {'key': 'running', 'label': 'Running'},
    {'key': 'sports', 'label': 'Sports'},
    {'key': 'badminton', 'label': 'Badminton'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: categories.length, vsync: this);
    displayedProducts = List.from(allProducts);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          selectedCategory = categories[_tabController.index]['key']!;
          filterProducts();
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void filterProducts() {
    setState(() {
      if (selectedCategory == 'all') {
        displayedProducts = List.from(allProducts);
      } else {
        displayedProducts = allProducts
            .where((product) => product['filterCategory'] == selectedCategory)
            .toList();
      }
    });
  }

  void addToCart(Map<String, dynamic> product) {
    if (product['stockStatus'] != 'out_of_stock') {
      setState(() {
        product['quantity'] = (product['quantity'] as int) + 1;
      });
      
      // Add to cart items if not already there
      final existingIndex = cartItems.indexWhere((item) => item['sku'] == product['sku']);
      if (existingIndex != -1) {
        cartItems[existingIndex]['quantity'] = product['quantity'];
      } else {
        cartItems.add(Map.from(product));
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${product['name']} added to cart'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  Widget buildStockIndicator(Map<String, dynamic> product) {
    final stock = product['stock'] as int;
    final stockStatus = product['stockStatus'] as String;

    Color statusColor;
    String statusText;

    switch (stockStatus) {
      case 'out_of_stock':
        statusColor = Colors.red;
        statusText = 'Out of Stock';
        break;
      case 'low':
        statusColor = Colors.orange;
        statusText = 'Only $stock left';
        break;
      case 'in_stock':
        statusColor = Colors.green;
        statusText = 'In Stock';
        break;
      default:
        statusColor = Colors.grey;
        statusText = 'Unknown';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: statusColor.withOpacity(0.3)),
      ),
      child: Text(
        statusText,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: statusColor,
        ),
      ),
    );
  }

  Widget buildProductCard(Map<String, dynamic> product) {
    return Container(
      // margin: const EdgeInsets.all(8),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image with Badges
          Stack(
            children: [
              Container(
                height: 68,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  color: Colors.grey[200],
                  image: const DecorationImage(
                    image: NetworkImage(
                        'https://i.pinimg.com/originals/f5/f8/9b/f5f89bb422eafe7da71f7f6d9d221a6f.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              if (product['isBestseller'])
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
              // Positioned(
              //   top: 8,
              //   right: 8,
              //   child: Container(
              //     padding: const EdgeInsets.all(6),
              //     decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.circular(20),
              //     ),
              //     child: const Icon(
              //       Icons.favorite_border,
              //       size: 16,
              //       color: Colors.grey,
              //     ),
              //   ),
              // ),
            ],
          ),
          // Product Details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name'],
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product['category'],
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      ...List.generate(5, (starIndex) {
                        return Icon(
                          starIndex < product['rating'].floor()
                              ? Icons.star
                              : starIndex < product['rating']
                                  ? Icons.star_half
                                  : Icons.star_border,
                          size: 12,
                          color: Colors.amber,
                        );
                      }),
                      const SizedBox(width: 4),
                      Text(
                        '(${product['rating']})',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  // const SizedBox(height: 6),
                  // buildStockIndicator(product),
                  // const Spacer(),
                  Row(
                    children: [
                      Text(
                        '₹${product['price']}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '₹${product['originalPrice']}',
                        style: TextStyle(
                          fontSize: 12,
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: product['stockStatus'] == 'out_of_stock' 
                          ? null 
                          : () => addToCart(product),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: product['stockStatus'] == 'out_of_stock'
                            ? Colors.grey[400]
                            : const Color(0xFF2C3E50),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: product['stockStatus'] == 'out_of_stock' ? 0 : 2,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            product['stockStatus'] == 'out_of_stock' 
                                ? Icons.block 
                                : Icons.shopping_cart,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            product['quantity'] > 0 
                                ? 'Added (${product['quantity']})'
                                : product['stockStatus'] == 'out_of_stock'
                                    ? 'Out of Stock'
                                    : 'Add to Cart',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  int getCartItemsCount() {
    return allProducts.fold(0, (sum, product) => sum + (product['quantity'] as int));
  }

  int getTotalPrice() {
    return allProducts.fold(0, (sum, product) {
      if (product['quantity'] > 0) {
        return sum + (product['price'] as int) * (product['quantity'] as int);
      }
      return sum;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Sports Shop',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        automaticallyImplyLeading: false,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart, color: Colors.black87),
                onPressed: () {
                  // Navigate to cart view
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Cart Items',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Expanded(
                            child: ListView.builder(
                              itemCount: allProducts.where((p) => p['quantity'] > 0).length,
                              itemBuilder: (context, index) {
                                final cartProduct = allProducts.where((p) => p['quantity'] > 0).toList()[index];
                                return ListTile(
                                  leading: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.grey[200],
                                    ),
                                  ),
                                  title: Text(cartProduct['name']),
                                  subtitle: Text('₹${cartProduct['price']} x ${cartProduct['quantity']}'),
                                  trailing: Text(
                                    '₹${cartProduct['price'] * cartProduct['quantity']}',
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                );
                              },
                            ),
                          ),
                          if (getCartItemsCount() > 0) ...[
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Total:',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '₹${getTotalPrice()}',
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
  onPressed: () {
    Navigator.pop(context); // Close the cart modal
    
    // Get cart items for the order
    final cartItemsForOrder = allProducts.where((p) => p['quantity'] > 0).toList();
    
    // Navigate to Order History Screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderHistoryScreen(
          cartItems: cartItemsForOrder,
          totalAmount: getTotalPrice(),
        ),
      ),
    );
    
    // Clear the cart after checkout
    setState(() {
      for (var product in allProducts) {
        product['quantity'] = 0;
      }
      cartItems.clear();
    });
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF2C3E50),
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(vertical: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
  child: const Text('Checkout'),
),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
              if (getCartItemsCount() > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '${getCartItemsCount()}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
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
            return Tab(text: category['label']);
          }).toList(),
        ),
      ),
      body: Column(
        children: [
          // Products Count
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Text(
              selectedCategory == 'all'
                  ? '${allProducts.length} products available'
                  : '${displayedProducts.length} ${categories.firstWhere((cat) => cat['key'] == selectedCategory)['label']} products',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Products Grid
          Expanded(
            child: displayedProducts.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inventory_2_outlined,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No products in this category',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(8),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: displayedProducts.length,
                    itemBuilder: (context, index) {
                      return buildProductCard(displayedProducts[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}