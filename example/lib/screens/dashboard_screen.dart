import 'package:flexi_ui/flexi_ui.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: Text(
              'Business Insights',
              style: TextStyle(
                fontSize: 24.rw(context).clamp(24, 40),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(FlexiSpacing.m(context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _HeroBanner(),
                  SizedBox(height: FlexiSpacing.l(context)),
                  Text(
                    'Key Metrics',
                    style: FlexiTextStyles.h2(context),
                  ),
                  SizedBox(height: FlexiSpacing.s(context)),
                  const _MetricsGrid(),
                  SizedBox(height: FlexiSpacing.xl(context)),
                  Text(
                    'Recent Performance',
                    style: FlexiTextStyles.h2(context),
                  ),
                  SizedBox(height: FlexiSpacing.m(context)),
                  const _PerformanceCard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroBanner extends StatelessWidget {
  const _HeroBanner();

  @override
  Widget build(BuildContext context) {
    // Demonstrating FlexiFluid3 for complex stage-based scaling
    final titleSize = const FlexiFluid3(
      mobile: 24,
      tablet: 32,
      desktop: 48,
    ).resolve(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(FlexiSpacing.xl(context)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo, Colors.indigo.shade800],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.fr(context)), // Dampened radius
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome back, Admin',
            style: TextStyle(
              color: Colors.white,
              fontSize: titleSize,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: FlexiSpacing.xs(context)),
          Text(
            'Your enterprise dashboard is ready for review. System health is optimal.',
            style: TextStyle(
              color: Colors.white.withAlpha(200),
              fontSize: 16.rw(context).clamp(14, 20),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricsGrid extends StatelessWidget {
  const _MetricsGrid();

  @override
  Widget build(BuildContext context) {
    return FlexiGrid(
      minItemWidth: 160.rw(context).clamp(140, 220),
      spacing: FlexiSpacing.m(context),
      childAspectRatio: 1.4,
      children: const [
        _MetricItem(
          label: 'Revenue',
          value: '\$42.5k',
          icon: Icons.payments,
          color: Colors.green,
        ),
        _MetricItem(
          label: 'Users',
          value: '1.2k',
          icon: Icons.people,
          color: Colors.blue,
        ),
        _MetricItem(
          label: 'Churn',
          value: '2.4%',
          icon: Icons.trending_down,
          color: Colors.red,
        ),
        _MetricItem(
          label: 'Uptime',
          value: '99.9%',
          icon: Icons.cloud_done,
          color: Colors.orange,
        ),
      ],
    );
  }
}

class _MetricItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _MetricItem({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(FlexiSpacing.m(context)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: color, size: 28.fStroke(context).clamp(24, 40)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 20.w(context).clamp(18, 28),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PerformanceCard extends StatelessWidget {
  const _PerformanceCard();

  @override
  Widget build(BuildContext context) {
    return ResponsiveCard(
      child: Container(
        height: 200.rh(context), // Adaptive height
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        padding: EdgeInsets.all(FlexiSpacing.l(context)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Conversion Rate',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text('+12.5%',
                    style: TextStyle(
                        color: Colors.green.shade700,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            const Spacer(),
            // Mock chart
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(7, (index) {
                final height = (index + 2) * 20.0;

                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 4.rw(context).clamp(2, 6)),
                    child: Container(
                      height: height.rh(context).clamp(40, 180),
                      decoration: BoxDecoration(
                        color: Colors.indigo.withAlpha(100 + (index * 20)),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
