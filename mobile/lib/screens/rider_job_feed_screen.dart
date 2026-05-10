import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import '../services/api_service.dart';
import '../models/job.dart';

class RiderJobFeedScreen extends StatefulWidget {
  const RiderJobFeedScreen({super.key});

  @override
  State<RiderJobFeedScreen> createState() => _RiderJobFeedScreenState();
}

class _RiderJobFeedScreenState extends State<RiderJobFeedScreen> {
  late Future<List<JobModel>> _jobsFuture;

  @override
  void initState() {
    super.initState();
    _refreshJobs();
  }

  void _refreshJobs() {
    setState(() {
      _jobsFuture = Provider.of<ApiService>(context, listen: false).fetchJobs();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: _buildEarningsHeader(context),
      body: RefreshIndicator(
        onRefresh: () async {
          _refreshJobs();
          await _jobsFuture;
        },
        child: FutureBuilder<List<JobModel>>(
          future: _jobsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: Center(child: Text("Error: ${snapshot.error}")),
                ),
              );
            }

            final jobs = snapshot.data ?? [];

            if (jobs.isEmpty) {
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(LucideIcons.packageSearch, size: 48, color: theme.colorScheme.outline),
                        const SizedBox(height: 16),
                        Text(
                          "No jobs available right now",
                          style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurface.withValues(alpha: 0.6)),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              itemCount: jobs.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final job = jobs[index];
                return _JobCard(job: job, onAccepted: _refreshJobs);
              },
            );
          },
        ),
      ),
    );
  }

  PreferredSizeWidget _buildEarningsHeader(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      toolbarHeight: 80,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Earnings Today',
            style: theme.textTheme.labelLarge?.copyWith(letterSpacing: 0.5),
          ),
          const SizedBox(height: 4),
          Text(
            '₱1,250.00',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w800,
              color: theme.colorScheme.onSurface,
              letterSpacing: -1,
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: CircleAvatar(
            radius: 18,
            backgroundColor: theme.colorScheme.surface,
            child: Icon(LucideIcons.user, size: 18, color: theme.colorScheme.onSurface.withValues(alpha: 0.5)),
          ),
        ),
      ],
    );
  }
}

class _JobCard extends StatefulWidget {
  final JobModel job;
  final VoidCallback onAccepted;

  const _JobCard({required this.job, required this.onAccepted});

  @override
  State<_JobCard> createState() => _JobCardState();
}

class _JobCardState extends State<_JobCard> {
  bool _isAccepting = false;

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Food': return LucideIcons.soup;
      case 'Document': return LucideIcons.fileText;
      case 'Parcel': return LucideIcons.package;
      default: return LucideIcons.helpCircle;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final apiService = Provider.of<ApiService>(context, listen: false);
    final bool isErrand = widget.job.type == 'errand';

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: (isErrand ? theme.colorScheme.secondary : theme.colorScheme.primary).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        isErrand ? LucideIcons.shoppingBag : _getCategoryIcon(widget.job.category), 
                        color: isErrand ? theme.colorScheme.secondary : theme.colorScheme.primary, 
                        size: 18
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '₱${widget.job.payout.toStringAsFixed(2)}',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              widget.job.type.toUpperCase(),
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: isErrand ? theme.colorScheme.secondary : theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 9,
                              ),
                            ),
                            Text(
                              ' • ${widget.job.category}',
                              style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurface.withValues(alpha: 0.5)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: theme.colorScheme.outline),
                  ),
                  child: Text(
                    '${widget.job.distance} km away',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            
            if (widget.job.description != null && widget.job.description!.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.all(12),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: theme.colorScheme.outline, style: BorderStyle.solid),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isErrand ? 'SHOPPING LIST / INSTRUCTIONS' : 'DELIVERY NOTES',
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.job.description!,
                      style: theme.textTheme.bodyMedium?.copyWith(height: 1.4),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 24),
            _buildRouteInfo(context, widget.job.startLocation, widget.job.endLocation),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isAccepting ? null : () async {
                  setState(() => _isAccepting = true);
                  try {
                    await apiService.acceptJob(int.parse(widget.job.id));
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Job accepted!'), behavior: SnackBarBehavior.floating),
                      );
                      widget.onAccepted();
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to accept job: $e'), backgroundColor: Colors.red),
                      );
                    }
                  } finally {
                    if (mounted) setState(() => _isAccepting = false);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isErrand ? theme.colorScheme.secondary : theme.colorScheme.primary,
                ),
                child: _isAccepting 
                  ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : Text(isErrand ? 'Accept Shopping Job' : 'Accept Delivery'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRouteInfo(BuildContext context, String start, String end) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Column(
          children: [
            Icon(LucideIcons.circleDot, size: 14, color: theme.colorScheme.primary),
            Container(
              height: 20,
              width: 1.5,
              color: theme.colorScheme.outline,
            ),
            Icon(LucideIcons.mapPin, size: 14, color: theme.colorScheme.onSurface.withValues(alpha: 0.4)),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                start,
                style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 14),
              Text(
                end,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
