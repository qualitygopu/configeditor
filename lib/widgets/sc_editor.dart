import 'package:flutter/material.dart';

import '../models/sc_master.dart';

class ScEditor extends StatelessWidget {
  final List<int> selected;
  final VoidCallback refresh;

  const ScEditor({super.key, required this.selected, required this.refresh});

  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
      shrinkWrap: true,

      onReorder: (oldIndex, newIndex) {
        if (newIndex > oldIndex) {
          newIndex--;
        }

        final item = selected.removeAt(oldIndex);

        selected.insert(newIndex, item);

        refresh();
      },

      children: [
        for (final id in selected)
          ListTile(
            key: ValueKey(id),

            title: Text(scMaster[id] ?? ""),

            leading: const Icon(Icons.drag_handle),
          ),
      ],
    );
  }
}
