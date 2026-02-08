import 'package:flexi_ui/flexi_ui.dart';
import 'package:flutter/material.dart';

class ListDetailScreen extends StatefulWidget {
  const ListDetailScreen({super.key});

  @override
  State<ListDetailScreen> createState() => _ListDetailScreenState();
}

class _ListDetailScreenState extends State<ListDetailScreen> {
  int? _selectedId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory Management'),
      ),
      body: FlexiLayout(
        // On Mobile, we show only the list.
        mobile: _InventoryList(
          selectedId: _selectedId,
          onSelected: (id) {
            setState(() => _selectedId = id);
            // Navigate on mobile
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => _MobileDetailScreen(id: id),
              ),
            );
          },
        ),
        // On Tablet/Desktop, we show split pane.
        tablet: Row(
          children: [
            SizedBox(
              width: 300.rw(context).clamp(250, 400),
              child: _InventoryList(
                selectedId: _selectedId,
                onSelected: (id) => setState(() => _selectedId = id),
              ),
            ),
            const VerticalDivider(width: 1),
            Expanded(
              child: _selectedId == null
                  ? const Center(child: Text('Select an item to view details'))
                  : _DetailView(id: _selectedId!),
            ),
          ],
        ),
        desktop: Row(
          children: [
            SizedBox(
              width: 400.rw(context).clamp(300, 600),
              child: _InventoryList(
                selectedId: _selectedId,
                onSelected: (id) => setState(() => _selectedId = id),
              ),
            ),
            const VerticalDivider(width: 1),
            Expanded(
              child: _selectedId == null
                  ? const Center(child: Text('Select an item to view details'))
                  : _DetailView(id: _selectedId!),
            ),
          ],
        ),
      ),
    );
  }
}

class _InventoryList extends StatelessWidget {
  final int? selectedId;
  final ValueChanged<int> onSelected;

  const _InventoryList({required this.selectedId, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 20,
      separatorBuilder: (_, __) => const Divider(height: 1, indent: 16),
      itemBuilder: (context, index) {
        final id = index + 1;
        final isSelected = id == selectedId;
        return ListTile(
          selected: isSelected,
          tileColor: isSelected ? Theme.of(context).colorScheme.primaryContainer : null,
          title: Text('Enterprise Asset #$id'),
          subtitle: Text('Status: ${index % 3 == 0 ? "Maintenance" : "Active"}'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => onSelected(id),
        );
      },
    );
  }
}

class _DetailView extends StatelessWidget {
  final int id;
  const _DetailView({required this.id});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(FlexiSpacing.xl(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 60.rw(context).clamp(48, 80),
                height: 60.rw(context).clamp(48, 80),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.inventory_2, color: Colors.indigo, size: 32.fStroke(context).clamp(24, 48)),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Asset Details', style: FlexiTextStyles.h1(context)),
                  Text('ID: SKU-FLEXI-$id', style: TextStyle(color: Colors.grey.shade600)),
                ],
              ),
            ],
          ),
          SizedBox(height: FlexiSpacing.xl(context)),
          _DetailInfoRow(label: 'Location', value: 'Warehouse ${id % 5 + 1}'),
          _DetailInfoRow(label: 'Last Check', value: 'Feb ${id + 1}, 2026'),
          _DetailInfoRow(label: 'Condition', value: id % 7 == 0 ? 'Critical' : 'Excellent'),
          const Spacer(),
          FlexiMinTapTarget(
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {},
                child: const Text('Log Maintenance'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailInfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _DetailInfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(value, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}

class _MobileDetailScreen extends StatelessWidget {
  final int id;
  const _MobileDetailScreen({required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Asset #$id')),
      body: _DetailView(id: id),
    );
  }
}
