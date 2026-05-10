import 'package:flutter/material.dart';
import '../models/order.dart';
import '../services/api_service.dart';

class OrderListScreen extends StatelessWidget {
  const OrderListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LokalLink Feed')),
      body: FutureBuilder<List<Order>>(
        future: ApiService().fetchOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final orders = snapshot.data ?? [];
          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return Card(
                child: ListTile(
                  title: Text(order.trackingCode),
                  subtitle: Text("Status: ${order.status}"),
                  trailing: Text("₱${order.fee}"),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
