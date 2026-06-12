import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/config_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  final controller = Get.find<ConfigController>();
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
      appBar: AppBar(
        title: const Text('Temple Alarm Editor'),

        actions: [
          FilledButton.icon(
            onPressed: controller.openJson,

            icon: const Icon(Icons.folder_open),

            label: const Text("Open"),
          ),

          const SizedBox(width: 8),

          FilledButton.icon(
            onPressed: controller.saveJson,

            icon: const Icon(Icons.save),

            label: const Text("Save"),
          ),

          const SizedBox(width: 16),
        ],
      ),
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
            child: Obx(() {
              if (!controller.hasConfig) {
                return const Center(child: Text("Open a JSON File"));
              }

              switch (selectedIndex) {
                case 0:
                  return Row(
                    children: [
                      SizedBox(
                        width: 280,

                        child: ListView.builder(
                          itemCount: controller.config.value!.alarms.length,

                          itemBuilder: (_, index) {
                            final alarm =
                                controller.config.value!.alarms[index];

                            return ListTile(
                              selected: controller.selectedAlarm.value == index,

                              title: Text(alarm.tit),

                              subtitle: Text(alarm.id ?? ""),

                              trailing: Switch(
                                value: alarm.state,

                                onChanged: (_) {},
                              ),

                              onTap: () {
                                controller.selectAlarm(index);
                              },
                            );
                          },
                        ),
                      ),

                      const VerticalDivider(),

                      Expanded(
                        child: Obx(() {
                          final alarm = controller
                              .config
                              .value!
                              .alarms[controller.selectedAlarm.value];

                          return Padding(
                            padding: const EdgeInsets.all(20),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text(
                                  alarm.tit,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineMedium,
                                ),

                                const SizedBox(height: 20),

                                Text("ID : ${alarm.id}"),

                                Text("Type : ${alarm.type}"),

                                Text("Enabled : ${alarm.state}"),

                                Text("SC Count : ${alarm.sc.length}"),
                              ],
                            ),
                          );
                        }),
                      ),
                    ],
                  );

                default:
                  return Center(child: Text(menu[selectedIndex]));
              }
            }),
          ),
        ],
      ),
    );
  }
}
