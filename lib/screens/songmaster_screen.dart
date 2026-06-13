import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/config_controller.dart';

class SongMasterScreen extends StatelessWidget {
  SongMasterScreen({super.key});

  final controller = Get.find<ConfigController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!controller.hasConfig) {
        return const Center(child: Text("Open JSON File"));
      }

      final songs = controller.config.value!.songMaster;

      return Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            Row(
              children: [
                FilledButton.icon(
                  onPressed: () {
                    controller.addSong();
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Add"),
                ),

                const SizedBox(width: 10),

                FilledButton.icon(
                  onPressed: () {
                    controller.deleteLastSong();
                  },
                  icon: const Icon(Icons.delete),
                  label: const Text("Delete Last"),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Expanded(
              child: SingleChildScrollView(
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text("Count")),
                    DataColumn(label: Text("Category")),
                    DataColumn(label: Text("ID")),
                    DataColumn(label: Text("Type")),
                    DataColumn(label: Text("Name")),
                  ],

                  rows: List.generate(songs.length, (index) {
                    final row = songs[index];

                    return DataRow(
                      cells: [
                        DataCell(Text(row[0].toString())),

                        DataCell(Text(row[1].toString())),

                        DataCell(Text(row[2].toString())),

                        DataCell(Text(row[3].toString())),

                        DataCell(Text(row[4].toString())),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
