import 'package:flutter/material.dart';

class OrderHistoryScreen extends StatefulWidget {
  final List<Map<String, dynamic>>? cartItems;
  final int? totalAmount;

  const OrderHistoryScreen({
    super.key,
    this.cartItems,
    this.totalAmount,
  });

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen>
    with TickerProviderStateMixin {
  List<Map<String, dynamic>> orders = [];
  late TabController _tabController;
  String selectedStatus = 'all';

  final List<Map<String, String>> statusCategories = [
    {'key': 'all', 'label': 'All Orders'},
    {'key': 'delivered', 'label': 'Delivered'},
    {'key': 'processing', 'label': 'Processing'},
    {'key': 'shipped', 'label': 'Shipped'},
    {'key': 'cancelled', 'label': 'Cancelled'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: statusCategories.length, vsync: this);
    _initializeOrders();

    // Add new order if coming from checkout
    if (widget.cartItems != null && widget.totalAmount != null) {
      _addNewOrder();
    }

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          selectedStatus = statusCategories[_tabController.index]['key']!;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _initializeOrders() {
    // Sample order history data
    orders = [
      {
        'orderId': 'ORD-001',
        'orderDate': '2025-01-20',
        'status': 'delivered',
        'totalAmount': 22998,
        'itemCount': 3,
        'deliveryDate': '2025-01-25',
        'items': [
          {
            'name': 'Professional Cricket Bat',
            'price': 14999,
            'quantity': 1,
            'image': 'assets/cricket_bat.jpg',
          },
          {
            'name': 'Cricket Gloves',
            'price': 2499,
            'quantity': 2,
            'image': 'assets/cricket_gloves.jpg',
          },
          {
            'name': 'Sports T-Shirt',
            'price': 2999,
            'quantity': 2,
            'image': 'assets/tshirt.jpg',
          },
        ],
        'shippingAddress': '123 Sports Street, Cricket Colony, Hyderabad - 500001',
        'paymentMethod': 'UPI',
      },
      {
        'orderId': 'ORD-002',
        'orderDate': '2025-01-15',
        'status': 'shipped',
        'totalAmount': 15998,
        'itemCount': 2,
        'deliveryDate': '2025-01-28',
        'items': [
          {
            'name': 'Tennis Racket',
            'price': 7999,
            'quantity': 1,
            'image': 'assets/tennis_racket.jpg',
          },
          {
            'name': 'Running Shoes',
            'price': 9999,
            'quantity': 1,
            'image': 'assets/shoes.jpg',
          },
        ],
        'shippingAddress': '456 Game Avenue, Sports City, Hyderabad - 500002',
        'paymentMethod': 'Credit Card',
      },
      {
        'orderId': 'ORD-003',
        'orderDate': '2025-01-10',
        'status': 'processing',
        'totalAmount': 8998,
        'itemCount': 2,
        'deliveryDate': '2025-01-30',
        'items': [
          {
            'name': 'Football',
            'price': 3999,
            'quantity': 1,
            'image': 'assets/football.jpg',
          },
          {
            'name': 'Badminton Racket',
            'price': 5999,
            'quantity': 1,
            'image': 'assets/badminton_racket.jpg',
          },
        ],
        'shippingAddress': '789 Play Ground, Athletic Area, Hyderabad - 500003',
        'paymentMethod': 'Debit Card',
      },
      {
        'orderId': 'ORD-004',
        'orderDate': '2025-01-05',
        'status': 'cancelled',
        'totalAmount': 12998,
        'itemCount': 1,
        'deliveryDate': 'N/A',
        'items': [
          {
            'name': 'Football Boots',
            'price': 8999,
            'quantity': 1,
            'image': 'assets/football_boots.jpg',
          },
        ],
        'shippingAddress': '321 Sport Lane, Game District, Hyderabad - 500004',
        'paymentMethod': 'Cash on Delivery',
        'cancellationReason': 'Size not available',
      },
    ];
  }

  void _addNewOrder() {
    if (widget.cartItems == null || widget.cartItems!.isEmpty) return;

    final newOrder = {
      'orderId': 'ORD-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
      'orderDate': DateTime.now().toIso8601String().substring(0, 10),
      'status': 'processing',
      'totalAmount': widget.totalAmount!,
      'itemCount': widget.cartItems!.fold<int>(0, (sum, item) => sum + (item['quantity'] as int)),
      'deliveryDate': DateTime.now().add(const Duration(days: 7)).toIso8601String().substring(0, 10),
      'items': widget.cartItems!.where((item) => item['quantity'] > 0).map((item) => {
        'name': item['name'],
        'price': item['price'],
        'quantity': item['quantity'],
        'image': item['image'],
      }).toList(),
      'shippingAddress': 'Default Address, Hyderabad - 500001',
      'paymentMethod': 'UPI',
    };

    setState(() {
      orders.insert(0, newOrder);
    });

    // Show success message
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Order ${newOrder['orderId']} placed successfully!'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
        ),
      );
    });
  }

  List<Map<String, dynamic>> getFilteredOrders() {
    if (selectedStatus == 'all') return orders;
    return orders.where((order) => order['status'] == selectedStatus).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'delivered':
        return Colors.green;
      case 'shipped':
        return Colors.blue;
      case 'processing':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String getStatusDisplayText(String status) {
    switch (status) {
      case 'delivered':
        return 'Delivered';
      case 'shipped':
        return 'Shipped';
      case 'processing':
        return 'Processing';
      case 'cancelled':
        return 'Cancelled';
      default:
        return 'Unknown';
    }
  }

  Widget buildOrderCard(Map<String, dynamic> order) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
        children: [
          // Order Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order ${order['orderId']}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Placed on ${order['orderDate']}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: getStatusColor(order['status']).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: getStatusColor(order['status']).withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    getStatusDisplayText(order['status']),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: getStatusColor(order['status']),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Order Items Preview
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    // Items preview images
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: (order['items'] as List).length > 3 ? 3 : (order['items'] as List).length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 40,
                            height: 40,
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                              image: const DecorationImage(
                                image: NetworkImage(
                                  'https://i.pinimg.com/originals/f5/f8/9b/f5f89bb422eafe7da71f7f6d9d221a6f.jpg',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    if ((order['items'] as List).length > 3)
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            '+${(order['items'] as List).length - 3}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '₹${order['totalAmount']}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          '${order['itemCount']} item${order['itemCount'] > 1 ? 's' : ''}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => _showOrderDetails(order),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF2C3E50)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'View Details',
                          style: TextStyle(
                            color: Color(0xFF2C3E50),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    if (order['status'] == 'delivered')
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Reorder functionality coming soon!'),
                                backgroundColor: Colors.blue,
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2C3E50),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Reorder',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    if (order['status'] == 'processing')
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _showCancelDialog(order),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showOrderDetails(Map<String, dynamic> order) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Order ${order['orderId']}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: getStatusColor(order['status']).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: getStatusColor(order['status']).withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    getStatusDisplayText(order['status']),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: getStatusColor(order['status']),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Order Details',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Order Date:'),
                      Text(order['orderDate']),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Expected Delivery:'),
                      Text(order['deliveryDate'] ?? 'N/A'),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Payment Method:'),
                      Text(order['paymentMethod']),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Items',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: (order['items'] as List).length,
                itemBuilder: (context, index) {
                  final item = (order['items'] as List)[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                            image: const DecorationImage(
                              image: NetworkImage(
                                'https://i.pinimg.com/originals/f5/f8/9b/f5f89bb422eafe7da71f7f6d9d221a6f.jpg',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['name'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'Qty: ${item['quantity']}',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '₹${item['price'] * item['quantity']}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Amount:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '₹${order['totalAmount']}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showCancelDialog(Map<String, dynamic> order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Order'),
        content: Text('Are you sure you want to cancel order ${order['orderId']}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                order['status'] = 'cancelled';
                order['cancellationReason'] = 'Cancelled by user';
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Order ${order['orderId']} cancelled successfully'),
                  backgroundColor: Colors.orange,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Yes, Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredOrders = getFilteredOrders();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Order History',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black87),
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
          tabs: statusCategories.map((category) {
            final count = category['key'] == 'all' 
                ? orders.length 
                : orders.where((order) => order['status'] == category['key']).length;
            return Tab(
              text: '${category['label']} ${count > 0 ? '($count)' : ''}',
            );
          }).toList(),
        ),
      ),
      body: filteredOrders.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    selectedStatus == 'all'
                        ? 'No orders yet'
                        : 'No ${getStatusDisplayText(selectedStatus).toLowerCase()} orders',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Start shopping to see your orders here',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2C3E50),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Continue Shopping'),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemCount: filteredOrders.length,
              itemBuilder: (context, index) {
                return buildOrderCard(filteredOrders[index]);
              },
            ),
    );
  }
}