import 'package:flexi_ui/flexi_ui.dart';
import 'package:flutter/material.dart';

/// A screen demonstrating the framework's ability to handle independent
/// responsive contexts within a split-view layout.
/// 
/// This example leverages [FlexiConfig] with `useParentConstraints: true`
/// to isolate responsiveness to individual panels rather than the global screen.
class SplitScreenExample extends StatefulWidget {
  const SplitScreenExample({super.key});

  @override
  State<SplitScreenExample> createState() => _SplitScreenExampleState();
}

class _SplitScreenExampleState extends State<SplitScreenExample> {
  double _splitRatio = 0.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Split Screen Responsiveness'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Reset Split',
            onPressed: () => setState(() => _splitRatio = 0.5),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final totalWidth = constraints.maxWidth;
          final leftWidth = totalWidth * _splitRatio;
          final rightWidth = totalWidth - leftWidth;

          return Stack(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: leftWidth,
                    child: _ResponsivePanel(
                      title: 'Panel A',
                      color: Colors.indigo.shade50,
                      accentColor: Colors.indigo,
                    ),
                  ),
                  SizedBox(
                    width: rightWidth,
                    child: _ResponsivePanel(
                      title: 'Panel B',
                      color: Colors.teal.shade50,
                      accentColor: Colors.teal,
                    ),
                  ),
                ],
              ),
              Positioned(
                left: leftWidth - 15,
                top: 0,
                bottom: 0,
                child: GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    setState(() {
                      _splitRatio += details.delta.dx / totalWidth;
                      _splitRatio = _splitRatio.clamp(0.1, 0.9);
                    });
                  },
                  child: MouseRegion(
                    cursor: SystemMouseCursors.resizeLeftRight,
                    child: Container(
                      width: 30,
                      color: Colors.transparent,
                      child: Center(
                        child: Container(
                          width: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey.withAlpha(100),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// An isolated responsive container that adapts based on its local constraints.
class _ResponsivePanel extends StatelessWidget {
  final String title;
  final Color color;
  final Color accentColor;

  const _ResponsivePanel({
    required this.title,
    required this.color,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return FlexiConfig(
      // Enable per-panel responsiveness by using parent constraints
      useParentConstraints: true,
      child: Container(
        color: color,
        child: Column(
          children: [
            _PanelHeader(title: title, accentColor: accentColor),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const _LocalMetricsHUD(),
                    const SizedBox(height: 24),
                    _ResponsiveContent(accentColor: accentColor),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A header component displaying the panel title and an adaptive breakpoint badge.
class _PanelHeader extends StatelessWidget {
  final String title;
  final Color accentColor;

  const _PanelHeader({required this.title, required this.accentColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: accentColor.withAlpha(40))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: accentColor,
              fontSize: 16,
            ),
          ),
          _AdaptiveBadge(accentColor: accentColor),
        ],
      ),
    );
  }
}

/// A badge that dynamically displays the active breakpoint of the local [FlexiConfig] context.
class _AdaptiveBadge extends StatelessWidget {
  final Color accentColor;

  const _AdaptiveBadge({required this.accentColor});

  @override
  Widget build(BuildContext context) {
    final breakpoint = context.flexi.breakpoint;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: accentColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        breakpoint.name.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

/// A Head-Up Display (HUD) presenting local screen metrics for diagnostic purposes.
class _LocalMetricsHUD extends StatelessWidget {
  const _LocalMetricsHUD();

  @override
  Widget build(BuildContext context) {
    final flexi = context.flexi;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _MetricRow(
              label: 'PANEL WIDTH',
              value: '${flexi.screenWidth.toStringAsFixed(1)}px'),
          _MetricRow(
              label: 'ORIENTATION',
              value: flexi.orientation.name.toUpperCase()),
          _MetricRow(
              label: 'MOBILE', value: flexi.isMobile.toString().toUpperCase()),
        ],
      ),
    );
  }
}

/// A row component for displaying a specific metric label and value.
class _MetricRow extends StatelessWidget {
  final String label;
  final String value;

  const _MetricRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                  fontWeight: FontWeight.bold)),
          Text(value,
              style: const TextStyle(
                  color: Colors.white, fontSize: 10, fontFamily: 'monospace')),
        ],
      ),
    );
  }
}

/// A grid of responsive content cards.
class _ResponsiveContent extends StatelessWidget {
  final Color accentColor;

  const _ResponsiveContent({required this.accentColor});

  @override
  Widget build(BuildContext context) {
    return FlexiGrid(
      minItemWidth: 140,
      spacing: 12,
      childAspectRatio: 1.2,
      children: List.generate(
          6, (index) => _ContentCard(index: index, accentColor: accentColor)),
    );
  }
}

/// A card component displaying generic content for demonstration.
class _ContentCard extends StatelessWidget {
  final int index;
  final Color accentColor;

  const _ContentCard({required this.index, required this.accentColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.widgets, color: accentColor.withAlpha(150)),
          const SizedBox(height: 8),
          Text(
            'Item ${index + 1}',
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
