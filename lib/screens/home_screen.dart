import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  final menu = [
    'Alarm Config',
    'Song Master',
    'Silent Hours',
    'Raw JSON',
    'Settings',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: selectedIndex,

            onDestinationSelected: (index) {
              setState(() {
                selectedIndex = index;
              });
            },

            labelType: NavigationRailLabelType.all,

            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.alarm),
                label: Text('Alarm'),
              ),

              NavigationRailDestination(
                icon: Icon(Icons.music_note),
                label: Text('Songs'),
              ),

              NavigationRailDestination(
                icon: Icon(Icons.nights_stay),
                label: Text('Silent'),
              ),

              NavigationRailDestination(
                icon: Icon(Icons.code),
                label: Text('JSON'),
              ),

              NavigationRailDestination(
                icon: Icon(Icons.settings),
                label: Text('Settings'),
              ),
            ],
          ),

          const VerticalDivider(width: 1),

          Expanded(
            child: Center(
              child: Text(
                menu[selectedIndex],
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
