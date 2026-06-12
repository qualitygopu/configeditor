import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/config_controller.dart';
import '../widgets/sc_editor.dart';
import '../widgets/schedule_editor.dart';

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
        title: Obx(() {
          final count = controller.config.value?.alarms.length ?? 0;

          return Text('Temple Alarm Editor ($count)');
        }),

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
          FilledButton.icon(
            onPressed: controller.addAlarm,
            icon: const Icon(Icons.add),
            label: const Text("Add Alarm"),
          ),
          const SizedBox(width: 16),
          FilledButton.icon(
            onPressed: controller.duplicateAlarm,
            icon: const Icon(Icons.copy),
            label: const Text("Duplicate"),
          ),

          const SizedBox(width: 10),

          FilledButton.icon(
            onPressed: controller.deleteAlarm,
            icon: const Icon(Icons.delete),
            label: const Text("Delete"),
          ),
          const SizedBox(width: 10),
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
                  if (controller.config.value!.alarms.isEmpty) {
                    return Center(
                      child: FilledButton.icon(
                        onPressed: controller.addAlarm,
                        icon: const Icon(Icons.add),
                        label: const Text("Create First Alarm"),
                      ),
                    );
                  }
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

                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    TextFormField(
                                      initialValue: alarm.tit,
                                      decoration: const InputDecoration(
                                        labelText: 'Title',
                                      ),
                                      onChanged: (v) {
                                        alarm.tit = v;
                                        controller.config.refresh();
                                      },
                                    ),

                                    const SizedBox(height: 16),

                                    TextFormField(
                                      initialValue: alarm.id ?? '',
                                      decoration: const InputDecoration(
                                        labelText: 'Alarm ID',
                                      ),
                                      onChanged: (v) {
                                        alarm.id = v;
                                        controller.config.refresh();
                                      },
                                    ),

                                    const SizedBox(height: 16),

                                    SwitchListTile(
                                      title: const Text('Enabled'),
                                      value: alarm.state,
                                      onChanged: (v) {
                                        alarm.state = v;
                                        controller.config.refresh();
                                      },
                                    ),
                                    DropdownButtonFormField(
                                      value: alarm.type,

                                      items: const [
                                        DropdownMenuItem(
                                          value: "time",
                                          child: Text("Time"),
                                        ),
                                      ],

                                      onChanged: (value) {
                                        alarm.type = value.toString();

                                        controller.config.refresh();
                                      },
                                    ),
                                    const SizedBox(height: 20),

                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            ScEditor(
                                              selected: alarm.sc,

                                              refresh: () {
                                                controller.config.refresh();
                                              },
                                            ),
                                            const SizedBox(height: 30),
                                            ScheduleEditor(
                                              tim: alarm.tim,
                                              refresh: () {
                                                controller.config.refresh();
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                  ],
                                ),
                              ),
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
