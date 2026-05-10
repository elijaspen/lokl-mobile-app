import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/order.dart';
import '../models/job.dart';

class ApiService {
  // 127.0.0.1 refers to your MacBook when running in the Simulator
  final String baseUrl = "http://127.0.0.1:8000/api";

  Future<List<Order>> fetchOrders() async {
    final response = await http.get(Uri.parse('$baseUrl/orders'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body);
      final List<dynamic> data = body['data'];
      return data.map((item) => Order.fromJson(item)).toList();
    } else {
      throw Exception("Failed to load orders");
    }
  }

  Future<List<JobModel>> fetchJobs() async {
    final response = await http.get(Uri.parse('$baseUrl/jobs'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body);
      final List<dynamic> data = body['data'];
      return data.map((item) => JobModel.fromJson(item)).toList();
    } else {
      throw Exception("Failed to load jobs");
    }
  }

  Future<Order> createOrder(Map<String, dynamic> orderData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/orders'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(orderData),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body);
      return Order.fromJson(body['data']);
    } else {
      throw Exception("Failed to create order");
    }
  }
}
