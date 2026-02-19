import 'package:flexi_ui/flexi_ui.dart';
import 'package:flutter/material.dart';

import 'config_controller.dart';
import 'screens/dashboard_screen.dart';
import 'screens/form_screen.dart';
import 'screens/list_detail_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/showcase_screen.dart';
import 'screens/split_screen_example.dart';

void main() {
  runApp(const FlexiExampleApp());
}

final configController = FlexiConfigController();

class FlexiExampleApp extends StatelessWidget {
  const FlexiExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: configController,
      builder: (context, _) {
        return FlexiConfig(
          showDebugOverlay: configController.showDebugOverlay,
          designMinWidth: configController.designMinWidth,
          designMaxWidth: configController.designMaxWidth,
          designMinHeight: configController.designMinHeight,
          designMaxHeight: configController.designMaxHeight,
          mobilePortraitBreakpoint: configController.mobilePortraitBreakpoint,
          mobileLandscapeBreakpoint: configController.mobileLandscapeBreakpoint,
          tabletLandscapeBreakpoint: configController.tabletLandscapeBreakpoint,
          targetDevice: configController.targetDevice,
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
            home: const MainShell(),
          ),
        );
      },
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

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
    const SplitScreenExample(),
  ];

  @override
  Widget build(BuildContext context) {
    return FlexiAdaptiveNav(
      mobile: Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) =>
              setState(() => _selectedIndex = index),
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.dashboard), label: 'Dashboard'),
            NavigationDestination(icon: Icon(Icons.list), label: 'Items'),
            NavigationDestination(icon: Icon(Icons.edit_note), label: 'Form'),
            NavigationDestination(
                icon: Icon(Icons.auto_awesome), label: 'Showcase'),
            NavigationDestination(
                icon: Icon(Icons.splitscreen), label: 'Split'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          mini: true,
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SettingsScreen(controller: configController)),
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
              onDestinationSelected: (index) =>
                  setState(() => _selectedIndex = index),
              leading: Padding(
                padding: const EdgeInsets.all(16.0),
                child: IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SettingsScreen(controller: configController),
                    ),
                  ),
                ),
              ),
              labelType: context.flexi.screenWidth > 1200
                  ? NavigationRailLabelType.none
                  : NavigationRailLabelType.all,
              destinations: const [
                NavigationRailDestination(
                    icon: Icon(Icons.dashboard), label: Text('Dashboard')),
                NavigationRailDestination(
                    icon: Icon(Icons.list), label: Text('Inventory')),
                NavigationRailDestination(
                    icon: Icon(Icons.edit_note), label: Text('Requests')),
                NavigationRailDestination(
                    icon: Icon(Icons.auto_awesome),
                    label: Text('Kitchen Sink')),
                NavigationRailDestination(
                    icon: Icon(Icons.splitscreen), label: Text('Split View')),
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
