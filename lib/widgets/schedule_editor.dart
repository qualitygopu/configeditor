import 'package:flutter/material.dart';

class ScheduleEditor extends StatelessWidget {
  final List<dynamic> tim;
  final VoidCallback refresh;

  const ScheduleEditor({super.key, required this.tim, required this.refresh});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Schedule", style: Theme.of(context).textTheme.titleLarge),

        const SizedBox(height: 20),

        _minuteEditor(),

        const SizedBox(height: 20),

        _hourEditor(),

        const SizedBox(height: 20),

        _weekDayEditor(),
      ],
    );
  }

  Widget _minuteEditor() {
    return Row(
      children: [
        const SizedBox(width: 120, child: Text("Minute")),

        SizedBox(
          width: 100,
          child: TextFormField(
            initialValue: tim[0][0].toString(),
            onChanged: (v) {
              tim[0][0] = int.tryParse(v) ?? 0;
              refresh();
            },
          ),
        ),
      ],
    );
  }

  Widget _hourEditor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        const Text("Hour Ranges"),

        const SizedBox(height: 10),

        ...List.generate(tim[1].length, (index) {
          return Row(
            children: [
              SizedBox(
                width: 80,
                child: TextFormField(
                  initialValue: tim[1][index][0].toString(),

                  onChanged: (v) {
                    tim[1][index][0] = int.tryParse(v) ?? 0;

                    refresh();
                  },
                ),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text("-"),
              ),

              SizedBox(
                width: 80,
                child: TextFormField(
                  initialValue: tim[1][index][1].toString(),

                  onChanged: (v) {
                    tim[1][index][1] = int.tryParse(v) ?? 0;

                    refresh();
                  },
                ),
              ),

              IconButton(
                onPressed: () {
                  tim[1].removeAt(index);

                  refresh();
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          );
        }),

        FilledButton.icon(
          onPressed: () {
            tim[1].add([6, 6]);

            refresh();
          },

          icon: const Icon(Icons.add),

          label: const Text("Add Hour"),
        ),
      ],
    );
  }

  Widget _weekDayEditor() {
    const names = {
      1: "Sun",
      2: "Mon",
      3: "Tue",
      4: "Wed",
      5: "Thu",
      6: "Fri",
      7: "Sat",
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        const Text("Week Days"),

        Wrap(
          children: [
            for (final day in names.keys)
              SizedBox(
                width: 120,

                child: CheckboxListTile(
                  title: Text(names[day]!),

                  value: tim[4].contains(day),

                  onChanged: (v) {
                    if (v == true) {
                      tim[4].add(day);
                    } else {
                      tim[4].remove(day);
                    }

                    refresh();
                  },
                ),
              ),
          ],
        ),
      ],
    );
  }
}
