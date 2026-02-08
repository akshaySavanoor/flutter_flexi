import 'package:flexi_ui/flexi_ui.dart';
import 'package:flutter/material.dart';

class FormScreen extends StatelessWidget {
  const FormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Provision Resource')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(FlexiSpacing.m(context)),
        child: Center(
          child: FlexiMaxWidth(
            // On desktop this will center the form with 600px max width
            maxWidth: 600,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _HeaderSection(),
                SizedBox(height: FlexiSpacing.xl(context)),
                const _FormField(
                    label: 'Resource Name', hint: 'e.g. AWS-PROD-STACK'),
                SizedBox(height: FlexiSpacing.m(context)),
                const _FormField(
                    label: 'Allocation Limit',
                    hint: '0.00',
                    keyboardType: TextInputType.number),
                SizedBox(height: FlexiSpacing.m(context)),
                const _AdaptiveDropdown(
                  label: 'Compliance Tier',
                  items: ['Standard', 'High-Security', 'Government'],
                ),
                SizedBox(height: FlexiSpacing.xl(context)),
                _TermsSection(),
                SizedBox(height: FlexiSpacing.xxl(context)),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {},
                    child: const Text('Provision Now'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Demonstrating FlexiTextClamp to prevent oversized text on large screens
        FlexiTextClamp(
          maxScaleFactor: 1.2,
          child: Text(
            'New Cloud Provisioning',
            style: FlexiTextStyles.h1(context),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Fill in the details below to deploy a new infrastructure stack. Dimensions and spacing will adapt to your device.',
          style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
        ),
      ],
    );
  }
}

class _FormField extends StatelessWidget {
  final String label;
  final String hint;
  final TextInputType? keyboardType;

  const _FormField(
      {required this.label, required this.hint, this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
        const SizedBox(height: 6),
        TextField(
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: FlexiSpacing.m(context),
              vertical: FlexiSpacing.s(context),
            ),
          ),
        ),
      ],
    );
  }
}

class _AdaptiveDropdown extends StatelessWidget {
  final String label;
  final List<String> items;

  const _AdaptiveDropdown({required this.label, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: FlexiSpacing.m(context)),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: items.first,
              items: items
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (_) {},
            ),
          ),
        ),
      ],
    );
  }
}

class _TermsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FlexiMinTapTarget(
          child: Checkbox(value: true, onChanged: (_) {}),
        ),
        const Expanded(
          child: Text(
            'I agree to the enterprise resource allocation terms and service level agreements.',
            style: TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }
}
