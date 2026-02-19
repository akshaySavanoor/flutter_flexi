import 'package:flexi_ui/flexi_ui.dart';
import 'package:flutter/material.dart';

import '../config_controller.dart';

/// A playground screen that allows users to interactively configure
/// global [FlexiConfig] parameters.
/// 
/// This screen provides real-time adjustments to design anchors,
/// breakpoint thresholds, and targeting strategies.
class SettingsScreen extends StatefulWidget {
  /// The controller used to manage and propagate framework configuration state.
  final FlexiConfigController controller;

  const SettingsScreen({
    super.key,
    required this.controller,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) {
        final c = widget.controller;

        // Perform validation to ensure logical breakpoint consistency.
        final hasBreakpointError =
            c.mobilePortraitBreakpoint >= c.mobileLandscapeBreakpoint ||
                c.mobileLandscapeBreakpoint >= c.tabletLandscapeBreakpoint;

        return Scaffold(
          appBar: AppBar(
            title: const Text('FlexiConfig Playground'),
            actions: [
              IconButton(
                icon: const Icon(Icons.restore),
                tooltip: 'Reset to Factory Defaults',
                onPressed: () => _showResetConfirmation(context),
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.only(bottom: 100),
            children: [
              _InfoCard(
                child: Text(
                  'Customize the core architecture parameters of the Flexi UI framework. '
                  'Changes applied here dynamically propagate throughout the entire component tree.',
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                ),
              ),
              const _SectionTitle('Design Anchors'),
              _ControlSection(
                children: [
                  _ParameterControl(
                    name: 'designMinWidth',
                    description:
                        'The baseline width used for interpolation during design scaling.',
                    value: c.designMinWidth,
                    min: 300,
                    max: 600,
                    onChanged: c.updateDesignMinWidth,
                  ),
                  _ParameterControl(
                    name: 'designMaxWidth',
                    description:
                        'The upper boundary for responsive scaling interpolation.',
                    value: c.designMaxWidth,
                    min: 1000,
                    max: 2000,
                    onChanged: c.updateDesignMaxWidth,
                  ),
                ],
              ),
              const _SectionTitle('Breakpoint Thresholds'),
              if (hasBreakpointError)
                const _CautionBanner(
                  message: 'CONFIGURATION ERROR: Breakpoint sequence must remain strictly '
                      'hierarchical: Portrait < Landscape < Tablet.',
                ),
              _ControlSection(
                children: [
                  _ParameterControl(
                    name: 'mobilePortraitBreakpoint',
                    description:
                        'Dimension threshold for the Mobile Portrait layout category.',
                    value: c.mobilePortraitBreakpoint,
                    min: 400,
                    max: 800,
                    onChanged: c.updateMobilePortraitBreakpoint,
                  ),
                  _ParameterControl(
                    name: 'mobileLandscapeBreakpoint',
                    description: 'Dimension threshold for the Mobile Landscape layout category.',
                    value: c.mobileLandscapeBreakpoint,
                    min: 600,
                    max: 1000,
                    onChanged: c.updateMobileLandscapeBreakpoint,
                  ),
                  _ParameterControl(
                    name: 'tabletLandscapeBreakpoint',
                    description:
                        'Threshold for transitioning into the Desktop layout category.',
                    value: c.tabletLandscapeBreakpoint,
                    min: 900,
                    max: 1300,
                    onChanged: c.updateTabletLandscapeBreakpoint,
                  ),
                ],
              ),
              const _SectionTitle('Targeting Strategy'),
              _ControlSection(
                children: [
                  ListTile(
                    title: const Text(
                      'targetDevice',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                    subtitle: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Defines the primary design perspective for scaling algorithms.',
                          style: TextStyle(fontSize: 11),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Disabled for this demonstration (Mobile-first design reference).',
                          style: TextStyle(
                            fontSize: 10,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    trailing: DropdownButton<TargetDeviceType>(
                      value: c.targetDevice,
                      onChanged: null,
                      items: TargetDeviceType.values
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e.name),
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
              const Divider(),
              const _SectionTitle('Framework Diagnostics'),
              SwitchListTile(
                title: const Text('showDebugOverlay',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                subtitle: const Text(
                    'Enables the visual diagnostic layer displaying screen metrics and grids.',
                    style: TextStyle(fontSize: 11)),
                value: c.showDebugOverlay,
                onChanged: c.toggleDebugOverlay,
              ),
              const SizedBox(height: 32),
              _MetricSummary(flexi: Flexi.of(context)),
            ],
          ),
          bottomNavigationBar: _ApplyResetBar(
            onApply: () => Navigator.pop(context),
            onReset: () => c.reset(),
          ),
        );
      },
    );
  }

  /// Displays a confirmation dialog before resetting framework parameters.
  void _showResetConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Framework?'),
        content: const Text(
            'Restoring defaults will revert all architectural parameters to their initial production state.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('CANCEL')),
          TextButton(
            onPressed: () {
              widget.controller.reset();
              Navigator.pop(context);
            },
            child: const Text('CONFIRM RESET',
                style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

/// A stylized title for settings sections.
class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 11,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}

/// A control component for adjusting frame-level parameters via a slider.
class _ParameterControl extends StatelessWidget {
  final String name;
  final String description;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  const _ParameterControl({
    required this.name,
    required this.description,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.indigo)),
              Text('${value.toInt()}px',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontFamily: 'monospace')),
            ],
          ),
          const SizedBox(height: 4),
          Text(description,
              style: const TextStyle(fontSize: 11, color: Colors.grey)),
          Slider(
            value: value,
            min: min,
            max: max,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

/// A banner displaying high-priority warnings/cautions regarding configuration state.
class _CautionBanner extends StatelessWidget {
  final String message;

  const _CautionBanner({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning_amber_rounded, color: Colors.orange),
          const SizedBox(width: 12),
          Expanded(
              child: Text(message,
                  style: const TextStyle(
                      color: Colors.orange,
                      fontSize: 11,
                      fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }
}

/// A presentational card for general informative text.
class _InfoCard extends StatelessWidget {
  final Widget child;

  const _InfoCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }
}

/// A layout container for grouping configuration controls.
class _ControlSection extends StatelessWidget {
  final List<Widget> children;

  const _ControlSection({required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(children: children),
    );
  }
}

/// A footer component presenting a snapshot of current architectural metrics.
class _MetricSummary extends StatelessWidget {
  final ScreenAdaptiveData flexi;

  const _MetricSummary({required this.flexi});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      color: Colors.grey.shade50,
      child: Column(
        children: [
          const Text('ARCHITECTURAL SNAPSHOT',
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: Colors.grey)),
          const SizedBox(height: 16),
          _SmallMetric(
              label: 'Active Breakpoint', value: flexi.breakpoint.name),
          _SmallMetric(
              label: 'Screen Dimensions',
              value:
                  '${flexi.screenWidth.toInt()} x ${flexi.screenHeight.toInt()}'),
          const SizedBox(height: 24),
          const Text('flexi_ui v1.2.3\nPRODUCTION ENGINE',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 9, color: Colors.grey, height: 1.5)),
        ],
      ),
    );
  }
}

/// A small row component for metric-based data.
class _SmallMetric extends StatelessWidget {
  final String label;
  final String value;

  const _SmallMetric({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(fontSize: 12, color: Colors.black54)),
          Text(value.toUpperCase(),
              style:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

/// A persistent bottom bar for applying or resetting global configurations.
class _ApplyResetBar extends StatelessWidget {
  final VoidCallback onApply;
  final VoidCallback onReset;

  const _ApplyResetBar({required this.onApply, required this.onReset});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withAlpha(5),
              blurRadius: 10,
              offset: const Offset(0, -5))
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: onReset,
              style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('RESET ALL'),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: onApply,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
              ),
              child: const Text('APPLY'),
            ),
          ),
        ],
      ),
    );
  }
}
