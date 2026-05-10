class Order {
  final int id;
  final String trackingCode;
  final String status;
  final double fee;
  final LocationPoint origin;
  final LocationPoint destination;
  final String createdAt;

  Order({
    required this.id,
    required this.trackingCode,
    required this.status,
    required this.fee,
    required this.origin,
    required this.destination,
    required this.createdAt,
  });

  // The Factory Method: Converts raw JSON into a typed Order object
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      trackingCode: json['trackingCode'],
      status: json['status'],
      // We cast 'fee' to double safely even if it arrives as an int
      fee: (json['fee'] as num).toDouble(),
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
