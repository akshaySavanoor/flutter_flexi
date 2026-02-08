import 'package:flexi_ui/flexi_ui.dart';
import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart';
import 'screens/list_detail_screen.dart';
import 'screens/form_screen.dart';
import 'screens/showcase_screen.dart';
import 'screens/settings_screen.dart';

void main() {
  runApp(const FlexiExampleApp());
}

class FlexiExampleApp extends StatefulWidget {
  const FlexiExampleApp({super.key});

  @override
  State<FlexiExampleApp> createState() => _FlexiExampleAppState();
}

class _FlexiExampleAppState extends State<FlexiExampleApp> {
  bool _showDebugOverlay = true;

  void _toggleDebug(bool value) {
    setState(() {
      _showDebugOverlay = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlexiConfig(
      showDebugOverlay: _showDebugOverlay,
      // Target design dimensions
      designMinWidth: 360,
      designMaxWidth: 1440,
      child: MaterialApp(
        title: 'Flexi UI Production Example',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.indigo,
            brightness: Brightness.light,
          ),
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            elevation: 0,
          ),
        ),
        home: MainShell(
          showDebugOverlay: _showDebugOverlay,
          onToggleDebug: _toggleDebug,
        ),
      ),
    );
  }
}

class MainShell extends StatefulWidget {
  final bool showDebugOverlay;
  final ValueChanged<bool> onToggleDebug;

  const MainShell({
    super.key,
    required this.showDebugOverlay,
    required this.onToggleDebug,
  });

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const ListDetailScreen(),
    const FormScreen(),
    const ShowcaseScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return FlexiAdaptiveNav(
      mobile: Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) => setState(() => _selectedIndex = index),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.dashboard), label: 'Dashboard'),
            NavigationDestination(icon: Icon(Icons.list), label: 'Items'),
            NavigationDestination(icon: Icon(Icons.edit_note), label: 'Form'),
            NavigationDestination(icon: Icon(Icons.auto_awesome), label: 'Showcase'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          mini: true,
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SettingsScreen(
                showDebugOverlay: widget.showDebugOverlay,
                onToggleDebug: widget.onToggleDebug,
              ),
            ),
          ),
          child: const Icon(Icons.settings),
        ),
      ),
      desktop: Scaffold(
        body: Row(
          children: [
            NavigationRail(
              extended: context.flexi.screenWidth > 1200,
              selectedIndex: _selectedIndex,
              onDestinationSelected: (index) => setState(() => _selectedIndex = index),
              leading: Padding(
                padding: const EdgeInsets.all(16.0),
                child: IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsScreen(
                        showDebugOverlay: widget.showDebugOverlay,
                        onToggleDebug: widget.onToggleDebug,
                      ),
                    ),
                  ),
                ),
              ),
              labelType: context.flexi.screenWidth > 1200 
                  ? NavigationRailLabelType.none 
                  : NavigationRailLabelType.all,
              destinations: const [
                NavigationRailDestination(icon: Icon(Icons.dashboard), label: Text('Dashboard')),
                NavigationRailDestination(icon: Icon(Icons.list), label: Text('Inventory')),
                NavigationRailDestination(icon: Icon(Icons.edit_note), label: Text('Requests')),
                NavigationRailDestination(icon: Icon(Icons.auto_awesome), label: Text('Kitchen Sink')),
              ],
            ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(child: _screens[_selectedIndex]),
          ],
        ),
      ),
    );
  }
}
