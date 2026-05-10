import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/order.dart';
import '../models/job.dart';

class ApiService {
  final String baseUrl = "http://127.0.0.1:8000/api";
  final String? authToken;

  ApiService({this.authToken});

  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    if (authToken != null) 'Authorization': 'Bearer $authToken',
  };

  Future<List<Order>> fetchOrders() async {
    final response = await http.get(Uri.parse('$baseUrl/orders'), headers: _headers);

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body);
      final List<dynamic> data = body['data'];
      return data.map((item) => Order.fromJson(item)).toList();
    } else {
      throw Exception("Failed to load orders");
    }
  }

  Future<List<JobModel>> fetchJobs() async {
    final response = await http.get(Uri.parse('$baseUrl/jobs'), headers: _headers);

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
      headers: _headers,
      body: jsonEncode(orderData),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body);
      return Order.fromJson(body['data']);
    } else {
      throw Exception("Failed to create order");
    }
  }

  Future<Order> acceptJob(int orderId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/jobs/$orderId/accept'),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body);
      return Order.fromJson(body['data']);
    } else {
      throw Exception("Failed to accept job: ${response.body}");
    }
  }
}
