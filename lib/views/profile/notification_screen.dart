// import 'package:flutter/material.dart';

// class NotificationScreen extends StatelessWidget {
//   const NotificationScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(onPressed: (){
//           Navigator.of(context).pop();
//         }, icon: Icon(Icons.arrow_back)),
//         title: const Text('Notifications',style: TextStyle(fontWeight: FontWeight.bold),),
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         elevation: 0.5,
//       ),
//       body: ListView.builder(
//         padding: const EdgeInsets.all(16),
//         itemCount: 2, // You can dynamically change this
//         itemBuilder: (context, index) {
//           return Container(
            
//             margin: const EdgeInsets.only(bottom: 16),
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
              
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.1),
//                   spreadRadius: 1,
//                   blurRadius: 4,
//                 ),
//               ],
//               border: Border.all(color: const Color.fromARGB(255, 129, 128, 128)),
//             ),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 CircleAvatar(
//                   backgroundImage: AssetImage('lib/assets/bc343ff763667486407a9dd7f8e58fd9ae581649.png'),
//                   // child: Image.asset('lib/assets/bc343ff763667486407a9dd7f8e58fd9ae581649.png'),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: const [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Expanded(
//                             child: Text(
//                               "Your Tournament Slot Has Confirmed",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: 8),
//                           Text(
//                             "1 days ago",
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: Colors.grey,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 4),
//                       Text(
//                         "Lorem Ipsem Delopt Wmd",
//                         style: TextStyle(
//                           fontSize: 13,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }


















import 'package:booking_application/provider/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch notifications when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NotificationProvider>().fetchNotifications();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Consumer<NotificationProvider>(
          builder: (context, provider, child) {
            return Row(
              children: [
                const Text(
                  'Notifications',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                if (provider.unreadCount > 0) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${provider.unreadCount}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ],
            );
          },
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
        actions: [
          Consumer<NotificationProvider>(
            builder: (context, provider, child) {
              return PopupMenuButton<String>(
                onSelected: (value) async {
                  switch (value) {
                    case 'mark_all_read':
                      await provider.markAllAsRead();
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('All notifications marked as read'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                      break;
                    case 'refresh':
                      await provider.refreshNotifications();
                      break;
                  }
                },
                itemBuilder: (context) => [
                  if (provider.unreadCount > 0)
                    const PopupMenuItem(
                      value: 'mark_all_read',
                      child: Row(
                        children: [
                          Icon(Icons.done_all),
                          SizedBox(width: 8),
                          Text('Mark all as read'),
                        ],
                      ),
                    ),
                  const PopupMenuItem(
                    value: 'refresh',
                    child: Row(
                      children: [
                        Icon(Icons.refresh),
                        SizedBox(width: 8),
                        Text('Refresh'),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: Consumer<NotificationProvider>(
        builder: (context, provider, child) {
          // Show loading indicator
          if (provider.isLoading && provider.notifications.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Show error message
          if (provider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Failed to load notifications',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    provider.error!,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => provider.refreshNotifications(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          // Show empty state
          if (provider.notifications.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_none,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No notifications yet',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'You\'ll see your notifications here when you receive them',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          // Show notifications list
          return RefreshIndicator(
            onRefresh: () => provider.refreshNotifications(),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: provider.notifications.length,
              itemBuilder: (context, index) {
                final notification = provider.notifications[index];
                final isRead = notification['isRead'] == true;
                final notificationId = notification['id'] ?? notification['_id'] ?? '';
                
                return Dismissible(
                  key: Key(notificationId),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  onDismissed: (direction) async {
                    final success = await provider.deleteNotification(notificationId);
                    if (mounted && success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Notification deleted'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  child: GestureDetector(
                    onTap: () async {
                      if (!isRead) {
                        await provider.markAsRead(notificationId);
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isRead ? Colors.white : Colors.blue.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 4,
                          ),
                        ],
                        border: Border.all(
                          color: isRead 
                            ? const Color.fromARGB(255, 129, 128, 128)
                            : Colors.blue.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage(
                                  'lib/assets/bc343ff763667486407a9dd7f8e58fd9ae581649.png'
                                ),
                              ),
                              if (!isRead)
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Container(
                                    width: 12,
                                    height: 12,
                                    decoration: const BoxDecoration(
                                      color: Colors.blue,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        notification['title'] ?? 
                                        notification['subject'] ?? 
                                        "New Notification",
                                        style: TextStyle(
                                          fontWeight: isRead 
                                            ? FontWeight.w500 
                                            : FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      _formatDate(notification['createdAt'] ?? 
                                                notification['timestamp']),
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  notification['message'] ?? 
                                  notification['body'] ?? 
                                  notification['description'] ?? 
                                  "No message content",
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  String _formatDate(dynamic dateTime) {
    if (dateTime == null) return "Unknown";
    
    try {
      DateTime date;
      if (dateTime is String) {
        date = DateTime.parse(dateTime);
      } else if (dateTime is DateTime) {
        date = dateTime;
      } else {
        return "Unknown";
      }

      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays > 0) {
        return "${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago";
      } else if (difference.inHours > 0) {
        return "${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago";
      } else if (difference.inMinutes > 0) {
        return "${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago";
      } else {
        return "Just now";
      }
    } catch (e) {
      return "Unknown";
    }
  }
}