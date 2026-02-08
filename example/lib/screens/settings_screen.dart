import 'package:flexi_ui/flexi_ui.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  final bool showDebugOverlay;
  final ValueChanged<bool> onToggleDebug;

  const SettingsScreen({
    super.key,
    required this.showDebugOverlay,
    required this.onToggleDebug,
  });

  @override
  Widget build(BuildContext context) {
    final flexi = context.flexi;

    return Scaffold(
      appBar: AppBar(title: const Text('Diagnostics & Settings')),
      body: ListView(
        padding: EdgeInsets.all(FlexiSpacing.m(context)),
        children: [
          const _SectionTitle('Framework Status'),
          SwitchListTile(
            title: const Text('Show Debug Overlay'),
            subtitle:
                const Text('Overlays live screen metrics and scaling data.'),
            value: showDebugOverlay,
            onChanged: onToggleDebug,
          ),
          const Divider(),
          const _SectionTitle('Current Metrics'),
          _MetricTile('Active Breakpoint', flexi.breakpoint.name),
          _MetricTile('Orientation', flexi.orientation.name),
          _MetricTile('Device Type', flexi.deviceType.name),
          _MetricTile('Screen Size',
              '${flexi.screenWidth.toInt()} x ${flexi.screenHeight.toInt()}'),
          _MetricTile('DPR', flexi.devicePixelRatio.toStringAsFixed(2)),
          const Divider(),
          const _SectionTitle('Design Anchors'),
          _MetricTile('Design Min Width',
              '${flexi.deviceType == TargetDeviceType.mobilePortrait ? 360 : 1440}px'), // Fallback for demo
          const _MetricTile('Design Max Width', '1440px'),
          const Divider(),
          const _SectionTitle('Theme Tokens'),
          _MetricTile(
              'Small Spacing (s)', '${FlexiSpacing.s(context).toInt()}px'),
          _MetricTile(
              'Medium Spacing (m)', '${FlexiSpacing.m(context).toInt()}px'),
          _MetricTile(
              'Large Spacing (l)', '${FlexiSpacing.l(context).toInt()}px'),
          const SizedBox(height: 32),
          Text(
            'flexi_ui v1.1.0\nProduction Hardened',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey.shade400, fontSize: 10),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(title,
          style: const TextStyle(
              color: Colors.indigo,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2)),
    );
  }
}

class _MetricTile extends StatelessWidget {
  final String label;
  final String value;

  const _MetricTile(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label, style: const TextStyle(fontSize: 14)),
      trailing: Text(value,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              fontFamily: 'monospace')),
    );
  }
}
