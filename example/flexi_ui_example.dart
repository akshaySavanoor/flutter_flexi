import 'package:flexi_ui/flexi_ui.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const FlexiConfig(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _rebuildCount = 0;

  @override
  Widget build(BuildContext context) {
    _rebuildCount++;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flexi UI Performance Demo'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Performance Proof (Resize Window!)'),
            const SizedBox(height: 10),
            const Text(
              'The green card is a heavy widget marked as "const". It should not rebuild even when the window is resized, whereas the blue card will.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _PerformanceCard(
                    title: 'Responsive Card',
                    subtitle: 'Subscribes to width',
                    color: Colors.blue.shade50,
                    child: Builder(builder: (context) {
                      return Text(
                        'Width: ${100.w(context).toStringAsFixed(1)}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      );
                    }),
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: _PerformanceCard(
                    title: 'Heavy Const Widget',
                    subtitle: 'Cached by Flutter',
                    color: Colors.green,
                    child: HeavyConstWidget(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildSectionTitle('Discrete Responsiveness'),
            const SizedBox(height: 10),
            const Text(
              'Uses BreakpointValue to change values in steps (+ color change).',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            const BreakpointDemo(),
            const SizedBox(height: 32),
            const SizedBox(height: 32),
            _buildSectionTitle('Fluid Scaling (Proportional)'),
            const SizedBox(height: 10),
            const Text(
              'Uses Tuple2.aw(context) to scale values proportionally between 360px and 1440px width.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            const FluidScalingDemo(),
            const SizedBox(height: 32),
            _buildSectionTitle('Nested Parent Scaling'),
            const SizedBox(height: 10),
            const ResponsiveLayout(
              targetWidth: 400,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: ColorGrid(),
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'HomeScreen Build Sequence: $_rebuildCount',
                  style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: -0.5),
    );
  }
}

class _PerformanceCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;
  final Color color;

  const _PerformanceCard({
    required this.title,
    required this.subtitle,
    required this.child,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(subtitle,
              style: const TextStyle(fontSize: 10, color: Colors.black54)),
          const Divider(height: 24),
          child,
        ],
      ),
    );
  }
}

class HeavyConstWidget extends StatefulWidget {
  const HeavyConstWidget({super.key});

  @override
  State<HeavyConstWidget> createState() => _HeavyConstWidgetState();
}

class _HeavyConstWidgetState extends State<HeavyConstWidget> {
  int _builds = 0;

  @override
  Widget build(BuildContext context) {
    _builds++;
    // Simulate expensive computation
    for (int i = 0; i < 500000; i++) {
      // Loop
    }
    return Column(
      children: [
        const Icon(Icons.verified, color: Colors.green, size: 32),
        const SizedBox(height: 8),
        Text(
          'Builds: $_builds',
          style: const TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
        ),
      ],
    );
  }
}

class BreakpointDemo extends StatelessWidget {
  const BreakpointDemo({super.key});

  @override
  Widget build(BuildContext context) {
    const label = BreakpointValue<String>(
      mobile: 'MOBILE',
      tablet: 'TABLET / LANDSCAPE',
      desktop: 'DESKTOP',
    );
    const bgColor = BreakpointValue<Color>(
      mobile: Colors.orange,
      tablet: Colors.blue,
      desktop: Colors.purple,
    );

    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        color: bgColor.v(context).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: bgColor.v(context), width: 2),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label.v(context),
              style: TextStyle(
                color: bgColor.v(context),
                fontSize: 24,
              ),
            ),
            const Text('Discrete Breakpoint Triggered',
                style: TextStyle(fontSize: 10)),
          ],
        ),
      ),
    );
  }
}

class ColorGrid extends StatelessWidget {
  const ColorGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _colorBlock(context, Colors.red, 100),
        const SizedBox(width: 8),
        _colorBlock(context, Colors.green, 100),
        const SizedBox(width: 8),
        _colorBlock(context, Colors.blue, 100),
      ],
    );
  }

  Widget _colorBlock(BuildContext context, Color color, double width) {
    return Expanded(
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            '${width.fw(context).toInt()}',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class FluidScalingDemo extends StatelessWidget {
  const FluidScalingDemo({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Fluid Typography
    final fontSize = 16.aw(32, context);
    // 2. Fluid Padding
    final padding = 12.aw(24, context);
    // 3. Fluid Spacing
    final spacing = 8.aw(16, context);
    // 4. Fluid Height
    final containerHeight = 120.aw(240, context);

    return Column(
      children: [
        Container(
          width: double.infinity,
          height: containerHeight,
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo.shade400, Colors.blue.shade300],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.indigo.withValues(alpha: 0.2),
                blurRadius: 15,
                offset: const Offset(0, 8),
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Universal Fluid Scaling',
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: -0.5,
                ),
              ),
              SizedBox(height: spacing),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Padding: ${padding.toStringAsFixed(1)} | Spacing: ${spacing.toStringAsFixed(1)}',
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Everything above (Font, Padding, Height, Spacing) updates with zero lag using granular width subscriptions.',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 10, color: Colors.grey, fontStyle: FontStyle.italic),
        ),
      ],
    );
  }
}
