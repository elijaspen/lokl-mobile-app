import 'package:flutter/material.dart';
import '../core/theme/colors.dart';
import '../models/job.dart';
import '../services/api_service.dart';

class RiderJobFeedScreen extends StatelessWidget {
  const RiderJobFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SwiftDropColors.background,
      appBar: _buildEarningsHeader(),
      body: FutureBuilder<List<JobModel>>(
        future: ApiService().fetchJobs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: SwiftDropColors.accentBlue));
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error: ${snapshot.error}",
                style: const TextStyle(color: SwiftDropColors.textMuted),
              ),
            );
          }

          final jobs = snapshot.data ?? [];
          
          if (jobs.isEmpty) {
            return const Center(
              child: Text(
                "No jobs available right now",
                style: TextStyle(color: SwiftDropColors.textMuted),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: jobs.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) => JobCard(job: jobs[index]),
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildEarningsHeader() {
    return AppBar(
      backgroundColor: SwiftDropColors.background,
      elevation: 0,
      centerTitle: false,
      title: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Earnings Today',
            style: TextStyle(color: SwiftDropColors.textMuted, fontSize: 12),
          ),
          Text(
            '₱1,250.00',
            style: TextStyle(
              color: SwiftDropColors.textMain,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 16),
          child: CircleAvatar(
            backgroundColor: SwiftDropColors.surface,
            child: Icon(Icons.person, color: SwiftDropColors.textMain),
          ),
        ),
      ],
    );
  }
}

class JobCard extends StatelessWidget {
  final JobModel job;

  const JobCard({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: SwiftDropColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: SwiftDropColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '₱${job.payout.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: SwiftDropColors.textMain,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: SwiftDropColors.accentBlue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '${job.distance} km',
                  style: const TextStyle(
                    color: SwiftDropColors.accentBlue,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildRouteInfo(),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: SwiftDropColors.primary,
                foregroundColor: SwiftDropColors.onPrimary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 0,
              ),
              child: const Text('Accept Job', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRouteInfo() {
    return Row(
      children: [
        const Column(
          children: [
            Icon(Icons.radio_button_checked, size: 14, color: SwiftDropColors.accentBlue),
            SizedBox(
              height: 20,
              child: VerticalDivider(
                color: SwiftDropColors.border,
                thickness: 1,
                width: 1,
              ),
            ),
            Icon(Icons.location_on, size: 14, color: SwiftDropColors.textMuted),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                job.startLocation,
                style: const TextStyle(color: SwiftDropColors.textMain, fontSize: 14),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 14),
              Text(
                job.endLocation,
                style: const TextStyle(color: SwiftDropColors.textMuted, fontSize: 14),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
