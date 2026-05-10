class Order {
  final int id;
  final String trackingCode;
  final String type;
  final String status;
  final double fee;
  final String category; // Added category
  final String? description;
  final LocationPoint origin;
  final LocationPoint destination;
  final String createdAt;

  Order({
    required this.id,
    required this.trackingCode,
    required this.type,
    required this.status,
    required this.fee,
    required this.category,
    this.description,
    required this.origin,
    required this.destination,
    required this.createdAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      trackingCode: json['trackingCode'],
      type: json['type'] ?? 'delivery',
      status: json['status'],
      fee: (json['fee'] as num).toDouble(),
      category: json['category'] ?? 'General',
      description: json['description'],
      origin: LocationPoint.fromJson(json['origin']),
      destination: LocationPoint.fromJson(json['destination']),
      createdAt: json['createdAt'],
    );
  }
}

class LocationPoint {
  final double lat;
  final double lng;

  LocationPoint({required this.lat, required this.lng});

  factory LocationPoint.fromJson(Map<String, dynamic> json) {
    return LocationPoint(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );
  }
}
