import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RideOrder {
  final String orderID;
  final String driverName;
  final String carModel;
  final Color? carColor;
  final String plateNumber;
  final String status;
  final DateTime orderTime;

  RideOrder({
    required this.orderID,
    required this.driverName,
    required this.carModel,
    required this.carColor,
    required this.plateNumber,
    required this.status,
    required this.orderTime,
  });
}

class OrderHistoryPage extends StatelessWidget {
  final List<RideOrder> orders = [
    RideOrder(
      orderID: '001',
      driverName: 'John Doe',
      carModel: 'Toyota Corolla',
      carColor: Colors.black,
      plateNumber: 'ABC-123',
      status: 'Completed',
      orderTime: DateTime.now().subtract(const Duration(days: 5)),
    ),
    RideOrder(
      orderID: '002',
      driverName: 'Alice Smith',
      carModel: 'Honda Civic',
      carColor: Colors.blue,
      plateNumber: 'XYZ-789',
      status: 'Cancelled',
      orderTime: DateTime.now().subtract(const Duration(days: 2)),
    ),
    RideOrder(
      orderID: '004',
      driverName: 'Emily Johnson',
      carModel: 'Chevrolet Malibu',
      carColor: Colors.green,
      plateNumber: 'GHI-789',
      status: 'Completed',
      orderTime: DateTime.now().subtract(const Duration(days: 7)),
    ),
    RideOrder(
      orderID: '005',
      driverName: 'David Wilson',
      carModel: 'Tesla Model 3',
      carColor: Colors.grey,
      plateNumber: 'JKL-012',
      status: 'Pending',
      orderTime: DateTime.now().subtract(const Duration(days: 2)),
    ),
    RideOrder(
      orderID: '006',
      driverName: 'Sophia Brown',
      carModel: 'BMW X5',
      carColor: Colors.black,
      plateNumber: 'MNO-345',
      status: 'Cancelled',
      orderTime: DateTime.now().subtract(const Duration(days: 4)),
    ),
    RideOrder(
      orderID: '007',
      driverName: 'James Davis',
      carModel: 'Audi A4',
      carColor: Colors.blueGrey,
      plateNumber: 'PQR-678',
      status: 'pending',
      orderTime: DateTime.now().subtract(const Duration(days: 6)),
    ),
    RideOrder(
      orderID: '008',
      driverName: 'Olivia Martinez',
      carModel: 'Hyundai Elantra',
      carColor: Colors.orange,
      plateNumber: 'STU-901',
      status: 'Completed',
      orderTime: DateTime.now().subtract(const Duration(days: 9)),
    ),
  ];

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      // Add more cases for other statuses
      default:
        return Colors.grey;
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('EEEE dd/MM/yyyy hh:mm a').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (BuildContext context, int index) {
          final RideOrder order = orders[index];
          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${order.driverName} - ${order.carModel}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _formatDateTime(order.orderTime),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        order.status,
                        style: TextStyle(
                          color: _getStatusColor(order.status),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.time_to_leave, color: order.carColor), //
                      const SizedBox(width: 4),
                      Text(order.plateNumber),
                    ],
                  ),
                ],
              ),
              leading: const Icon(Icons
                  .assignment), // Use an appropriate icon for order history
              onTap: () {
                // Handle tapping on a specific order (if needed)
                print('Selected Order ID: ${order.orderID}');
              },
            ),
          );
        },
      ),
    );
  }
}
