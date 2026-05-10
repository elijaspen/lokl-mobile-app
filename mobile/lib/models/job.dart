class JobModel {
  final String id;
  final double payout;
  final double distance;
  final String startLocation;
  final String endLocation;

  JobModel({
    required this.id,
    required this.payout,
    required this.distance,
    required this.startLocation,
    required this.endLocation,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json['id'].toString(),
      payout: (json['payout'] as num).toDouble(),
      distance: (json['distance'] as num).toDouble(),
      startLocation: json['startLocation'],
      endLocation: json['endLocation'],
    );
  }
}
