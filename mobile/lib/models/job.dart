class JobModel {
  final String id;
  final String type;
  final double payout;
  final double distance;
  final String startLocation;
  final String endLocation;
  final String category; // Added category
  final String? description;

  JobModel({
    required this.id,
    required this.type,
    required this.payout,
    required this.distance,
    required this.startLocation,
    required this.endLocation,
    required this.category,
    this.description,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json['id'].toString(),
      type: json['type'] ?? 'delivery',
      payout: (json['payout'] as num).toDouble(),
      distance: (json['distance'] as num).toDouble(),
      startLocation: json['startLocation'],
      endLocation: json['endLocation'],
      category: json['category'] ?? 'General',
      description: json['description'],
    );
  }
}
