import 'package:flexi_ui/flexi_ui.dart';
import 'package:flutter/material.dart';

class ShowcaseScreen extends StatelessWidget {
  const ShowcaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Elite Toolkit Showcase')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(FlexiSpacing.m(context)),
        child: const Column(
          children: [
            _MotionDemo(),
            Divider(),
            _ScalingExtensionsDemo(),
            Divider(),
            _VisibilityDemo(),
            Divider(),
            _AdaptiveMiscDemo(),
          ],
        ),
      ),
    );
  }
}

class _MotionDemo extends StatefulWidget {
  const _MotionDemo();

  @override
  State<_MotionDemo> createState() => _MotionDemoState();
}

class _MotionDemoState extends State<_MotionDemo> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return _Section(
      title: 'Adaptive Motion',
      child: Column(
        children: [
          Text(
            'Durations adapt to device feel: '
            '${FlexiMotion.durationShort(context).inMilliseconds}ms / '
            '${FlexiMotion.durationMedium(context).inMilliseconds}ms',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () => setState(() => _expanded = !_expanded),
            child: AnimatedContainer(
              duration: FlexiMotion.durationMedium(context),
              curve: Curves.easeInOut,
              width: _expanded ? 200.rw(context) : 100.rw(context),
              height: 100,
              decoration: BoxDecoration(
                color: _expanded ? Colors.indigo : Colors.indigo.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  _expanded ? 'Tap to Shrink' : 'Tap to Grow',
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScalingExtensionsDemo extends StatelessWidget {
  const _ScalingExtensionsDemo();

  @override
  Widget build(BuildContext context) {
    return _Section(
      title: 'Scaling Extensions',
      child: Column(
        children: [
          _ScalingRow(
            label: 'Diagonal (.d)',
            desc: 'Scales based on screen diagonal.',
            widget: Container(
              width: const Tuple2(50.0, 50.0).d(context),
              height: const Tuple2(50.0, 50.0).d(context),
              color: Colors.amber,
              child: const Center(child: Icon(Icons.star)),
            ),
          ),
          const SizedBox(height: 16),
          _ScalingRow(
            label: 'Aspect (.aw)',
            desc: 'Interpolates across design range.',
            widget: Container(
              width: const Tuple2(100.0, 300.0).aw(context),
              height: 40,
              color: Colors.green.shade100,
              alignment: Alignment.center,
              child: const Text('Linear Interpolation'),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _ScalingRow(
                  label: 'Radius (.fr)',
                  desc: 'Dampened scaling.',
                  widget: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(20.fr(context)),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: _ScalingRow(
                  label: 'Stroke (.fStroke)',
                  desc: 'Heavy dampening.',
                  widget: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.blue, width: 4.fStroke(context)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _VisibilityDemo extends StatelessWidget {
  const _VisibilityDemo();

  @override
  Widget build(BuildContext context) {
    return const _Section(
      title: 'Conditional Visibility',
      child: Column(
        children: [
          Text('Efficiently removes widgets from build tree:',
              style: TextStyle(fontSize: 12)),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FlexiVisibility(
                tablet: false,
                desktop: false,
                child: _Indicator(label: 'MOBILE ONLY', color: Colors.orange),
              ),
              FlexiVisibility(
                mobile: false,
                desktop: false,
                child: _Indicator(label: 'TABLET ONLY', color: Colors.teal),
              ),
              FlexiVisibility(
                mobile: false,
                tablet: false,
                child: _Indicator(label: 'DESKTOP ONLY', color: Colors.indigo),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AdaptiveMiscDemo extends StatelessWidget {
  const _AdaptiveMiscDemo();

  @override
  Widget build(BuildContext context) {
    return _Section(
      title: 'Adaptive Helpers',
      child: Column(
        children: [
          _ScalingRow(
            label: 'Tap Target',
            desc: 'Enforces 48dp on small icons.',
            widget: FlexiMinTapTarget(
              child: ColoredBox(
                color: Colors.red.withAlpha(30),
                child:
                    IconButton(onPressed: () {}, icon: const Icon(Icons.close)),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const _ScalingRow(
            label: 'Adaptive Nav',
            desc: 'Pattern logic indicator.',
            widget: FlexiAdaptiveNav(
              mobile: Text('📱 Mobile Mode Active',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              tablet: Text('Tablet Mode Active',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              desktop: Text('💻 Desktop Mode Active',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final Widget child;

  const _Section({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: FlexiTextStyles.h2(context)),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _ScalingRow extends StatelessWidget {
  final String label;
  final String desc;
  final Widget widget;

  const _ScalingRow(
      {required this.label, required this.desc, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(desc,
                  style: const TextStyle(fontSize: 11, color: Colors.grey)),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Center(child: widget),
        ),
      ],
    );
  }
}

class _Indicator extends StatelessWidget {
  final String label;
  final Color color;

  const _Indicator({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
      child: Text(label,
          style: const TextStyle(
              color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }
}
